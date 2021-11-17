import React, {useEffect} from 'react';
import {View, Button} from 'react-native';
import Zendesk from './rn-zendesk';

const ZendeskTest = () => {
  useEffect(() => {
    try {
      Zendesk.initialize({
        accountKey: 'prwbD4xLbNy2zMvZQqTfnxeo0YUI6guH',
        appId: 'c9f8f44c39936b31c253fcbe2ce2681f51af0eeec37c93bc',
        clientId: 'mobile_sdk_client_a8358f5ec79795f14efc',
        zendeskUrl: 'https://playground6140.zendesk.com',
      });

      Zendesk.setUserIdentity({email: 'test@example.com', name: 'Test'});
      console.log('passed init');
    } catch (error) {
      console.log('🚀 ~ file: App.js ~ line 188 ~ useEffect ~ error', error);
    }
  }, []);

  const showGuides = async () => {
    try {
      Zendesk.showGuides();
    } catch (error) {
      console.log('🚀  ~ showGuides ~ error', error);
    }
  };

  const showTicketList = async () => {
    try {
      Zendesk.showTicketList();
    } catch (error) {
      console.log('🚀  ~ showTicketList ~ error', error);
    }
  };

  const addNewTicket = async () => {
    try {
      Zendesk.showTicketCreation({
        subject: 'Demo',
        tags: ['ios', 'testing'],
      });
    } catch (error) {
      console.log('🚀  ~ addNewTicket ~ error', error);
    }
  };

  const showLiveChat = async () => {
    try {
      Zendesk.showLiveChat({});
    } catch (error) {
      console.log('🚀  ~ showLiveChat ~ error', error);
    }
  };

  const createTicket = async () => {
    try {
      await Zendesk.createTicket({
        tags: ['test'],
        subject: 'Ticket created via api',
        description: 'test description',
      });
      alert('Created');
    } catch (error) {
      console.log(
        '🚀 ~ file: index.js ~ line 67 ~ createTicket ~ error',
        error,
      );
      alert(error.message);
    }
  };
  return (
    <View
      style={{
        width: '100%',
        height: '100%',
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
      }}>
      <Button
        style={{
          width: '100%',
          height: 100,
          backgroundColor: 'red',
          marginHorizontal: 64,
          marginVertital: 10,
        }}
        onPress={showGuides}
        title="Knownledge Base"
      />
      <Button
        style={{
          width: '100%',
          height: 100,
          backgroundColor: 'red',
          marginHorizontal: 64,
          marginVertital: 10,
        }}
        onPress={showTicketList}
        title="Ticket List"
      />
      <Button
        style={{
          width: '100%',
          height: 100,
          backgroundColor: 'red',
          marginHorizontal: 64,
          marginVertital: 10,
        }}
        onPress={addNewTicket}
        title="New Ticket"
      />
      <Button
        style={{
          width: '100%',
          height: 100,
          backgroundColor: 'red',
          marginHorizontal: 64,
          marginVertital: 10,
        }}
        onPress={showLiveChat}
        title="Live Chat (with Chatbot)"
      />
      <Button
        style={{
          width: '100%',
          height: 100,
          backgroundColor: 'red',
          marginHorizontal: 64,
          marginVertital: 10,
        }}
        onPress={createTicket}
        title="Create ticket via API"
      />
    </View>
  );
};

export default ZendeskTest;
