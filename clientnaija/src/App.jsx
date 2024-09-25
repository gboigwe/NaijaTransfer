import React, { useState, useEffect } from 'react';
import { Connect } from '@stacks/connect-react';
import { UserSession, AppConfig } from '@stacks/auth';
import Header from './components/Header';
import Footer from './components/Footer';
import Balance from './components/Balance';
import ExchangeRateProvider from './components/ExchangeRateProvider';
import Registration from './components/Registration';
import SendRemittance from './components/SendRemittance';
import TransactionHistory from './components/TransactionHistory';
import WalletConnection from './components/WalletConnection';

const App = () => {
  const [userData, setUserData] = useState(null);
  const [currentView, setCurrentView] = useState('wallet');

  const appConfig = new AppConfig(['store_write', 'publish_data']);
  const userSession = new UserSession({ appConfig });

  useEffect(() => {
    if (userSession.isSignInPending()) {
      userSession.handlePendingSignIn().then(userData => {
        setUserData(userData);
      });
    } else if (userSession.isUserSignedIn()) {
      setUserData(userSession.loadUserData());
    }
  }, []);

  const handleSignOut = () => {
    userSession.signUserOut();
    setUserData(null);
  };

  return (
    <Connect authOptions={{
      appDetails: {
        name: 'Naija Transfer',
        icon: 'https://example.com/icon.png',
      },
      redirectTo: '/',
      onFinish: () => {
        setUserData(userSession.loadUserData());
      },
      userSession: userSession,
    }}>
      <div className="app">
        <Header userData={userData} onSignOut={handleSignOut} setCurrentView={setCurrentView} />
        <main>
          {!userData ? (
            <WalletConnection />
          ) : (
            <>
              {currentView === 'balance' && <Balance userData={userData} />}
              {currentView === 'exchange' && <ExchangeRateProvider />}
              {currentView === 'register' && <Registration userData={userData} />}
              {currentView === 'send' && <SendRemittance userData={userData} />}
              {currentView === 'history' && <TransactionHistory userData={userData} />}
            </>
          )}
        </main>
        <Footer />
      </div>
    </Connect>
  );
};

export default App;
