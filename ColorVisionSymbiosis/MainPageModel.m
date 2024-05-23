//
//  MainPageModel.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import "MainPageModel.h"

@implementation MainPageModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.collectionArray = @[@"", @"", @"", @"", @"", @""];
    }
    return self;
}

@end
