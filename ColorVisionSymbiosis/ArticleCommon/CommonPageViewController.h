//
//  CommonPageViewController.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>
#import "XLPageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonPageViewController : UIViewController

//配置信息
@property (nonatomic, strong) XLPageViewControllerConfig *config;

//标题组
@property (nonatomic, strong) NSArray *titles;

@end

NS_ASSUME_NONNULL_END
