//
//  BubbleTransition.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import "BubbleTransition.h"

@interface BubbleTransition() <CAAnimationDelegate>

//锚点
@property (nonatomic, assign) CGRect anchorRect;

@property (nonatomic, strong) NSObject<UIViewControllerContextTransitioning> *transitionContext;

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation BubbleTransition

#pragma mark 初始化方法
+ (instancetype)transitionWithAnchorRect:(CGRect)anchorRect {
    BubbleTransition *transition = [[BubbleTransition alloc] init];
    transition.anchorRect = anchorRect;
    return transition;
}

#pragma mark 转场动画代理方法
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.35f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    if (self.transitionType == BubbleTransitionTypeShow) {
        [self showBubbleMaskAnimationTo:transitionContext];
        [self showScaleAnimationTo:transitionContext];
    }else if (self.transitionType == BubbleTransitionTypeHide){
        [self hideBubbleMaskAnimationTo:transitionContext];
        [self hideScaleAnimationTo:transitionContext];
    }
}

#pragma mark 显示/隐藏方法
//显示圆形放大动画
-(void)showBubbleMaskAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *contView = [transitionContext containerView];
    
    [contView addSubview:fromView];
    [contView addSubview:toView];
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    //    toView.layer.mask = maskLayer;
    maskLayer.bounds = fromView.layer.bounds;
    maskLayer.position = fromView.layer.position;
    maskLayer.fillColor = toView.backgroundColor.CGColor;
    [fromView.layer addSublayer:maskLayer];
    self.maskLayer = maskLayer;
    
    //开始的圆环
    UIBezierPath *startPath =  [UIBezierPath bezierPathWithOvalInRect:self.anchorRect];
    //结束圆环
    CGFloat radius = [self radiusOfBubbleInView:toView startPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.anchorRect, - radius, - radius)];
    
    //圆形放大的动画
    //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    maskLayer.path = finalPath.CGPath;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((finalPath.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

//显示---位置和缩放效果
-(void)showScaleAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //位移动画
    toView.layer.position = CGPointMake(CGRectGetMidX(toView.bounds), CGRectGetMidY(toView.bounds));
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(toView.bounds), CGRectGetMidY(toView.bounds))];
    positionAnimation.duration = [self transitionDuration:transitionContext];
    positionAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [toView.layer addAnimation:positionAnimation forKey:@"position"];
    
    //缩放动画
    toView.transform = CGAffineTransformMakeScale(1, 1);
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(0);
    scaleAnimation.toValue = @(1);
    scaleAnimation.duration = [self transitionDuration:transitionContext];
    scaleAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [toView.layer addAnimation:scaleAnimation forKey:@"scale"];
}


//隐藏--圆形放大动画
-(void)hideBubbleMaskAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    self.transitionContext = transitionContext;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *contView = [transitionContext containerView];
    [contView addSubview:toView];
    [contView addSubview:fromView];
    
    
    //创建一个 CAShapeLayer 来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.bounds = toView.layer.bounds;
    maskLayer.position = toView.layer.position;
    maskLayer.fillColor = fromView.backgroundColor.CGColor;
    //    fromView.layer.mask = maskLayer;
    [toView.layer addSublayer:maskLayer];
    self.maskLayer = maskLayer;
    
    //结束圆环
    CGFloat radius = [self radiusOfBubbleInView:toView startPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    //开始的圆环
    UIBezierPath *startPath =  [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.anchorRect, - radius, - radius)];
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:self.anchorRect];
    
    //放大动画
    //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    maskLayer.path = finalPath.CGPath;
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((finalPath.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}


//隐藏---位置和缩放效果
-(void)hideScaleAnimationTo:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //位移动画
    fromView.layer.position = CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect));
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(fromView.bounds), CGRectGetMidY(fromView.bounds))];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.anchorRect), CGRectGetMidY(self.anchorRect))];
    positionAnimation.duration = [self transitionDuration:transitionContext];
    positionAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    positionAnimation.delegate = self;
    [fromView.layer addAnimation:positionAnimation forKey:@"position"];
    
    //缩放动画
    fromView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = @(1);
    scaleAnimation.toValue = @(0);
    scaleAnimation.duration = [self transitionDuration:transitionContext];
    scaleAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [fromView.layer addAnimation:scaleAnimation forKey:@"scale"];
}


//遍历view的四个角 获取最长的半径
-(CGFloat)radiusOfBubbleInView:(UIView*)view startPoint:(CGPoint)startPoint{
    
    //获取四个角所在的点
    CGPoint point1 = CGPointMake(0, 0);
    CGPoint point2 = CGPointMake(view.bounds.size.width, 0);
    CGPoint point3 = CGPointMake(0 ,view.bounds.size.height);
    CGPoint point4 = CGPointMake(view.bounds.size.width,view.bounds.size.height);
    NSArray *pointArrar = @[[NSValue valueWithCGPoint:point1],[NSValue valueWithCGPoint:point2],[NSValue valueWithCGPoint:point3],[NSValue valueWithCGPoint:point4]];
    //做一个冒泡排序获得最长的半径
    CGFloat radius = 0;
    for (NSValue *value in pointArrar) {
        CGPoint point = [value CGPointValue];
        CGFloat apartX = point.x - startPoint.x;
        CGFloat apartY = point.y - startPoint.y;
        CGFloat realRadius = sqrt(apartX*apartX + apartY*apartY);
        if (radius <= realRadius) {
            radius = realRadius;
        }
    }
    return radius;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    //通知上下文 动画结束
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //移除遮罩layer
    [self.maskLayer removeFromSuperlayer];
    self.maskLayer = nil;
}

@end
