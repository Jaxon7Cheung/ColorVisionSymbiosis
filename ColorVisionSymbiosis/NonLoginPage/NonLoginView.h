//
//  NonLoginView.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NonLoginView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign)NSInteger Screen_WIDTH;
@property (nonatomic, assign)NSInteger Screen_HEIGHT;
@property (nonatomic, assign)NSInteger MINIGAP;

@property (nonatomic, strong)UICollectionView* collectionView;
@property (nonatomic, strong)NSArray* colorArray;
//@property (nonatomic, strong)UILabel* titleLabel;
@property (nonatomic, strong)UIImageView* titleView;
@property (nonatomic, strong)UIButton* loginButton;
@property (nonatomic, strong)UIButton* registerButton;
@property (nonatomic, strong)UIButton* loginByCodeButton;

@end

NS_ASSUME_NONNULL_END
