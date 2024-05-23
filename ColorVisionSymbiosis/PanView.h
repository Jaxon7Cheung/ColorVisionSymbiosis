//
//  PanView.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PanView : UIView

@property (nonatomic, strong)UIView* showColorView;
@property (nonatomic, strong)UILabel* showColorLabel;
@property (nonatomic, strong)UILabel* numLabel;
@property (nonatomic, strong)UIView* view;
@property (nonatomic, strong)UIView* backView;

- (instancetype)initWithFrame:(CGRect)frame withView:(UIView *)view andBackView:(UIView *)backView andNumber:(NSString *)numStr;

@end

NS_ASSUME_NONNULL_END
