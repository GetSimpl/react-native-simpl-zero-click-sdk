//
//  GSUser.h
//  GetSimpl
//
//  Created by Alok Jha on 15/02/16.
//  Copyright © 2016 Simpl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSUser : NSObject

/// Convenience initializer of GSUser
///
/// \param phoneNumber Phone number of the user
///
/// \param email Email id of the user
- (nonnull instancetype)initWithPhoneNumber:(NSString * __nonnull)phoneNumber email:(NSString * __nonnull)email;


/// Email id of the user
@property (nonatomic, copy) NSString * __nullable email;

/// Phone number of the user.
@property (nonatomic, copy) NSString * __nonnull phoneNumber;


/// Extra properties of GSUser to be set as Key-Value pairs. Example of some keys are : transaction_amount_in_paise, wallet_balance,failed_transaction_bank_name, user_location, theatre_location,member_since, signed_in 
@property (nonatomic, copy) NSDictionary<NSString *, id> * __nullable headerParams;
@end
