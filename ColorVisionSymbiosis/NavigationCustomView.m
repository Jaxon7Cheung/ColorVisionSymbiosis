//
//  NavigationCustomView.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/11.
//

#import "NavigationCustomView.h"
#import "Masonry.h"

@implementation NavigationCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        [self setUI];
    }
    
    return self;
}

/*
 为什么我在将当前页面作为根视图后，就会显示titleView？
 作为push后的界面就显示有出入？
 Masonry写在layoutSubviews就行了
 这是什么原因？是跟Masonry以及调用时机有关吗？我如果改成frame呢？
 以后有待学习
 */
- (void)setUI {
//    self.backgroundColor = [UIColor redColor];
    
    self.menuImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"caidan.png"]];
    self.menuImageView.frame = CGRectMake(17, (self.bounds.size.height - 37) / 2, 37, 37);
    [self addSubview: self.menuImageView];

    
    self.titleImageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"seshiLabel.png"]];
    self.titleImageView.frame = CGRectMake(-17, -17, 337, self.bounds.size.height + 34);
    
    [self addSubview: self.titleImageView];
    
    self.triColor = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"sanse.png"]];
    self.triColor.frame = CGRectMake(self.bounds.size.width - (77 + 17), (self.bounds.size.height - 37) / 2, 47, 47);
    [self addSubview: self.triColor];

}

- (void)layoutSubviews {
//    [self.menuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(27);
//            make.left.mas_equalTo(self.mas_left);
//        make.centerY.mas_equalTo(self.mas_centerY);
//    }];
    
//    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.mas_top).mas_offset(-17);
//            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(17);
//        make.left.mas_equalTo(self.menuImageView.mas_right).mas_offset(-77);
//        make.centerY.mas_equalTo(self.mas_centerY);
//        make.width.mas_equalTo(377);
//    }];
//    
//    [self.triColor mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(37);
//            make.right.mas_equalTo(self.mas_right);
//        make.centerY.mas_equalTo(self.mas_centerY);
//    }];
}

/*
 在customTitleView方法内部，你使用了self.customTitleView来访问和设置属性。这会导致无限递归调用，最终导致堆栈溢出（stack overflow）。
 */
//- (UIView *)setUpCustomTitleView {
//
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
