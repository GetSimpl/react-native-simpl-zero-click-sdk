//
//  GSManager.h
//  GetSimpl
//
//  Created by Alok Jha on 15/02/16.
//  Copyright © 2016 Simpl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSUser.h"

@interface GSManager : NSObject

/**
 Initilaze the SDK with your merchantID .This should happen typically in your applications didFinishLaunchingWithOptions method.

 @param merchantID Your merchantID
 */
+ (void)initializeWithMerchantID:(NSString * __nonnull)merchantID;


/**
 Toggle between sandbox or production environment for SDK.

 @param enable Boolean variable to toggle
 */
+ (void)enableSandBoxEnvironment:(BOOL)enable;

/**
 Shared instance for GSManager. Use this instance to make all subsequent calls.

 @return GSManager instance.
 */
+ (GSManager * __nonnull)sharedManager;

/**
 MerchantId for the merchant
 */
@property (nonatomic, readonly, copy) NSString * __nullable merchantID;

/**
 Boolean to check whether sandBoxEnvironment is enabled or not
 */
@property (nonatomic, readonly) BOOL isSandBoxEnvironmentEnabled;

/**
 Checks for approval status of a User
 
 Completion block will contain following arguments in order: 
 
 Bool approved :  If GSUser is approved or not.
 
 Bool isFirstTransactionOfUser :  If user has already done transactions.
 
 NSString buttonText : The text to display on Simpl button. If GSUser is approved,this will contain a value specific to merchant with default value of "Buy Now, Pay Later". Will be nil if GSUser is not approved.
 
 NSError error : Error if any

 @param user       A GSUser object encapsulating the user data
 @param completion Completion block for the response
 */
- (void)checkApprovalForUser:(GSUser * __nonnull)user onCompletion:(void (^ __nonnull)(BOOL approved, BOOL isFirstTransactionOfUser, NSString * __nullable buttonText, NSError * __nullable error))completion;



@end
