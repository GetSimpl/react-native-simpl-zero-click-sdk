import SimplSDK from 'react-native-simpl-zero-click-sdk';

function useSimpl({ clientId, isSandbox, phoneNumber, email }) {
  const getSimplFingerprintData = () =>
    new Promise((res) =>
      SimplSDK.getSimplFingerprint(clientId, phoneNumber, email, (fpData) =>
        res(fpData)
      )
    );

  const isUserApproved = (params) =>
    new Promise((res, rej) =>
      SimplSDK.isUserApproved(
        clientId,
        isSandbox,
        phoneNumber,
        email,
        params,
        (approved) => res(approved),
        (error) => rej(error)
      )
    );

  const generateZeroClickToken = (params) =>
    new Promise((res, rej) =>
      SimplSDK.generateZeroClickToken(
        (token) => res(token),
        (error) => rej(error)
      )
    );

  return {
    getSimplFingerprintData,
    isUserApproved,
    generateZeroClickToken,
  };
}

export { useSimpl };
