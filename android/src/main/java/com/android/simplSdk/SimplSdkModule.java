package com.android.simplSdk;

import android.util.Log;

import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.simpl.android.fingerprint.SimplFingerprint;
import com.simpl.android.fingerprint.SimplFingerprintListener;
import com.simpl.android.zeroClickSdk.Simpl;
import com.simpl.android.zeroClickSdk.SimplPaymentDueListener;
import com.simpl.android.zeroClickSdk.SimplPaymentUrlRequest;
import com.simpl.android.zeroClickSdk.SimplUser;
import com.simpl.android.zeroClickSdk.SimplUserApprovalListenerV2;
import com.simpl.android.zeroClickSdk.SimplZeroClickTokenAuthorization;
import com.simpl.android.zeroClickSdk.SimplZeroClickTokenListener;
import com.simpl.android.zeroClickSdk.SimplUserApprovalRequest;

import java.util.HashMap;

public class SimplSdkModule extends ReactContextBaseJavaModule {
    private static final String TAG = SimplSdkModule.class.getSimpleName();

    public SimplSdkModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName(){
        return "SimplSdk";
    }

    @ReactMethod
    public void isUserApproved(final ReadableMap map, final Callback successCallback, final Callback errorCallback){
        final ReadableMap paramsMap = map.getMap("params");
        try {
            Simpl.init(getReactApplicationContext(), map.getString("merchantId"));
            if (map.getBoolean("isSandbox"))
                Simpl.getInstance().runInSandboxMode();

            SimplUser user = new SimplUser(map.getString("email"), map.getString("phone_number"));
            SimplUserApprovalRequest simplUserApprovalRequest = Simpl.getInstance().isUserApproved(user);
            simplUserApprovalRequest = addParams(paramsMap, simplUserApprovalRequest);
            simplUserApprovalRequest.execute(new SimplUserApprovalListenerV2() {
                    @Override
                    public void onSuccess(final boolean isUserApproved, String buttonText, boolean showSimplIntroduction){
                        successCallback.invoke(isUserApproved, showSimplIntroduction, buttonText);
                    }
                    @Override
                    public void onError(Throwable throwable){
                        errorCallback.invoke(throwable.getMessage());
                    }
                });
        } catch(Exception ex){
            errorCallback.invoke(ex.getMessage());
        }

    }

    private SimplUserApprovalRequest addParams(ReadableMap map, SimplUserApprovalRequest simplUserApprovalRequest){
        ReadableMapKeySetIterator iterator = map.keySetIterator();
        while(iterator.hasNextKey()) {
            String key = iterator.nextKey();
            simplUserApprovalRequest.addParam(key, MapUtils.getValueAsString(map, key));
        }

        return simpl;
    }

    @ReactMethod
    public void isApproved(final String merchantId, final String mobileNumber, final String emailId, final boolean isSandbox,
                           final Callback successCallback, final Callback errorCallback) {
        try {
            Simpl.init(getReactApplicationContext(), merchantId);
            Log.d(TAG, "isApproved(): merchantId: " + merchantId + " mobileNumber: " + mobileNumber + " emailId: " + emailId);
            if (isSandbox)
                Simpl.getInstance().runInSandboxMode();
            Simpl.getInstance().isUserApproved(new SimplUser(emailId, mobileNumber))
                .execute(new SimplUserApprovalListenerV2() {
                        @Override
                        public void onSuccess(final boolean b, String s, boolean b1) {
                            successCallback.invoke(b);
                        }

                        @Override
                        public void onError(Throwable throwable) {
                            errorCallback.invoke(throwable.getMessage());
                        }
                    });
        }catch(Exception ex){
            errorCallback.invoke(ex.getMessage());
        }
    }

    @ReactMethod
    public void generateZeroClickToken(final Callback successCallback, final Callback errorCallback) {
        try {
            Simpl.getInstance().generateZeroClickToken(new SimplZeroClickTokenListener() {
                    @Override
                    public void onSuccess(SimplZeroClickTokenAuthorization simplZeroClickTokenAuthorization) {
                        successCallback.invoke(simplZeroClickTokenAuthorization.getZeroClickToken());
                    }

                    @Override
                    public void onFailure(Throwable throwable) {
                        errorCallback.invoke(throwable.getMessage());
                    }
                });
        } catch(Exception ex){
            errorCallback.invoke(ex.getMessage());
        }
    }

    @ReactMethod
    public void openRedirectionURL(final String paymentRedirectionUrl, final Callback successCallback, final Callback errorCallback) {
        try {
             SimplPaymentUrlRequest request = Simpl.getInstance().openRedirectionURL(getReactApplicationContext(), paymentRedirectionUrl);
        request.execute(new SimplPaymentDueListener() {
                @Override
                public void onSuccess(String message) {
                    successCallback.invoke(message);
                }

                @Override
                public void onError(final Throwable throwable) {
                    errorCallback.invoke(throwable.getMessage());
                }
            });
        } catch(Exception ex){
            errorCallback.invoke(ex.getMessage());
        }

    }

    @ReactMethod
    public void generateFingerprint(final String merchantId, final String phoneNo, final String email, final ReadableMap merchantParams, final Callback callback) {
        HashMap<String, String> params = merchantParams != null ? MapUtils.toHashMap(merchantParams) : new HashMap<String, String>();
        params.put("merchant", merchantId );
        params.put("phone_number", phoneNo);
        params.put("email", email );
        try {
           SimplFingerprint.getInstance().generateFingerprint(new SimplFingerprintListener() {
                    @Override
                   public void fingerprintData(String fingerprint) {
                       callback.invoke(fingerprint);
                    }
               }, params);
        } catch(Exception ex){
            callback.invoke(ex.getMessage());
        }
    }

}
