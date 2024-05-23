//
//  RegisterView.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : UIView <UITextFieldDelegate>

@property (nonatomic, assign)NSInteger Screen_WIDTH;
@property (nonatomic, assign)NSInteger Screen_HEIGHT;
@property (nonatomic, assign)NSInteger MINIGAP;

@property (nonatomic, strong)UIView* circleView;
@property (nonatomic, strong)UIView* whiteView;
@property (nonatomic, strong)UIImageView* titleView;
@property (nonatomic, strong)UITextField* phoneField;
@property (nonatomic, strong)UITextField* passwordField;
@property (nonatomic, strong)UITextField* confirmPasswordField;
@property (nonatomic, strong)UIButton* registerButton;
@property (nonatomic, strong)UILabel* phoneLabel;
@property (nonatomic, strong)UILabel* passwordLabel;
@property (nonatomic, strong)UILabel* confirmPasswordLabel;
@property (nonatomic, strong)UIButton* loginByVerifying;

@property (nonatomic, strong)UILabel* wrongMessageLabel;

- (void)presentWrongMessage: (NSString *)messageText;
- (void)removeWrongMessage;

@end

NS_ASSUME_NONNULL_END
