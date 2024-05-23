//
//  ColorSchemeCollectionCell.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/15.
//

#import "ColorSchemeCollectionCell.h"

@implementation ColorSchemeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.rgbLabel = [[UILabel alloc] initWithFrame: CGRectMake(0, self.frame.size.height * (1 - 1 / 3.3), self.frame.size.width, self.frame.size.height / 3.3)];
        self.rgbLabel.backgroundColor = [UIColor whiteColor];
        self.rgbLabel.textColor = [UIColor blackColor];
        self.rgbLabel.textAlignment = NSTextAlignmentCenter;
        self.rgbLabel.font = [UIFont boldSystemFontOfSize: 14];
        self.rgbLabel.layer.masksToBounds = YES;
//        self.rgbLabel.layer.cornerRadius = 17.0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.rgbLabel.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(10.0, 10.0)];
        // 创建一个 CAShapeLayer
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        // 将 CAShapeLayer 应用于视图的 mask
        self.rgbLabel.layer.mask = shapeLayer;
        [self addSubview: self.rgbLabel];
        
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 17.0;
        
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowRadius = 3.0;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 3);
    }
    return self;
}

@end
