//
//  MainPageView.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DidSelectPageDelegate <NSObject>

- (void)selectCamera;

@end

@interface MainPageView : UIView

@property (nonatomic, weak)id<DidSelectPageDelegate> delegate;
@property (nonatomic, strong)UIImageView* mainBackGround;
@property (nonatomic, strong)UIView* tabView;
@property (nonatomic, strong)UIVisualEffectView* effectview;
@property (nonatomic, strong)UIButton* button;
@property (nonatomic, strong)UICollectionView* collectionView;
@property (nonatomic, strong)UIImageView* cameraView;

@end

NS_ASSUME_NONNULL_END
