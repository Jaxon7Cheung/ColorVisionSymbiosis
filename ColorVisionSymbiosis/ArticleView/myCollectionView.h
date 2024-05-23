//
//  myCollectionView.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>
@class shuju;

NS_ASSUME_NONNULL_BEGIN

@interface myCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) shuju *data;
@property (nonatomic, assign) NSInteger tag;

@end

NS_ASSUME_NONNULL_END
