# Naija Transfer

## Overview

Naija Transfer is a decentralized remittance system built on the Stacks blockchain, designed to facilitate low-cost money transfers from the Nigerian diaspora back to Nigeria. This project aims to provide a secure, efficient, and cost-effective way for Nigerians working abroad to send money back home.

## Features

- User registration with Nigerian bank account details
- Deposit functionality in STX (Stacks cryptocurrency)
- Remittance sending with automatic fee calculation
- Dynamic exchange rate management
- Withdrawal functionality (linked to off-chain processes)
- Balance checking and user details retrieval

## Technology Stack

- Smart Contract: Clarity (Stacks blockchain)
- Frontend: React.js
- Backend: Node.js
- Blockchain Interaction: Stacks.js

## Smart Contract

The core of Naija Transfer is a Clarity smart contract deployed on the Stacks blockchain. Key functions include:

- `register-user`: Allow users to register with their name and Nigerian bank account details
- `deposit`: Enable users to add funds to their account
- `send-remittance`: Facilitate the transfer of funds between users
- `withdraw`: Initiate the process of withdrawing funds to a Nigerian bank account
- `get-balance`: Check the balance of a user's account
- `get-exchange-rate`: Retrieve the current STX to Naira exchange rate

## How to Use

1. **Setup**:
   - Clone the repository
   - Install dependencies for both frontend and backend
   - Configure environment variables

2. **Smart Contract Deployment**:
   - Deploy the Clarity smart contract to the Stacks blockchain (testnet first, then mainnet)

3. **Running the Application**:
   - Start the backend server
   - Launch the frontend application

4. **User Journey**:
   - Register an account
   - Connect your Stacks wallet
   - Deposit STX into your account
   - Send remittances to registered Nigerian recipients
   - Withdraw funds to your registered Nigerian bank account

## Development

To contribute to Naija Transfer:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

## Security Considerations

- The smart contract should undergo a thorough security audit before mainnet deployment
- Users should be educated on safe key management practices
- Regular updates to the exchange rate are crucial for fair valuations

## Regulatory Compliance

Naija Transfer aims to comply with relevant Nigerian financial regulations. Users are responsible for ensuring their use of the platform complies with local laws regarding international money transfers.

## Future Enhancements

- Integration with multiple Nigerian banks for direct transfers
- Support for multiple cryptocurrencies
- Mobile application for easier access
- Implementation of a decentralized exchange rate oracle

## Disclaimer

Naija Transfer is a prototype and should not be used for actual financial transactions without proper legal and financial advice. The creators are not responsible for any loss of funds or legal implications arising from the use of this system.

## Contact

For more information or to contribute to the project, please contact geakande@gmail.com .
