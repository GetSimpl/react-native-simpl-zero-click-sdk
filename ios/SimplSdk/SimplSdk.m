#import "SimplSdk.h"
#import <SimplZeroClick/SimplZeroClick.h>
#import <SimplZeroClick/GSUser.h>

@interface SimplSdk()
@property (nonatomic) GSUser *user;
@end

@implementation SimplSdk

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(isApproved:(NSString *)merchantId mobileNumber:(NSString *)mobileNumber emailId:(NSString *)emailId isSandbox:(BOOL)isSandbox successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback) {
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

}

RCT_EXPORT_METHOD(generateZeroClickToken:(RCTResponseSenderBlock)successCallback errorCallback: (RCTResponseSenderBlock)errorCallback) {
    [[GSManager sharedManager] generateTokenForUser:self.user onCompletion:^(NSDictionary * _Nullable jsonResponse, NSError * _Nullable error) {
        if(error != nil) {
            errorCallback(@[[error localizedDescription]]);
        } else {
            successCallback(@[jsonResponse[@"data"][@"zero_click_token"]]);
        }
    }];
}

RCT_EXPORT_METHOD(openRedirectionURL:(NSString *)url successCallback:(RCTResponseSenderBlock)successCallback errorCallback:(RCTResponseSenderBlock)errorCallback) {
    [[GSManager sharedManager] openRedirectionURL: url onCompletion:^(NSDictionary * _Nullable jsonResponse, NSError * _Nullable error){
        if(error != nil) {
            errorCallback(@[[error localizedDescription]]);
        } else {
            successCallback(@[jsonResponse[@"data"][@"message"]]);
        }
    }];
}

RCT_EXPORT_METHOD(generateFingerprint:(NSDictionary *)merchantParams (NSString *)merchantId mobileNumber:(NSString *)mobileNumber emailId:(NSString *)emailId callback:(RCTResponseSenderBlock)callback) {
    [GSManager initializeWithMerchantID:merchantId];
    self.user = [[GSUser alloc] initWithPhoneNumber:mobileNumber email:emailId];
    self.user.headerParams = merchantParams;
    
    [[GSManager sharedManager] generateFingerprintForUser: self.user onCompletion:^(NSDictionary * _Nullable fpData, NSError * _Nullable error){
        if(error != nil) {
            errorCallback(@[[error localizedDescription]]);
        } else {
            successCallback(@[fpData]);
        }
    }];
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
@end
