//
//  RegisterController.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/30.
//

#import <UIKit/UIKit.h>
#import "RegisterView.h"
#import "Manager.h"

NS_ASSUME_NONNULL_BEGIN

@interface RegisterController : UIViewController

@property (nonatomic, strong)Manager* manager;
@property (nonatomic, strong)RegisterView* registerView;

@end

NS_ASSUME_NONNULL_END
