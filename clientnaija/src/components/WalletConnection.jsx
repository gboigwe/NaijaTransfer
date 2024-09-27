import React from 'react';
import { useConnect } from '@stacks/connect-react';

const WalletConnection = () => {
  const { doOpenAuth } = useConnect();

  return (
    <div className="wallet-connection-container">
      <h2>Connect Your Wallet</h2>
      <p>To use Naija Transfer, please connect your Stacks wallet.</p>
      <button onClick={doOpenAuth}>Connect Wallet</button>
    </div>
  );
};

export default WalletConnection;
