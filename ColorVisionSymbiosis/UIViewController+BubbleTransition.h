//
//  UIViewController+BubbleTransition.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import <UIKit/UIKit.h>

@class BubbleTransition;

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BubbleTransition) <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, retain)BubbleTransition* xl_pushTranstion;

@property (nonatomic, retain)BubbleTransition* xl_popTranstion;

@end

NS_ASSUME_NONNULL_END
