//
//  UIViewController+BubbleTransition.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import "UIViewController+BubbleTransition.h"
#import "BubbleTransition.h"
#import <objc/runtime.h>

static NSString *PushTransitionKey = @"PushTransitionKey";
static NSString *PopTransitionKey = @"PopTransitionKey";

@implementation UIViewController (BubbleTransition)

#pragma mark Setter&Getter

- (void)setXl_pushTranstion:(BubbleTransition *)xl_pushTranstion{
    if (xl_pushTranstion) {
        xl_pushTranstion.transitionType = BubbleTransitionTypeShow;
        self.navigationController.delegate = self;
        
    }else {
        self.navigationController.delegate = nil;
    }
    objc_setAssociatedObject(self, &PushTransitionKey,
                             xl_pushTranstion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BubbleTransition *)xl_pushTranstion {
    return objc_getAssociatedObject(self, &PushTransitionKey);
}

- (void)setXl_popTranstion:(BubbleTransition *)xl_popTranstion {
    if (xl_popTranstion) {
        xl_popTranstion.transitionType = BubbleTransitionTypeHide;
        self.navigationController.delegate = self;
        
    }else {
        self.navigationController.delegate = nil;
    }
    objc_setAssociatedObject(self, &PopTransitionKey, xl_popTranstion, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BubbleTransition *)xl_popTranstion {
    return objc_getAssociatedObject(self, &PopTransitionKey);
}


#pragma mark -
#pragma mark Navigation的Push和Pop转场动画设置
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPush && [fromVC isEqual:self]) {
        return self.xl_pushTranstion;
    }else if(operation == UINavigationControllerOperationPop && [toVC isEqual:self]) {
        return self.xl_popTranstion;
    }else{
        return nil;
    }
}

@end


