//
//  MainPageController.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MainPageView;
@class NavigationCustomView;
@class MainPageModel;

@interface MainPageController : UIViewController

@property (nonatomic, strong)MainPageView* mainPageView;
@property (nonatomic, strong)NavigationCustomView* navigationCustomView;
@property (nonatomic, strong)MainPageModel* mainPageModel;

@end

NS_ASSUME_NONNULL_END
