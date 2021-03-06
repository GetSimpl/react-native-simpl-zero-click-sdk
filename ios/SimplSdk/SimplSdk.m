#import "SimplSdk.h"
#import <SimplZeroClick/SimplZeroClick.h>
#import <SimplZeroClick/GSUser.h>

@interface SimplSdk()
@property (nonatomic) GSUser *user;
@end

@implementation SimplSdk

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(isUserApproved:(NSDictionary *)approvalParams successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback){
    @try{
        [GSManager initializeWithMerchantID: approvalParams[@"merchantId"]];
        [GSManager enableSandBoxEnvironment: [approvalParams[@"isSandbox"] boolValue]];
        self.user= [[GSUser alloc] initWithPhoneNumber:approvalParams[@"phone_number"] email:approvalParams[@"email"]];
        NSDictionary *params = approvalParams[@"params"];
        [self.user setHeaderParams:params];
        [[GSManager sharedManager] checkApprovalForUser:self.user onCompletion:^(BOOL approved, BOOL isFirstTransactionOfUser, NSString*  buttonText, NSError*  error) {
            if(error != nil) {
                errorCallback(@[[error localizedDescription]]);
            } else {
               successCallback(@[@(approved), @(isFirstTransactionOfUser), buttonText]);
            }
        }];
    } @catch(NSException * ex) {
        errorCallback(@[[ex reason]]);
    }
}

RCT_EXPORT_METHOD(isApproved:(NSString *)merchantId mobileNumber:(NSString *)mobileNumber emailId:(NSString *)emailId isSandbox:(BOOL)isSandbox successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseErrorBlock)errorCallback) {
    @try {
      [GSManager initializeWithMerchantID:merchantId];
      [GSManager enableSandBoxEnvironment:isSandbox];
      self.user = [[GSUser alloc] initWithPhoneNumber:mobileNumber email:emailId];
      [[GSManager sharedManager] checkApprovalForUser:self.user onCompletion:^(BOOL approved, BOOL isFirstTransactionOfUser, NSString * _Nullable buttonText, NSError * _Nullable error) {
        if(error != nil) {
             errorCallback(@[[error localizedDescription]]);
        } else {
            successCallback(@[@(approved)]);
        }
      }];
    }@catch (NSException * ex){
      errorCallback(@[[ex reason]]);
    }
}

RCT_EXPORT_METHOD(generateZeroClickToken:(RCTResponseSenderBlock)successCallback errorCallback: (RCTResponseSenderBlock)errorCallback) {
  @try {
    [[GSManager sharedManager] generateTokenForUser:self.user onCompletion:^(NSDictionary * _Nullable jsonResponse, NSError * _Nullable error) {
        if(error != nil) {
            errorCallback(@[[error localizedDescription]]);
        } else {
            successCallback(@[jsonResponse[@"data"][@"zero_click_token"]]);
        }
    }];
  } @catch(NSException * ex){
    errorCallback(@[[ex reason]]);
  }
}

RCT_EXPORT_METHOD(openRedirectionURL:(NSString *)url successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback) {
  @try{
    [[GSManager sharedManager] openRedirectionURL: url onCompletion:^(NSDictionary * _Nullable jsonResponse, NSError * _Nullable error){
        if(error != nil) {
            errorCallback(@[[error localizedDescription]]);
        } else {
            successCallback(@[jsonResponse[@"data"][@"message"]]);
        }
    }];
  }@catch(NSException * ex){
    errorCallback(@[[ex reason]]);
  }
}

RCT_EXPORT_METHOD(generateFingerprint:(NSString *)merchantId mobileNumber:(NSString *)mobileNumber
                  emailId:(NSString *)emailId merchantParams:(NSDictionary *)merchantParams callback:(RCTResponseSenderBlock)callback) {
  @try{
    [GSManager initializeWithMerchantID:merchantId];
    self.user = [[GSUser alloc] initWithPhoneNumber:mobileNumber email:emailId];
    self.user.headerParams = merchantParams;
    
    [[GSManager sharedManager] generateFingerprintForUser: self.user onCompletion:^(NSString * _Nullable fpData){
        if(fpData == nil)
            callback(@[@""]);
        else
            callback(@[fpData]);
    }];
  }@catch(NSException * ex){
    callback(@[[ex reason]]);
  }
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
@end
