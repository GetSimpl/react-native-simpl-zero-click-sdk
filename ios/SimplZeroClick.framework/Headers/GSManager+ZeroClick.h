//
//  GSManager+ZeroClick.h
//  GetSimpl
//
//  Created by Alok Jha on 03/04/17.
//  Copyright © 2017 Simpl. All rights reserved.
//
#import "GSUser.h"
#import "GSManager.h"


@interface GSManager (ZeroClick)

/**
 Generates the token for the given user.
 
 On successful flow jsonResponse in Completion block will contain zero_click_token 
 
 @param user       A GSUser object encapsulating the user data
 @param completion  Completion block for the response with following arguments  : NSDictionary jsonResponse , NSError error
 */

-(void)generateTokenForUser:(GSUser * __nonnull)user onCompletion : (void (^ __nonnull)(NSDictionary * _Nullable jsonResponse, NSError * _Nullable error))completion ;


/**
 Opens the redirection_url received when charging the zero_click_token.
 
 @param urlString   The url string to open
 @param completion  Completion block for the response with following arguments  : NSDictionary jsonResponse , NSError error
 */
-(void)openRedirectionURL:(NSString * __nonnull)urlString onCompletion:(void (^ __nonnull)(NSDictionary * _Nullable jsonResponse, NSError * _Nullable error))completion ;

/**
 Generates fingerprint data for the device.
 
 @param user   User object
 @param completion  Completion block for the response with following argument: NSDictionary fpData
 */
-(void)generateFingerprintForUser:(GSUser * __nonnull)user onCompletion : (void (^ __nonnull)(NSString * _Nullable fingerprint)) completion ;

@end
