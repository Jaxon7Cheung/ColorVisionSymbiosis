//
//  MYLabel.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>

typedef enum {
    VerticalAlignmentTop = 0,
    VerticalAlignmentMiddle,
    VerticalAlignmentBotton,
} VerticalAlignment;

NS_ASSUME_NONNULL_BEGIN

@interface MYLabel : UILabel {

@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end

NS_ASSUME_NONNULL_END
