//
//  shuju3.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface shuju3 : NSObject

@property (nonatomic, strong) NSMutableArray* titleArray;
@property (nonatomic, strong) NSMutableArray* contentArray;
@property (nonatomic, strong) NSArray *authorArray;

- (instancetype)initWithIndex: (NSInteger)index;

@end

NS_ASSUME_NONNULL_END
