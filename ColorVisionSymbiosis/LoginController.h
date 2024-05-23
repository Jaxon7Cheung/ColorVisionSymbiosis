//
//  LoginController.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "Manager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginController : UIViewController

@property (nonatomic, strong)Manager* manager;

@property (nonatomic, strong)LoginView* loginView;

@end

NS_ASSUME_NONNULL_END
