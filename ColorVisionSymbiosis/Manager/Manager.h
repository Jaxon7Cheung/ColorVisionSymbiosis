//
//  Manager.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/26.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "RegisterModel.h"
#import "ColorGameTopScoreModel.h"
#import "ColorSchemeModel.h"
#import "AddNameModel.h"
#import "DeleteNameModel.h"

#import "ColorTestModel.h"
#import "OptionModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LoginModelBlock)(LoginModel* loginModel, NSString* token);
typedef void(^RegisterModelBlock)(RegisterModel* registerModel);
typedef void(^CodeModelBlock)(CodeModel* codeModel);
typedef void(^LoginByCodeBlock)(LoginByCodeModel* loginByCodeModel, NSString* token);
typedef void(^ColorGameBlock)(ColorGameTopScoreModel* colorGameModel);
typedef void(^ColorModelBlock)(ColorSchemeModel *colorModel);
typedef void(^AddNameBlock)(AddNameModel* addNameModel);
typedef void(^DeleteNameBlock)(DeleteNameModel* deleteNameModel);
typedef void(^ErrorBlock)(NSError* error);

typedef void(^TestModelBlock)(ColorTestModel *colorTestModel);
typedef void(^OptionModelBlock)(OptionModel* optionModel);

@interface Manager : NSObject

+ (instancetype)sharedManager;

- (void)requestLoginInfoWithPhone: (NSString *)phone andPassword: (NSString *)password success: (LoginModelBlock)sucess failure: (ErrorBlock)failure;

- (void)requestRegisterInfoWithPhone: (NSString *)phone Password: (NSString *)password andConfirmPassword: (NSString *)confirmPassword success: (RegisterModelBlock)success failure: (ErrorBlock)failure;

- (void)requestCodeInfoWithPhone: (NSString *)phone success: (CodeModelBlock)success failure: (ErrorBlock)failure;

- (void)requestLoginByCodeInfoWithPhone: (NSString *)phone andCode: (NSString *)password success: (LoginByCodeBlock)success failure: (ErrorBlock)failure;

- (void)postTopScore: (NSString *)score withToken: (NSString *)token;
- (void)requestTopScoreWithToken: (NSString *)token sucess:(ColorGameBlock)success failure:(ErrorBlock)failure;

- (void)requestColoringScheme: (NSString *)token success: (ColorModelBlock)success failure: (ErrorBlock)failure;
- (void)requestResultForAddingName:(NSString *)name withToken: (NSString *)token success:(AddNameBlock)success failure:(ErrorBlock)failure;
- (void)requestResultForDeletingName:(NSString *)name withToken: (NSString *)token success:(DeleteNameBlock)success failure:(ErrorBlock)failure;

- (void)writeTokenToPreference: (NSString *)token;



- (void)requestColorBlindTest: (NSString *)token success:(TestModelBlock)success failure:(ErrorBlock)failure;

- (void)postColorBlindOptionArray: (NSString *)token success:(OptionModelBlock)success failure:(ErrorBlock)failure didSelectOption:(NSArray *)optionArray;

@end

NS_ASSUME_NONNULL_END
