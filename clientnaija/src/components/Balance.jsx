import React, { useState, useEffect } from 'react';
import { useConnect } from '@stacks/connect-react';
import { StacksMainnet } from '@stacks/network';
import { callReadOnlyFunction } from '@stacks/transactions';
import { contractAddress, contractName } from '../utils/constants';

const Balance = ({ userData }) => {
  const [balance, setBalance] = useState(null);
  const { doContractCall } = useConnect();

  useEffect(() => {
    const fetchBalance = async () => {
      try {
        const balanceResult = await callReadOnlyFunction({
          contractAddress,
          contractName,
          functionName: 'get-balance',
          functionArgs: [userData.profile.stxAddress],
          network: new StacksMainnet(),
        });
        setBalance(balanceResult.value.toString());
      } catch (e) {
        console.error('Error fetching balance:', e);
      }
    };

    fetchBalance();
  }, [userData]);

  return (
    <div className="balance-container">
      <h2>Your Balance</h2>
      {balance !== null ? (
        <p>{balance} STX</p>
      ) : (
        <p>Loading balance...</p>
      )}
    </div>
  );
};

export default Balance;
