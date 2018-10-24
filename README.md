## React Native Library for Simpl Zero Click Sdk
This project serves as a wrapper for Simpl Zero Click native sdk.

## Installation

Using npm:

```shell
npm install --save react-native-simpl-zero-click-sdk
```

or using yarn:

```shell
yarn add react-native-simpl-zero-click-sdk
```

## Linking

Run the following command to link the SDK to Android and iOS

```shell
react-native link react-native-simpl-zero-click-sdk
```

## Add native SDK
### Android
Add the following to `android/app/build.gradle`:
  ```gradle
  ...

  repositories {
      maven { url "http://maven.getsimpl.com"}
  }

  dependencies {
      ...
      compile project(':react-native-simpl-zero-click-sdk')
      compile "com.simpl.android:zeroClicksdk:1.0.18"
  }
  ```
### iOS
If you are using Cocoapods, Add native ZeroClick SDK to your Podfile

`pod 'SimplZeroClick'`

Then run,

`pod install`

If you are not using Cocoapods, Link the Framework from [here](https://github.com/GetSimpl/simpl-zeroclick-ios-sdk) manually.

## Usage

```javascript
import SimplSdk from 'react-native-simpl-zero-click-sdk'
//To check either user is approved or not
SimplSdk.isApproved('<merchant_id>', '<phone_number>', '<email>', true /*To test in sandbox mode*/,
      (approved) => console.log(`User approved: ${approved}`) /* true if user is approved, false otherwise */,
      (errorMessage) => console.log(`User approval error: ${errorMessage}`) /* error occured during network call */);

//To generate zero-click token
SimplSdk.generateZeroClickToken((token) => console.log(token), (errorMessage) => console.log(errorMessage))

//To open redirection URL
SimplSdk.openRedirectionURL(urlString, (successMessage) => console.log(successMessage), (errorMessage) => console.log(errorMessage));
```
