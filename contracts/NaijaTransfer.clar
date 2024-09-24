;; Naija Transfer - Remittance Smart Contract

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-invalid-rate (err u104))
(define-constant err-insufficient-balance (err u105))
(define-constant err-invalid-amount (err u106))
(define-constant err-transfer-failed (err u107))

;; Define data variables
(define-data-var exchange-rate uint u0) ;; Rate in basis points (1/10000 of a unit)
(define-data-var last-update-time uint u0)
(define-data-var update-interval uint u3600) ;; Update interval in seconds (1 hour default)
(define-data-var transfer-fee uint u0)

;; Define a map to store user balances
(define-map balances {user: principal} {balance: uint})

;; Define a map to store user details
(define-map user-details {user: principal} {name: (string-ascii 50), nigeria-bank-account: (string-ascii 20)})

;; Function to get the balance of a user
(define-read-only (get-balance (user principal))
  (default-to u0 (get balance (map-get? balances {user: user})))
)

;; Define functions to get and set exchange rate
(define-read-only (get-exchange-rate)
  (ok (var-get exchange-rate)))

(define-public (set-exchange-rate (new-rate uint))
  (let ((current-time (unwrap-panic (get-block-info? time (- block-height u1)))))
    (if (and 
          (is-eq tx-sender contract-owner)
          (> new-rate u0)
          (> current-time (+ (var-get last-update-time) (var-get update-interval))))
      (begin
        (var-set exchange-rate new-rate)
        (var-set last-update-time current-time)
        (ok true))
      (err err-invalid-rate))))

(define-public (set-update-interval (new-interval uint))
  (if (is-eq tx-sender contract-owner)
    (begin
      (var-set update-interval new-interval)
      (ok true))
    (err err-owner-only)))

(define-read-only (get-user-details (user principal))
  (map-get? user-details {user: user}))

;; Public functions
(define-public (register-user (name (string-ascii 50)) (bank-account (string-ascii 20)))
  (begin
    (map-set user-details {user: tx-sender} {name: name, nigeria-bank-account: bank-account})
    (ok true)))

(define-public (deposit (amount uint))
  (let ((current-balance (get-balance tx-sender)))
    (if (> amount u0)
      (begin
        (map-set balances {user: tx-sender} {balance: (+ current-balance amount)})
        (ok true))
      (err err-invalid-amount))))

(define-public (send-remittance (recipient principal) (amount-stx uint))
  (let 
    (
      (sender-balance (get-balance tx-sender))
      (fee (/ (* amount-stx (var-get transfer-fee)) u10000))
      (total-amount (+ amount-stx fee))
      (naira-amount (* amount-stx (var-get exchange-rate)))
    )
    (if (<= total-amount sender-balance)
      (if (is-some (get-user-details recipient))
        (begin
          (map-set balances {user: tx-sender} {balance: (- sender-balance total-amount)})
          (map-set balances {user: recipient} {balance: (+ (get-balance recipient) amount-stx)})
          (map-set balances {user: contract-owner} {balance: (+ (get-balance contract-owner) fee)})
          ;; Here you would typically emit an event with the naira-amount
          (ok naira-amount))
        (err err-transfer-failed))
      (err err-insufficient-balance))))

(define-public (withdraw (amount uint))
  (let ((current-balance (get-balance tx-sender)))
    (if (<= amount current-balance)
      (begin
        (map-set balances {user: tx-sender} {balance: (- current-balance amount)})
        ;; Here you would typically integrate with an off-chain system or oracle
        ;; to initiate the actual bank transfer in Nigeria
        (ok true))
      (err err-insufficient-balance))))

;; Admin functions
(define-public (set-transfer-fee (new-fee uint))
  (if (is-eq tx-sender contract-owner)
    (begin
      (var-set transfer-fee new-fee)
      (ok true))
    (err err-owner-only)))
