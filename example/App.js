/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import { Platform, StyleSheet, Text, View, Button } from 'react-native';
import SimplSdk from 'react-native-simpl-zero-click-sdk';

type Props = {};
export default class App extends Component<Props> {

  constructor(props) {
    super(props);
    this.state = {
      isSimplApproved: false,
      zeroClickToken: '',
      fpData: ''
    }

  }

  componentDidMount() {
    SimplSdk.isApproved('<merchant_id>', '2212345678', 'email@example.com', true, (approved) => {
      console.log("approved: " + approved);
      this.setState({ isSimplApproved: approved });
    }, (error) => {
      this.setState({ isSimplApproved: false });
    });
  }

  simplButton() {
    if (this.state.isSimplApproved === true) {
      return <Button title='Link Simpl' style={styles.button} onPress={() => {
        SimplSdk.generateZeroClickToken((zeroClickToken) => {
          this.setState({ zeroClickToken });
          console.log(zeroClickToken); //pass this token to your server
        }, (errorMessage) => {
          this.setState({ zeroClickToken: errorMessage });
          console.log(errorMessage); //handle error
        })
      }} />;
    } else {
      return <Text> Simpl approval failed </Text>;
    }
  }

  zeroClickToken() {
    if (this.state.zeroClickToken) {
      return `Token: ${this.state.zeroClickToken}`
    } else {
      '';
    }
  }

  generateFingerprint = () => {
    SimplSdk.generateFingerprint('<merchant_id>', '2212345678', 'email@example.com',
      { sample_merchant_param1: 'value1', sample_merchant_param2: 'value2', sample_merchant_param3: 'value3' },
      (encodedFpData) => {
        console.log(encodedFpData)
        this.setState({
          fpData: encodedFpData
        })
      })
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.text}>Simpl Zero Click Demo!</Text>
        {this.simplButton()}
        <Text style={styles.text}>{this.zeroClickToken()}</Text>
        <Button style={styles.button} title='Get Fingerprint' onPress={this.generateFingerprint} />
        <Text style={styles.fptext}>{this.state.fpData}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  text: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  },
  fptext: {
    fontSize: 14,
    textAlign: 'center',
    margin: 10
  },
  button: {
    margin: 10
  }
});
