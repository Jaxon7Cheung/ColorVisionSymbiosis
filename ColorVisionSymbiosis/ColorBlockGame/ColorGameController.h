//
//  ColorGameController.h
//  ColorBlockGame
//
//  Created by 张旭洋 on 2024/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ColorGameView;
@class ColorGameModel;
@class ColorBlockModel;
@class Manager;

@interface ColorGameController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)ColorGameView* colorGameView;
@property (nonatomic, strong)ColorGameModel* colorGameModel;
@property (nonatomic, strong)NSMutableArray<ColorBlockModel *>* blocks;
//@property (nonatomic, strong)UIView* navigationCustomView;

@property (nonatomic, weak)NSTimer* gameTimer;
@property (nonatomic, assign)CGFloat currentTime;

@property (nonatomic, strong)Manager* manager;

@end

NS_ASSUME_NONNULL_END
