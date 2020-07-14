import { NativeModules } from 'react-native';

type ApprovalParams = {
  merchantId: string;
  isSandbox: boolean;
  phoneNumber: number;
  email: string;
  params: object;
};

type SimplZeroClickSdkType = {
  isUserApproved(
    approvalParams: ApprovalParams,
    successCallback: (
      approved: boolean,
      isFirstTransaction: boolean,
      buttonText: string
    ) => void,
    errorCallback: (errorMessage: string) => void
  ): void;

  isApproved(
    merchantId: string,
    mobileNumber: string,
    emailId: string,
    isSandbox: boolean,
    successCallback: (
      approved: boolean,
      isFirstTransaction: boolean,
      buttonText: string
    ) => void,
    errorCallback: (errorMessage: string) => void
  ): void;

  generateZeroClickToken(
    successCallback: (token: string) => void,
    errorCallback: (errorMessage: string) => void
  ): void;

  openRedirectionURL(
    url: string,
    successCallback: (successMessage: string) => void,
    errorCallback: (errorMessage: string) => void
  ): void;

  generateFingerprint(
    merchantId: string,
    mobileNumber: string,
    emailId: string,
    merchantParams: object,
    callback: (fingerprint: string) => void
  ): void;
};

export default NativeModules.SimplSdk as SimplZeroClickSdkType;
