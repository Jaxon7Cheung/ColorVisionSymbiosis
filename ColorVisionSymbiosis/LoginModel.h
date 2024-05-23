//
//  LoginModel.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : JSONModel

@property (nonatomic, assign)NSString* message;

@end

@interface CodeModel : JSONModel

@property (nonatomic, assign)NSString* message;

@end

@interface LoginByCodeModel : JSONModel

@property (nonatomic, assign)NSString* message;

@end

NS_ASSUME_NONNULL_END
