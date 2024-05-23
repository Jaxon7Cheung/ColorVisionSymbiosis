//
//  LoginController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import "LoginController.h"
#import "UIViewController+GlobalAlert.h"

@interface LoginController ()

@property (nonatomic, strong)UIView* codeView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager = [Manager sharedManager];
    
    self.loginView = [[LoginView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: self.loginView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(confirmLogin:) name: @"ConfirmLogin" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(wayOfLogin:) name: @"WayOfLogin" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(getCodeAndStartCountdown:) name: @"GetCodeAndStartCountdown" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(confirmLoginByCode:) name: @"ConfirmLoginByCode" object: nil];
    
//    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController: self];
    
}

#pragma mark 确认登录
- (void)confirmLogin: (NSNotification *)notification {
//    NSLog(@"%@ %@", notification.userInfo[@"phone"], notification.userInfo[@"password"]);
    NSString* phone = notification.userInfo[@"phone"];
    NSString* password = notification.userInfo[@"password"];
    
    if ([phone isEqualToString: @""] || [password isEqualToString: @""]) {
        [self.loginView presentWrongMessage: @"请输入手机号或密码"];
        [self startLabelTimer];
        
        NSLog(@"请输入手机号或密码");
    } else {
        [self.manager requestLoginInfoWithPhone: notification.userInfo[@"phone"] andPassword: notification.userInfo[@"password"] success:^(LoginModel * _Nonnull loginModel, NSString* token) {
            NSDictionary* requestResult = [loginModel toDictionary];
            NSLog(@"%@ = %@", requestResult, requestResult[@"message"]);
            NSString* resultString = requestResult[@"message"];
            if ([resultString isEqualToString: @"欢迎回来"]) {
                
                NSLog(@"Token: %@", token);
                [self.manager writeTokenToPreference: token];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
//                    MainPageController* mainPageController = [[MainPageController alloc] init];
                    NSDictionary* dict = @{@"message" : resultString};
                    [self dismissViewControllerAnimated: YES completion: nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName: @"PushMainPage" object: nil userInfo: dict];
                });
               
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle: @"❗️" andMessage: resultString];
                });
            }
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
    }
}

- (void)confirmLoginByCode: (NSNotification *)notification {
    NSString* phone = notification.userInfo[@"phone"];
    NSString* code = notification.userInfo[@"code"];
    
    if ([phone isEqualToString: @""] || [code isEqualToString: @""]) {
        [self.loginView presentWrongMessage: @"请输入手机号或验证码"];
        [self startLabelTimer];
        NSLog(@"请输入手机号或验证码");
    } else {
        [self.manager requestLoginByCodeInfoWithPhone: phone andCode: code success:^(LoginByCodeModel * _Nonnull loginByCodeModel, NSString* token) {
            NSDictionary* requestResult = [loginByCodeModel toDictionary];
            NSString* resultString = requestResult[@"message"];
            
            if ([resultString isEqualToString: @"验证码错误"]) {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self showAlertWithTitle: @"❗️" andMessage: resultString];
                });
            } else {
                NSLog(@"token");
                [self.manager writeTokenToPreference: token];
                NSLog(@"%@", resultString);
                
                dispatch_sync(dispatch_get_main_queue(), ^{
//                    MainPageController* mainPageController = [[MainPageController alloc] init];
                    NSDictionary* dict = @{@"message" : resultString};
                    [self dismissViewControllerAnimated: YES completion: nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName: @"PushMainPage" object: nil userInfo: dict];
                });
            }
            
            
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
    }
}

#pragma mark 切换登录方式
- (void)wayOfLogin: (NSNotification *)notification {
    UIButton* button = notification.object;
//    NSLog(@"%ld", button.tag);
    if (button.tag == 101) {
        button.tag = 102;
        [button setTitle: @"用密码登录" forState: UIControlStateNormal];
        [self.loginView WayOfLoginingByCode];
    } else if (button.tag == 102) {
        button.tag = 101;
        [button setTitle: @"验证码登录" forState: UIControlStateNormal];
        [self.loginView WayOfLoginingByPassword];
    }
}

#pragma mark 倒计时
NSTimer* countdownTimer;
NSInteger countdownTime = 60;

- (void)getCodeAndStartCountdown: (NSNotification *)notification {
    NSLog(@"%@", notification.userInfo[@"phoneByCode"]);
    
    NSString* phone = notification.userInfo[@"phoneByCode"];
    
    if (!countdownTimer) {
        if ([phone isEqualToString: @""]) {
            [self.loginView presentWrongMessage: @"请输入手机号"];
            [self startLabelTimer];
            NSLog(@"请输入手机号");
        } else {
            [self.manager requestCodeInfoWithPhone: phone success:^(CodeModel * _Nonnull codeModel) {
                NSDictionary* requestResult = [codeModel toDictionary];
                NSString* resultString = requestResult[@"message"];
                if ([resultString isEqualToString: @"手机号码无效"]) {
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self showAlertWithTitle: @"❗️" andMessage: resultString];
                    });
                    
                    
                    NSLog(@"手机号码无效");
                } else {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        self.loginView.getCodeButton.enabled = NO;
                        [self.loginView.getCodeButton setTitle: @"60秒后重试" forState: UIControlStateDisabled];
                        countdownTimer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(updateCountdown) userInfo: nil repeats: YES];
                        self.codeView = [[UIView alloc] initWithFrame: CGRectMake(0, -50, self.view.frame.size.width, 100)];
                        self.codeView.backgroundColor = [UIColor lightGrayColor];
                        self.codeView.layer.masksToBounds = YES;
                        self.codeView.layer.cornerRadius = 18;
                        UILabel* codeLabel = [[UILabel alloc] initWithFrame: self.codeView.bounds];
                        codeLabel.textColor = [UIColor blackColor];
                        codeLabel.text = [NSString stringWithFormat: @"验证码：%@", requestResult[@"message"]];
                        codeLabel.textAlignment = NSTextAlignmentCenter;
                        codeLabel.font = [UIFont boldSystemFontOfSize: 28];
                        [self.codeView addSubview: codeLabel];
                        
                        [[UIApplication sharedApplication].keyWindow addSubview: self.codeView];
                        
                        [UIView animateWithDuration:0.5 animations:^{
                            self.codeView.frame = CGRectMake(0, 50, self.view.frame.size.width, 100);
                        }];
                        
                        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hideCustomView) userInfo:nil repeats:NO];
                    });
                }
                NSLog(@"%@qq", requestResult[@"message"]);
            } failure:^(NSError * _Nonnull error) {
                if (error) NSLog(@"网络连接失败");
            }];
        }
    }
    
}

- (void)updateCountdown {
    countdownTime--;
    if (!countdownTime) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        countdownTime = 60;
        
        self.loginView.getCodeButton.enabled = YES;
        [self.loginView.getCodeButton setTitle: @"获取验证码" forState: UIControlStateNormal];
    } else {
        [self.loginView.getCodeButton setTitle: [NSString stringWithFormat: @"%ld秒后重试", countdownTime] forState: UIControlStateDisabled];
    }
}

#pragma mark Label倒计时

NSTimer* labelTimer;
- (void)startLabelTimer {
    if (!labelTimer) labelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.7 target: self selector: @selector(removeLabel) userInfo: nil repeats: NO];
}

- (void)removeLabel {
    [self.loginView removeWrongMessage];
    [labelTimer invalidate];
    labelTimer = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 销毁逻辑

//dismiss掉登录页面后，却换不了验证码登陆样式了，怀疑是NSTimer在作祟！！！！！！
- (void)dealloc {
//    [super dealloc];
    NSLog(@"dismiss掉登录页面后，却换不了验证码登陆样式了，怀疑是NSTimer在作祟！！！！！！");
    [self removeLabel];
    [countdownTimer invalidate];
    countdownTimer = nil;
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)hideCustomView {
    // 通过动画让 UIView 消失
    [UIView animateWithDuration:0.5 animations:^{
        self.codeView.frame = CGRectMake(0, -50, self.view.frame.size.width, 50);
    } completion:^(BOOL finished) {
        [self.codeView removeFromSuperview];
    }];
}

@end
