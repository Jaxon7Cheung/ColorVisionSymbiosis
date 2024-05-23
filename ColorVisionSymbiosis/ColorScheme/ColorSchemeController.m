//
//  ColorSchemeController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/15.
//

#import "ColorSchemeController.h"
#import "Manager.h"
//#import "ColorSchemeModel.h"
#import "ColorSchemeView.h"
#import "ColorSchemeCollectionCell.h"

@interface ColorSchemeController () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, ConfirmAddDelegate>

@end

@implementation ColorSchemeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.currentIndex = 0;
    
    self.colorSchemeModel = [[ColorSchemeModel alloc] init];

    self.manager = [[Manager alloc] init];
    [self requestModelAndInitView];
    
    
    
//    self.
}

#pragma mark 请求数据

- (void)requestModelAndInitView {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token = [userDefaults objectForKey: @"Token"];
    [self.manager requestColoringScheme: token success:^(ColorSchemeModel * _Nonnull colorModel) {
            NSDictionary* dict = [colorModel toDictionary];
            
            NSArray* array = dict[@"data"];
        
//        if (!array) {
//            NSLog(@"数组为空");
//        } else {
//            NSLog(@"数组已经被初始化");
//        }
//        NSLog(@"%@ %@ %@", array, [array class], [NSArray class]);
        if ([array count]) {
            for (NSDictionary* dict in array) {
                [self.colorSchemeModel.nameArray addObject: dict[@"Name"]];
                [self.colorSchemeModel.rgbArray addObject: dict[@"color"]];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self initView];
        });
        
        } failure:^(NSError * _Nonnull error) {
            if (error) NSLog(@"网络连接失败");
        }];
}

#pragma mark tableView相关

- (void)initView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.colorSchemeView = [[ColorSchemeView alloc] initWithFrame: CGRectMake(0, self.view.frame.size.height / 8, self.view.frame.size.width, self.view.frame.size.height * 3 / 4)];
    self.colorSchemeView = [[ColorSchemeView alloc] initWithFrame: self.view.bounds];

    
    self.colorSchemeView.delegate = self;
    
    self.colorSchemeView.tableView.delegate = self;
    self.colorSchemeView.tableView.dataSource = self;
    [self.colorSchemeView.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: @"tableViewCell"];
    
    self.colorSchemeView.collectionView.delegate = self;
    self.colorSchemeView.collectionView.dataSource = self;
    [self.colorSchemeView.collectionView registerClass: [ColorSchemeCollectionCell class] forCellWithReuseIdentifier: @"collectionViewCell"];
    
    [self.view addSubview: self.colorSchemeView];
    
//    [self.colorSchemeView.addNameButton addTarget: self action: @selector(addName) forControlEvents: UIControlEventTouchUpInside];
    [self setNavigationCustomViewWithFrame: self.navigationController.navigationBar.bounds];
    
    
}

#pragma mark List列表

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%ld", [self.colorSchemeModel.nameArray count]);
    return [self.colorSchemeModel.nameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: @"tableViewCell"];
    
    if (!self.currentIndex) {
        cell.selected = YES;
//        NSLog(@"tableViewCell Did Selected");
    }
    
    cell.textLabel.text = self.colorSchemeModel.nameArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed: 241 / 255.0 green: 241 / 255.0 blue: 241 / 255.0 alpha: 1.0];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame: cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.colorSchemeView.collectionView reloadData];
}

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //    NSLog(@"%ld", [self.colorSchemeModel.rgbArray count]);
//    NSLog(@"%@", self.colorSchemeModel.rgbArray[0]);
    if (![self.colorSchemeModel.rgbArray count]) return 0;
//    if (self.currentIndex >= [self.colorSchemeModel.rgbArray count]) return 0;
    NSArray* rgbCount = self.colorSchemeModel.rgbArray[self.currentIndex];
//    NSLog(@"rgbCount: %@", [rgbCount class]);
    if ([rgbCount isKindOfClass: [NSArray class]]) {
        return [rgbCount count];
    } else {
        return 0;
    }
//    if (rgbCount == nil) {
//        return 0;
//    } else {
//        return [rgbCount count];
//    }
//    return [self.colorSchemeModel.rgbArray[0] count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ColorSchemeCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"collectionViewCell" forIndexPath: indexPath];
    
    NSArray<NSDictionary *>* rgbArray = self.colorSchemeModel.rgbArray[self.currentIndex];
//    NSLog(@"%@ %@ %ld", rgbArray[0], rgbArray[1], indexPath.item);
    NSDictionary* rgba = rgbArray[indexPath.item];
    NSString* r = rgba[@"R"];
    NSString* g = rgba[@"G"];
    NSString* b = rgba[@"B"];
//        NSString* a = rgba[@"A"];
    CGFloat R = [r doubleValue];
    CGFloat G = [g doubleValue];
    CGFloat B = [b doubleValue];
//    CGFloat A = [a doubleValue];
//    NSLog(@"%lf %lf %lf %lf", R, G, B, A);
    cell.backgroundColor = [UIColor colorWithRed: R / 255.0 green: G / 255.0 blue: B / 255.0 alpha: 1.0];
    cell.rgbLabel.text = [NSString stringWithFormat: @"R:%@ G:%@ B:%@", r, g, b];
    
    
    return cell;
}

#pragma mark 其他

- (void)addNameView:(BOOL)isAdd {
    [self.colorSchemeView initNameView: isAdd];
    [self.colorSchemeView addNameView];
}

- (void)removeNameView {
    [self.colorSchemeView removeNameView];
}

- (void)confirmAddName:(BOOL)isAdd {
    if ([self.colorSchemeView.textField.text isEqualToString: @""]) {
        NSLog(@"confirmAddName Or DeleteName clicked!");
        return;
    } else {
        NSLog(@"%@", self.colorSchemeView.textField.text);
    }
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token = [userDefaults objectForKey: @"Token"];
    if (isAdd) {
        [self.manager requestResultForAddingName: self.colorSchemeView.textField.text withToken: token success:^(AddNameModel * _Nonnull addNameModel) {
                NSDictionary* dict = [addNameModel toDictionary];
                NSArray* array = dict[@"data"];
                NSLog(@"%@", array);
                [self.colorSchemeModel.nameArray removeAllObjects];
                [self.colorSchemeModel.rgbArray removeAllObjects];
            self.currentIndex = 0;
            if ([array count]) {
                for (NSDictionary* dict in array) {
                    [self.colorSchemeModel.nameArray addObject: dict[@"Name"]];
                    [self.colorSchemeModel.rgbArray addObject: dict[@"color"]];
                }
            }

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.colorSchemeView.tableView reloadData];
                [self.colorSchemeView.collectionView reloadData];
            });
            } failure:^(NSError * _Nonnull error) {
                if (error) NSLog(@"网络连接失败");
            }];
    } else {
        NSLog(@"按下了确认删除键");
        [self.manager requestResultForDeletingName: self.colorSchemeView.textField.text withToken: token success:^(DeleteNameModel * _Nonnull deleteNameModel) {
                    NSDictionary* dict = [deleteNameModel toDictionary];
                    NSArray* array = dict[@"data"];
//                    NSLog(@"%@", array);
                    [self.colorSchemeModel.nameArray removeAllObjects];
                    [self.colorSchemeModel.rgbArray removeAllObjects];
            self.currentIndex = 0;
                if ([array count]) {
                    for (NSDictionary* dict in array) {
                        [self.colorSchemeModel.nameArray addObject: dict[@"Name"]];
                        [self.colorSchemeModel.rgbArray addObject: dict[@"color"]];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.colorSchemeView.tableView reloadData];
                    [self.colorSchemeView.collectionView reloadData];
                });
                } failure:^(NSError * _Nonnull error) {
                    if (error) NSLog(@"网络连接失败");
                }];
    }

    
    [self removeNameView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setNavigationCustomViewWithFrame:(CGRect)frame {
    [self.colorSchemeView initNavigationCustomViewWithFrame: frame];
    self.navigationItem.titleView = self.colorSchemeView.navigationCustomView;
}

@end
