//
//  MyLayout.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger tag;
- (instancetype)initWithTag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
