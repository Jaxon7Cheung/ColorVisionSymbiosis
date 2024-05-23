//
//  LoginModel.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import "LoginModel.h"

@implementation LoginModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation CodeModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation LoginByCodeModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
