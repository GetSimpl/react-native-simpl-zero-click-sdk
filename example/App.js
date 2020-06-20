import React, { useState } from 'react';
import { StyleSheet, Text, View, Button } from 'react-native';
import { useSimpl } from './useSimpl';

function ZeroClickToken({ generateZeroClickToken }) {
  const [token, setToken] = useState('');

  return (
    <>
      <Button
        onPress={() => generateZeroClickToken().then(setToken)}
        title="Generate ZeroClick Token"
      />
      <Text style={styles.text}>{token}</Text>
    </>
  );
}

function FPData({ getSimplFingerprintData }) {
  const [fpData, setFPData] = useState('');

  return (
    <>
      <Button
        onPress={() => getSimplFingerprintData().then(setFPData)}
        title="Generate FP Data"
      />
      <Text style={styles.text}>{fpData}</Text>
    </>
  );
}

export default function App() {
  const { generateZeroClickToken, getSimplFingerprintData } = useSimpl({
    clientId: '<client-id>',
    isSandbox: true,
    phoneNumber: '<phone-number>',
    email: '<email>',
  });

  return (
    <View style={styles.container}>
      <Text style={styles.text}>Simpl ZeroClick Demo!</Text>
      <ZeroClickToken generateZeroClickToken={generateZeroClickToken} />
      <FPData getSimplFingerprintData={getSimplFingerprintData} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  text: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  fptext: {
    fontSize: 14,
    textAlign: 'center',
    margin: 10,
  },
  button: {
    margin: 10,
  },
});
