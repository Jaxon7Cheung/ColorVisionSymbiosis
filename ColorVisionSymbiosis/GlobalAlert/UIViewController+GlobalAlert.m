//
//  UIViewController+GlobalAlert.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/10.
//

#import "UIViewController+GlobalAlert.h"

@implementation UIViewController (GlobalAlert)

- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle: title message: message preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle: @"好的" style: UIAlertActionStyleCancel handler: nil];
    [alertController addAction: cancelAction];
    
    [self presentViewController: alertController animated: YES completion: nil];
}



@end
