//
//  PanView.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import "PanView.h"

@implementation PanView

- (instancetype)initWithFrame:(CGRect)frame withView:(UIView *)view andBackView:(UIView *)backView andNumber:(nonnull NSString *)numStr {
    self = [super initWithFrame:frame];
    if (self) {
        _view = view;
        _backView = backView;
        [self setView];
        [self setColorView: numStr];
    }
    return self;
}

- (void)setView {
    
    self.numLabel = [[UILabel alloc] initWithFrame: self.bounds];
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.font = [UIFont boldSystemFontOfSize: 17];
    [self addSubview: self.numLabel];
    
//    self.showColorView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 55, 55)];
//    self.showColorView.backgroundColor = [self getColorAtPixelBelowBackView];
//    [_view addSubview: self.showColorView];
    
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 3.0;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width / 2;
    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(pan:)];
    [self addGestureRecognizer: panGestureRecognizer];
    
//    self.backgroundColor = [self getColorAtPixelBelowBackView];
}

- (void)setColorView:(NSString *)numStr {
    NSInteger numVal = [numStr integerValue] - 1;
    NSInteger width = self.view.bounds.size.width;
    NSInteger height = self.view.bounds.size.height;
    NSLog(@"%ld", numVal);
    self.showColorView = [[UIView alloc] initWithFrame: CGRectMake(width / 4 * numVal, height / 9, width / 4, 77)];
    self.showColorView.backgroundColor = [UIColor clearColor];
    self.showColorView.layer.borderColor = [UIColor blackColor].CGColor;
    self.showColorView.layer.borderWidth = 1.0;
    self.showColorLabel = [[UILabel alloc] initWithFrame: self.showColorView.bounds];
    self.showColorLabel.textColor = [UIColor blackColor];
    self.showColorLabel.font = [UIFont boldSystemFontOfSize: 17];
    self.showColorLabel.text = [NSString stringWithFormat: @"%@取色器", numStr];
    self.showColorLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.showColorView addSubview: self.showColorLabel];
    [_view addSubview: self.showColorView];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer {
    //获取手指偏移量
    CGPoint translationPoint = [recognizer translationInView: self];
    CGPoint center = recognizer.view.center;
    
    recognizer.view.center = CGPointMake(center.x + translationPoint.x, center.y + translationPoint.y);
    [recognizer setTranslation:CGPointZero inView: self];
    
    self.backgroundColor = [self getColorAtPixelBelowBackView];
    self.showColorView.backgroundColor = self.backgroundColor;
    
}

- (UIColor *)getColorAtPixelBelowBackView {
    CGPoint center = self.center;
    CGPoint convertedCenter = [_view convertPoint:center toView: _backView];
    CGPoint pixelPoint = CGPointMake(convertedCenter.x, convertedCenter.y);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -pixelPoint.x, -pixelPoint.y);
    [_backView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGDataProviderRef provider = CGImageGetDataProvider(image.CGImage);
    CFDataRef pixelData = CGDataProviderCopyData(provider);
    const UInt8 *data = CFDataGetBytePtr(pixelData);
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * 1;
    NSUInteger pixelX = 0;
    NSUInteger pixelY = 0;
    NSUInteger pixelIndex = pixelY * bytesPerRow + pixelX * bytesPerPixel;
    
    CGFloat blue = (CGFloat)data[pixelIndex];
    CGFloat green = (CGFloat)data[pixelIndex + 1];
    CGFloat red = (CGFloat)data[pixelIndex + 2];
    CGFloat alpha = (CGFloat)data[pixelIndex + 3];
    
    CFRelease(pixelData);
    self.showColorLabel.text = [NSString stringWithFormat: @"R:%.0lf\nG:%.0lf\nB:%.0lf", red, green, blue];
    self.showColorLabel.numberOfLines = 3;
    if ([self isLightColorWithRed: red / 255.0 green: red / 255.0 blue: red / 255.0]) {
        self.showColorLabel.textColor = [UIColor blackColor];
        self.numLabel.textColor = [UIColor blackColor];
        self.layer.borderColor = [UIColor blackColor].CGColor;
    } else {
        self.showColorLabel.textColor = [UIColor whiteColor];
        self.numLabel.textColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

- (BOOL)isLightColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    CGFloat relativeLuminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue;
    return relativeLuminance > 0.5;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
