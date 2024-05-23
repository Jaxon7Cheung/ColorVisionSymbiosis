//
//  SquareCell.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/12.
//

#import "SquareCell.h"
#import "Masonry.h"

@implementation SquareCell

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
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textColor = [UIColor colorWithRed: 220.0 / 225 green: 220.0 / 225 blue: 220.0 / 225 alpha: 0.7];
//        self.titleLabel.font = [UIFont boldSystemFontOfSize: 17];
        self.titleLabel.font = [UIFont fontWithName: @"YEFONTTangYingHei" size: 17];
        [self.contentView addSubview: self.titleLabel];
        
        self.mainLabel = [[UILabel alloc] init];
        self.mainLabel.numberOfLines = 0;
        self.mainLabel.textColor = [UIColor colorWithWhite: 1.0 alpha: 0.87];
//        self.mainLabel.font = [UIFont boldSystemFontOfSize: 27];
        self.mainLabel.font = [UIFont fontWithName: @"HGGTZH-Bold" size: 27];
//        NSInteger cnt = 1;
//        NSArray *familyNames = [UIFont familyNames];
//            for( NSString *familyName in familyNames ) {
//                NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
//                for( NSString *fontName in fontNames ) {
//                    printf( "\%ld tFontName: %s \n", cnt++, [fontName UTF8String] );
//                }
//            }
        [self.contentView addSubview: self.mainLabel];
        
        self.iconView = [[UIImageView alloc] init];
        [self.contentView addSubview: self.iconView];
    }
    return self;
}

- (void)layoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView.mas_width).dividedBy(1.1);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(12);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
    }];
    
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.contentView.mas_width).dividedBy(1.1);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(7);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.height.mas_equalTo(self.contentView.mas_height).dividedBy(5);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(47);
            make.top.mas_equalTo(self.mainLabel.mas_bottom).mas_offset(7);
        make.left.mas_equalTo(self.mainLabel);
    }];
    
}
    



@end
