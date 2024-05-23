//
//  ColorSchemeModel.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/15.
//

#import "ColorSchemeModel.h"

@implementation ColorSchemeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.nameArray = [[NSMutableArray alloc] init];
        self.rgbArray = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
