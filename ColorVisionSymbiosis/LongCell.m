//
//  LongCell.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/13.
//

#import "LongCell.h"
#import "Masonry/Masonry.h"

@implementation LongCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIBlurEffect* blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleSystemThinMaterialDark];
        UIVisualEffectView* effectview = [[UIVisualEffectView alloc] initWithEffect: blur];
        effectview.frame = self.contentView.frame;
        effectview.alpha = 0.3;
        effectview.layer.masksToBounds = YES;
        effectview.layer.cornerRadius = 13.0;
        [self.contentView addSubview: effectview];
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview: self.iconView];
        
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.numberOfLines = 0;
        self.mainLabel.textColor = [UIColor colorWithWhite: 1.0 alpha: 0.87];
        self.mainLabel.font = [UIFont fontWithName: @"HGGTZH-Bold" size: 27];
        [self.contentView addSubview: self.mainLabel];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor colorWithRed: 220.0 / 225 green: 220.0 / 225 blue: 220.0 / 225 alpha: 0.7];
        self.titleLabel.font = [UIFont fontWithName: @"YEFONTTangYingHei" size: 17];
        [self.contentView addSubview: self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.contentView.bounds.size.height / 1.5);
        make.width.mas_equalTo(self.contentView.bounds.size.height * 1.06);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(-13);
    }];
    
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconView.mas_top);
            make.right.mas_equalTo(self.iconView.mas_left);
        make.left.mas_equalTo(self.contentView.mas_left).mas_offset(13);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mainLabel.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(self.mainLabel.mas_left);
            make.right.mas_equalTo(self.mainLabel.mas_right);
    }];
}

//[self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.contentView.mas_width).dividedBy(1.1);
//        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(7);
//    make.centerX.mas_equalTo(self.contentView.mas_centerX);
//    make.height.mas_equalTo(self.contentView.mas_height).dividedBy(5);
//}];

@end
