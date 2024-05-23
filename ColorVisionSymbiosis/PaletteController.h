//
//  PaletteController.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaletteController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong)UIImageView* backView;
@property (nonatomic, strong)UIImagePickerController* imagePickerController;

@end

NS_ASSUME_NONNULL_END
