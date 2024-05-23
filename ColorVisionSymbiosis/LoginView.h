//
//  LoginView.h
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView <UITextFieldDelegate>

@property (nonatomic, assign)NSInteger Screen_WIDTH;
@property (nonatomic, assign)NSInteger Screen_HEIGHT;
@property (nonatomic, assign)NSInteger MINIGAP;

@property (nonatomic, strong)UIView* circleView;
@property (nonatomic, strong)UIView* whiteView;
@property (nonatomic, strong)UIImageView* titleView;
@property (nonatomic, strong)UITextField* phoneField;
@property (nonatomic, strong)UITextField* passwordField;
@property (nonatomic, strong)UIButton* loginButton;
@property (nonatomic, strong)UILabel* phoneLabel;
@property (nonatomic, strong)UILabel* passwordLabel;
@property (nonatomic, strong)UIButton* loginByCodeButton;
@property (nonatomic, strong)UIButton* getCodeButton;

@property (nonatomic, strong)UILabel* wrongMessageLabel;

- (void)WayOfLoginingByPassword;
- (void)WayOfLoginingByCode;

- (void)presentWrongMessage: (NSString *)messageText;
- (void)removeWrongMessage;

@end

NS_ASSUME_NONNULL_END
