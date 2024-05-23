//
//  ColorGameView.h
//  ColorBlockGame
//
//  Created by 张旭洋 on 2024/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorGameView : UIView

@property (nonatomic, strong)UICollectionView* collectionView;

@property (nonatomic, strong)UILabel* scoreLabel;
@property (nonatomic, strong)UILabel* topScoreLabel;
@property (nonatomic, strong)UILabel* healthLabel;
@property (nonatomic, strong)UIImageView* healthView;

@property (nonatomic, strong)UIProgressView* progressView;

@property (nonatomic, strong)UIView* navigationCustomView;

- (void)updateHealthView: (NSInteger)health;
- (void)initNavigationCustomViewWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
