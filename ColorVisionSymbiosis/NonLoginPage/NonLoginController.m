//
//  NonLoginController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/24.
//

#import "NonLoginController.h"
#import "LoginController.h"
#import "RegisterController.h"

#import "MainPageController.h"
#import "UIViewController+GlobalAlert.h"

@interface NonLoginController ()

@end

@implementation NonLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nonLoginView = [[NonLoginView alloc] initWithFrame: self.view.bounds];
    
    [self.view addSubview: self.nonLoginView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressLogin) name: @"Login" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressRegister) name: @"Register" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pressLoginByCode) name: @"LoginByCode" object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(pushMainPage:) name: @"PushMainPage" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presentRegisterAlert) name: @"RegisterSucceed" object: nil];

}

- (void)pressLogin {
    LoginController* loginController  = [[LoginController alloc] init];
    [self presentViewController: loginController animated: YES completion: nil];
//    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)pressRegister {
    RegisterController* registerController = [[RegisterController alloc] init];
    [self presentViewController: registerController animated: YES completion: nil];
}

- (void)pressLoginByCode {
//    NSLog(@"pressLoginCode");
//    LoginByCodeController* loginByCodeController = [[LoginByCodeController alloc] init];
//    loginByCodeController.modalPresentationStyle = 8;
//    [self presentViewController: loginByCodeController animated: YES completion: nil];
}

- (void)pushMainPage: (NSNotification *)notification {
//    NSLog(@"%@", notification.userInfo[@"message"]);
    MainPageController* mainPageController = [[MainPageController alloc] init];
    [self.navigationController pushViewController: mainPageController animated: YES];
    [self showAlertWithTitle: @"您好👋🏻" andMessage: notification.userInfo[@"message"]];
}

- (void)presentRegisterAlert{
    [self showAlertWithTitle: @"🏅" andMessage: @"注册成功"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-  (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}



@end
