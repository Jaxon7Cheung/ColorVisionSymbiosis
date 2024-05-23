//
//  RegisterController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/30.
//

#import "RegisterController.h"
//#import "GlobalAlert/GlobalAlert.h"
#import "UIViewController+GlobalAlert.h"

@interface RegisterController ()

@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.manager = [[Manager alloc] init];
//    UIViewAutoresizing
    
    self.registerView = [[RegisterView alloc] initWithFrame: self.view.bounds];
    [self.view addSubview: self.registerView];
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(confirmRegister:) name: @"ConfirmRegister" object: nil];
    
}

- (void)confirmRegister: (NSNotification *)notification {
    NSLog(@"%@ %@ %@", notification.userInfo[@"phone"], notification.userInfo[@"password"], notification.userInfo[@"confirmPassword"]);
    NSString* phone = notification.userInfo[@"phone"];
    NSString* password = notification.userInfo[@"password"];
    NSString* repassword = notification.userInfo[@"confirmPassword"];
    
    if ([phone isEqualToString: @""] || [password isEqualToString: @""] || [repassword isEqualToString: @""]) {
        [self.registerView presentWrongMessage: @"请输入账号或密码"];
        [self startLabelTimer];
        NSLog(@"请输入账号或密码");
    } else {
        [self.manager requestRegisterInfoWithPhone: notification.userInfo[@"phone"] Password: notification.userInfo[@"password"] andConfirmPassword: notification.userInfo[@"confirmPassword"] success:^(RegisterModel * _Nonnull registerModel) {
            NSDictionary* requestResult = [registerModel toDictionary];
            NSString* requestString = requestResult[@"message"];
            NSLog(@"%@", requestString);
            

            dispatch_sync(dispatch_get_main_queue(), ^{
                if ([requestString isEqualToString: @"注册成功"]) {
                    [self dismissViewControllerAnimated: YES completion: nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName: @"RegisterSucceed" object: nil userInfo: nil];
                } else {
                    [self showAlertWithTitle: @"❗️" andMessage: requestString];
                }
//                UIAlertController* alertController = [UIAlertController alertControllerWithTitle: @"❗️" message: requestString preferredStyle: UIAlertControllerStyleAlert];
//                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle: @"好的" style: UIAlertActionStyleCancel handler: nil];
//                [alertController addAction: cancelAction];
//                [self presentViewController: alertController animated: YES completion: nil];
//                [[GlobalAlert sharedInstance] showAlertWithTitle: @"❗️" andMessage: requestString];

            });

//            NSLog(@"%@ = %@", requestResult, requestResult[@"message"]);
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
    }
    

    
}

#pragma mark Label倒计时

//使用labelTimer为变量名时，提示Linker command failed with exit code 1 (use -v to see invocation)，有待学习。
NSTimer* labelRegisterTimer;
- (void)startLabelTimer {
    if (!labelRegisterTimer) labelRegisterTimer = [NSTimer scheduledTimerWithTimeInterval: 0.7 target: self selector: @selector(removeLabel) userInfo: nil repeats: NO];
}

- (void)removeLabel {
    [self.registerView removeWrongMessage];
    [labelRegisterTimer invalidate];
    labelRegisterTimer = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [self removeLabel];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

@end
