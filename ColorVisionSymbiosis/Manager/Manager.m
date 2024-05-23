//
//  Manager.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/1/26.
//

#import "Manager.h"
#import "OverallActivityIndicator.h"

@implementation Manager

static id manager = nil;

+ (instancetype)sharedManager {
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[Manager alloc] init];
        });
    }
    return manager;
}

//@"phone=18291734442&password=122333Az*" 如何在请求体里面输入&符号，URL编码
- (void)requestLoginInfoWithPhone:(NSString *)phone andPassword:(NSString *)password success:(LoginModelBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/loginByPassword"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@&password=%@", phone, password] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            /*
             在提取 URL 请求返回的响应头中的 Token 时，我们首先检查是否是 NSHTTPURLResponse 类型，是因为 NSHTTPURLResponse 是 NSURLResponse 的子类，它提供了更多与 HTTP 相关的功能和属性。

             通过将响应对象转换为 NSHTTPURLResponse 类型，我们可以访问和操作与 HTTP 请求和响应相关的属性和方法，例如响应状态码、响应头字段等。这样可以更方便地从响应头中提取所需的信息，如 Token。

             如果响应对象不是 NSHTTPURLResponse 类型，那么它可能是其他类型的 NSURLResponse 对象，它可能是其他协议（如 FTP、File）的响应。这些类型的响应对象不一定具有 HTTP 相关的属性和方法，因此我们无法直接从响应头中提取 Token。

             因此，为了确保我们只在 HTTP 响应中提取 Token，我们进行类型检查，仅当响应对象是 NSHTTPURLResponse 类型时才执行相应的操作。
             */
            //检查是否为HTTP响应
            NSString* token = @"";
            if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
//                NSLog(@"%@", httpResponse.allHeaderFields);
                NSString* cookieString = [httpResponse.allHeaderFields objectForKey: @"Set-Cookie"];
//                NSLog(@"Cookie: %@", cookieString);
                
                //使用分号分隔字符串，将其拆分成多个组件
                NSArray* cookieComponents = [cookieString componentsSeparatedByString: @";"];
//                NSLog(@"%@", cookieComponents[0]);
                NSString* authorizationString = cookieComponents[0];
                token = [authorizationString substringFromIndex: [@"Authorization=" length]];
//                NSLog(@"Token: %@", token);
//                [self writeTokenToPreference: token];
            }
            
            LoginModel* loginModel = [[LoginModel alloc] initWithData: data error: nil];
            success(loginModel, token);
            
//            NSLog(@"%@ %@", dict[@"message"], dict[@"data"][@"phone"]);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestRegisterInfoWithPhone:(NSString *)phone Password:(NSString *)password andConfirmPassword:(NSString *)confirmPassword success:(RegisterModelBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/createUser"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@&password=%@&repassword=%@", phone, password, confirmPassword] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            RegisterModel* registerModel = [[RegisterModel alloc] initWithData: data error: nil];
            success(registerModel);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestCodeInfoWithPhone:(NSString *)phone success:(CodeModelBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/sendCode"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@", phone] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            CodeModel* codeModel = [[CodeModel alloc] initWithData: data error: nil];
            success(codeModel);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestLoginByCodeInfoWithPhone:(NSString *)phone andCode:(NSString *)code success:(LoginByCodeBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/user/loginByCode"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"phone=%@&code=%@", phone, code] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    [OverallActivityIndicator setText: @"加载中..."];
    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSString* token = @"";
            if ([response isKindOfClass: [NSHTTPURLResponse class]]) {
                NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse *)response;
                NSString* cookieString = [httpResponse.allHeaderFields objectForKey: @"Set-Cookie"];
                NSArray* cookieComponents = [cookieString componentsSeparatedByString: @";"];
                NSString* authorizationString = cookieComponents[0];
                token = [authorizationString substringFromIndex: [@"Authorization=" length]];
            }
            LoginByCodeModel* loginByCodeModel = [[LoginByCodeModel alloc] initWithData: data error: nil];
            success(loginByCodeModel, token);
            dispatch_sync(dispatch_get_main_queue(), ^{
                [OverallActivityIndicator stopActivity];
            });
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)postTopScore: (NSString *)score withToken: (NSString *)token {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/test/RefreshHighest"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [[NSString stringWithFormat: @"Score=%@", score] dataUsingEncoding: NSUTF8StringEncoding];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields: headers];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
//    [OverallActivityIndicator setText: @"加载中..."];
//    [OverallActivityIndicator startActivity];
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
//            NSLog(@"Response: %@", responseDict[@"message"]);
        } else {
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestTopScoreWithToken: (NSString *)token sucess:(ColorGameBlock)success failure:(ErrorBlock)failure {
    NSURL* url = [NSURL URLWithString: @"http://zy520.online:8081/test/GetHighest"];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL: url];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields: headers];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession* session = [NSURLSession sharedSession];
    
    NSURLSessionTask* task = [session dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            ColorGameTopScoreModel* colorGameTopScoreModel = [[ColorGameTopScoreModel alloc] initWithData: data error: nil];
//            NSLog(@"%@", colorGameTopScoreModel);
            success(colorGameTopScoreModel);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestColoringScheme:(NSString *)token success:(ColorModelBlock)success failure:(ErrorBlock)failure {
    
    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/attach/Favorite"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            ColorSchemeModel *colorSchemeModel = [[ColorSchemeModel alloc] initWithData:data error:nil];
            success(colorSchemeModel);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}



- (void)requestResultForAddingName:(NSString *)name withToken: (NSString *)token success:(AddNameBlock)success failure:(ErrorBlock)failure {
//    NSLog(@"%@", name);
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://zy520.online:8081/attach/createFavorite?name=%@", name]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
//    request.HTTPBody = [[NSString stringWithFormat: @"name=方案B"] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive",
       @"Content-Type": @"multipart/form-data; boundary=--------------------------577602883893983905959428"
    };
    [request setAllHTTPHeaderFields:headers];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            AddNameModel* addNameModel = [[AddNameModel alloc] initWithData:data error:nil];
            NSLog(@"%@", addNameModel);
            NSLog(@"%@", data);
            success(addNameModel);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)requestResultForDeletingName:(NSString *)name withToken:(NSString *)token success:(DeleteNameBlock)success failure:(ErrorBlock)failure {
    NSLog(@"%@111", name);
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat: @"http://zy520.online:8081/attach/cancelFavorite?name=%@", name]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive",
       @"Content-Type": @"multipart/form-data; boundary=--------------------------111473860920218998637136"
    };
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            DeleteNameModel* deleteNameModel = [[DeleteNameModel alloc] initWithData:data error:nil];
            NSLog(@"deleteNameModel:%@", deleteNameModel);
//            NSLog(@"%@", data);
            success(deleteNameModel);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)writeTokenToPreference: (NSString *)token {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject: token forKey: @"Token"];
    [userDefaults synchronize];
}


- (void)requestColorBlindTest: (NSString *)token success:(TestModelBlock)success failure:(ErrorBlock)failure {
    
    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/test/method1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
//            NSLog(@"data: %@", data);
            ColorTestModel *colorTestModel = [[ColorTestModel alloc] initWithData:data error:nil];
            NSLog(@"colorModel: %@", colorTestModel);
            success(colorTestModel);
//            NSLog(@"%@,%d",data,__LINE__);
        } else {
            failure(error);
            NSLog(@"error:%@", error);
        }
    }];
    
    [task resume];
}

- (void)postColorBlindOptionArray: (NSString *)token success:(OptionModelBlock)success failure:(ErrorBlock)failure didSelectOption:(NSArray *)optionArray {
    
    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/test/JudgeMethod1"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
//    request.HTTPBody = [[NSString stringWithFormat:@"options=%@", optionArray] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *optionString = [optionArray componentsJoinedByString:@""];
    NSString *temString = [NSString stringWithFormat:@"options=%@", optionString];
    NSMutableData *postData = [[NSMutableData alloc] initWithData:[temString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    NSLog(@"optionString = %@", optionString);
    NSLog(@"temString = %@", temString);
    NSLog(@"postData = %@", postData);
    
    NSDictionary *headers = @{
       @"Cookie": [NSString stringWithFormat: @"Authorization=%@", token],
       @"User-Agent": @"Apifox/1.0.0 (https://apifox.com)",
       @"Accept": @"*/*",
       @"Host": @"zy520.online:8081",
       @"Connection": @"keep-alive"
    };
    [request setAllHTTPHeaderFields:headers];
    
    
//    NSDictionary *params = @{@"option": option};
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
//    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Request successful");
            OptionModel *optionModel = [[OptionModel alloc] initWithData:data error:nil];
            NSLog(@"optionModel: %@", optionModel);
            success(optionModel);
        }
    }];

    
    [task resume];
}


@end
