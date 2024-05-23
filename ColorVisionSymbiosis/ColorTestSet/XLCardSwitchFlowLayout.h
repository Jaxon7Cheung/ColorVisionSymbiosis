//
//  XLCardSwitchFlowLayout.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^XLCenterIndexPathBlock)(NSIndexPath *indexPath);

@interface XLCardSwitchFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) XLCenterIndexPathBlock centerBlock;

@end

NS_ASSUME_NONNULL_END
