//
//  ResultCollectionViewCell.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import "ResultCollectionViewCell.h"

@implementation ResultCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化imageView

        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) - 60)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
        
        // 初始化label1
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(self.contentView.frame), 20)];
        self.label1.textAlignment = NSTextAlignmentCenter;
        self.label1.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label1];
        
        // 初始化label2
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label1.frame), CGRectGetWidth(self.contentView.frame), 20)];
        self.label2.textAlignment = NSTextAlignmentCenter;
        self.label2.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label2];
        
        // 初始化label3
        self.label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.label2.frame), CGRectGetWidth(self.contentView.frame), 20)];
        self.label3.textAlignment = NSTextAlignmentCenter;
        self.label3.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label3];
    }
    return self;
}

@end

