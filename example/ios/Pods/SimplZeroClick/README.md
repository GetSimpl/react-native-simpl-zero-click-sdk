# simpl-zeroclick-ios-sdk


## How to install

### CocoaPods :
[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

 ````
 $ gem install cocoapods
 ````
To integrate GetSimpl into your Xcode project using CocoaPods, specify it in your Podfile: 

 ````
 pod 'SimplZeroClick'
 ````

Then, run the following command:

 ````
 $ pod install
 ````

## Integration

* Add the following to your Info.plist file:


````
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>smpYourMerchantID</string>
    </array>
  </dict>
</array>
````

Note that you must add your merchantID in `smpYourMerchantID` such as `smp55d72761ec60ytbnk97414182`.

* For iOS 9+ also add the following to your Info.plist file :

````
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
      <key>getsimpl.com</key>
      <dict>
        <key>NSExceptionAllowsInsecureHTTPLoads</key>
        <true/>
        <key>NSIncludesSubdomains</key>
        <true/>
        <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
        <false/>
      </dict>
    </dict>  
</dict>
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>simplApp</string>
</array>
````


## Initialization

* Import the Library :

	````
	import SimplZeroClick 
	````
	
* Initialise the SDK with your merchantID, typically in your applications didFinishLaunchingOptions method:

	````
	GSManager.initialize(withMerchantID: "Your merchant id")
	````
* To run Simpl in Sandbox mode

   ```
   GSManager.enableSandBoxEnvironment(true)
   ```


## Implemtation of Simpl Payment option

* Check if user is pre-approved:

	````
	 let user = GSUser(phoneNumber: phone , email: email )
	 
	 GSManager.shared().checkApproval(for: user) { (approved, firstTransaction, text, error) in
	 } 
	````
      approved : If GSUser is pre-approved or not
      
      isFirstTransactionOfUser : If user has already done transactions previously or not
      
      buttonText : The text to display on Simpl button. If GSUser is pre-approved,this will contain a value specific to merchant with default value of "Buy Now, Pay Later". Will be nil if GSUser is not pre-approved.
     
      error : Error if any
 
  If the user is approved then show Simpl button to the user.

* To show Simpl option, merchants can use their own custom button. However they should use ```` buttonText ```` value from approval call above to display the text on the button.

## To get the subscription token: 

```swift
let user = GSUser(phoneNumber: "user phonenumber", email: "user email")

GSManager.shared().generateToken(for: user) { (jsonResponse, error) in 

//On successful generation of token :

        { 
          status: 'success',
          data: {
            zero_click_token: 'xyz'
          }
        }

}
```

### Launching the REDIRECTION URL(In case of Payment due/ Limit exceed)

```swift
GSManager.shared().openRedirectionURL(paymentRedirectionUrl, onCompletion: { (response, error) in 
 
 //In case payment is done :
       {
           status: 'success',
           data: {
               message: 'Payment received'
           }
       }
       
 //In case the pending due flow is aborted :
 
       {
           status: 'error',
           errors: ['Payment Failed!']
       }      

}
```



