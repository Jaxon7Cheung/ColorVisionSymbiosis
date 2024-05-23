//
//  ColorSchemeController.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/15.
//

#import <UIKit/UIKit.h>

@class Manager;
@class ColorSchemeModel;
@class ColorSchemeView;

NS_ASSUME_NONNULL_BEGIN

@interface ColorSchemeController : UIViewController

@property (nonatomic, strong)Manager* manager;
@property (nonatomic, strong)ColorSchemeModel* colorSchemeModel;
@property (nonatomic, strong)ColorSchemeView* colorSchemeView;

@property (nonatomic, assign)NSInteger currentIndex;


@end

NS_ASSUME_NONNULL_END
