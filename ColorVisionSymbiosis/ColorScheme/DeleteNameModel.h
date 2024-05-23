//
//  DeleteNameModel.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/16.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeleteNameModel : JSONModel

@property (nonatomic, copy)NSArray* data;
@property (nonatomic, copy)NSString* message;

@end

NS_ASSUME_NONNULL_END
