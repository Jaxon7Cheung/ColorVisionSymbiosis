//
//  BubbleTransition.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIViewController+BubbleTransition.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BubbleTransitionType) {
    BubbleTransitionTypeShow = 0,
    BubbleTransitionTypeHide,
};

@interface BubbleTransition : NSObject <UIViewControllerAnimatedTransitioning>

//转场方式：进入/返回
@property (nonatomic, assign)BubbleTransitionType transitionType;

//初始化方法
+ (instancetype)transitionWithAnchorRect:(CGRect)anchorRect;

@end

NS_ASSUME_NONNULL_END
