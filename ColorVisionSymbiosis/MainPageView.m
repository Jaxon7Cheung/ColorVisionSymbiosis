//
//  MainPageView.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import "MainPageView.h"
#import "Masonry.h"
#define Screen_WIDTH [UIScreen mainScreen].bounds.size.width
#define Screen_HEIGHT [UIScreen mainScreen].bounds.size.height
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 16
#import "SquareCell.h"
#import "LongCell.h"

@implementation MainPageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    self.mainBackGround = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"mainBackGround.jpg"]];
    self.mainBackGround.frame = self.bounds;
    self.mainBackGround.userInteractionEnabled = YES;
    [self addSubview: self.mainBackGround];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = MINIGAP / 1.7;
    flowLayout.minimumInteritemSpacing = MINIGAP;
//    flowLayout.itemSize = CGSizeMake(Screen_WIDTH * 0.21 - MINIGAP * 2 / 3, Screen_WIDTH * 0.21 - MINIGAP * 2 / 3);
    self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, 1, 1) collectionViewLayout: flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass: [SquareCell class] forCellWithReuseIdentifier: @"squareCell"];
    [self.collectionView registerClass: [LongCell class] forCellWithReuseIdentifier: @"longCell"];
    [self.mainBackGround addSubview: self.collectionView];
    
//    self.tabView = [[UIView alloc] init];
//    self.tabView.backgroundColor = [UIColor clearColor];
//    [self.mainBackGround addSubview: self.tabView];
    UIBlurEffect* blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleSystemChromeMaterialLight];
    self.effectview = [[UIVisualEffectView alloc] initWithEffect: blur];
//    effectview.frame = CGRectMake(0, 0, self.tabView.bounds.size.width, self.tabView.bounds.size.height);
    self.effectview.alpha = 0.7;
    self.effectview.layer.masksToBounds = YES;
    self.effectview.layer.cornerRadius = 34;;
    [self.mainBackGround addSubview: self.effectview];
    
    self.button = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 57, 57)];
    self.button.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame) - 49);
    self.button.layer.cornerRadius = 34.0f;
    self.button.backgroundColor = [UIColor clearColor];
    self.button.layer.borderColor = [UIColor whiteColor].CGColor;
    self.button.layer.borderWidth = 0;
    [self.button addTarget: self action: @selector(selectCamera) forControlEvents: UIControlEventTouchUpInside];
    [self.button setImage: [UIImage imageNamed: @"camera.png"] forState: UIControlStateNormal];
    [self.mainBackGround addSubview: self.button];
    
    self.cameraView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"xiangji.png"]];
    self.cameraView.frame = CGRectMake(0, 0, 18, 18);
    self.cameraView.center = self.button.center;
    [self.mainBackGround addSubview: self.cameraView];
    

}

- (void)layoutSubviews {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(self.mas_height);
        make.top.mas_equalTo(self.mas_top).mas_offset(MINIGAP * 1.7);
        make.bottom.mas_equalTo(self.button.mas_top);
        make.left.mas_equalTo(self.mas_left).mas_offset(MINIGAP / 1.5);
        make.right.mas_equalTo(self.mas_right).mas_offset(-MINIGAP / 1.5);
    }];
    
//    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(self.collectionView.mas_width);
//            make.height.mas_equalTo(self.button.mas_height);
//            make.top.mas_equalTo(self.collectionView.mas_bottom);
//        make.centerX.mas_equalTo(self.collectionView.mas_centerX);
//    }];
    
    [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.collectionView.mas_width);
            make.height.mas_equalTo(self.button.mas_height);
            make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.centerX.mas_equalTo(self.collectionView.mas_centerX);
    }];
}

- (void)selectCamera {
    [_delegate selectCamera];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
