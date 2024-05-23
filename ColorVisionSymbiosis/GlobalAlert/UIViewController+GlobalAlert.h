//
//  UIViewController+GlobalAlert.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GlobalAlert)

- (void)showAlertWithTitle: (NSString *)title andMessage: (NSString *)message;

@end

NS_ASSUME_NONNULL_END
