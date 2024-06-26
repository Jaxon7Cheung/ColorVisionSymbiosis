//
//  DemoViewController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import "DemoViewController.h"
#import "XLCardSwitch.h"
#import "Manager.h"
#import "ColorTestModel.h"
#import "XLCardCell.h"
#import <SDWebImage/SDWebImage.h>
#import "ReturnModel.h"

#define myWidth [UIScreen mainScreen].bounds.size.width
#define myHeight [UIScreen mainScreen].bounds.size.height

NSMutableArray * _Nullable optionArray;

@interface DemoViewController ()<XLCardSwitchDelegate, UICollectionViewDelegate, UICollectionViewDataSource, XLCardCellDelegate>

@property (nonatomic, strong) XLCardSwitch *cardSwitch;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray<XLCardModel *> *models;

@property (nonatomic, strong) NSMutableArray<ReturnModel *> *returnModels;

@property (nonatomic, strong) NSDictionary *dictionaryModel;

@property (nonatomic, strong) NSDictionary *optionDictionaryModel;

//@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, assign) BOOL showSubmitButton;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    optionArray = [NSMutableArray arrayWithCapacity:4];
    NSLog(@"self.model.count = %lu",(unsigned long)self.models.count);
    
    for (NSInteger i = 0; i < 4; i++) {
        [optionArray addObject:@""];
    }

    
//    [self configNavigationBar];
    
//    [self addImageView];

//    [self addCardSwitch];
//    [self addImageView];

//    self.cardSwitch.collectionView.delegate = self;
//    self.cardSwitch.collectionView.dataSource = self;
    
//    [self test];
    
//换成这个就好了
    [self getColorTestModel];
}

//- (void)test {
//    [self saveData:[[NSArray alloc] init]];
//}

- (void)getColorTestModel {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token = [userDefaults objectForKey: @"Token"];
    
    [[Manager sharedManager] requestColorBlindTest: token success:^(ColorTestModel * _Nonnull colorTestModel) {
        
        //这里有个理解，Model本身，一定是一个字典，只是，你拿到什么数据，取决于你Model中定义了哪些属性，所以先转为字典
        self.dictionaryModel = [colorTestModel toDictionary];
//        NSLog(@"网络请求成功");
//        NSLog(@"self.dictionaryModel = %@, %d",self.dictionaryModel,__LINE__);
//        NSLog(@"%@",self.dictionaryModel[@"data"][@"OptionA"]);
        NSArray *dataArray = [[NSArray alloc] initWithArray:self.dictionaryModel[@"data"]];
//        NSLog(@"%@", dataArray);
//        然后这个字典里只有数组data
        [self saveData:dataArray];

//        dispatch_async(dispatch_get_main_queue(), ^{
////            [self addImageView];
////
////            [self addCardSwitch];
////            self.cardSwitch.collectionView.delegate = self;
////            self.cardSwitch.collectionView.dataSource = self;
//            [self.cardSwitch.collectionView reloadData];
//        });
        
    } failure:^(NSError * _Nonnull error) {
        if (error)
            NSLog(@"网络连接失败");
    }];
}

- (void)saveData:(NSArray *)array {
//    self.transDataArray = [[NSMutableArray alloc] init];
    
    self.models = [NSMutableArray new];
    NSMutableDictionary *temDictionary = [[NSMutableDictionary alloc] init];
    
//    for (int a = 0; a < 2; a++) {
////        NSLog(@"%@", dic);
//
//        NSString *string1 = [NSString stringWithFormat:@"123"];
//        NSString *string2 = [NSString stringWithFormat:@"234"];
//        NSString *string3 = [NSString stringWithFormat:@"345"];
//        NSString *string4 = [NSString stringWithFormat:@"456"];
//
//        NSString *imageNameString;
//        if (a == 0) {
//            imageNameString = [NSString stringWithFormat:@"https://media.istockphoto.com/id/1268454483/photo/keelung-islet-and-heping-island-park.jpg?s=2048x2048&w=is&k=20&c=Mp0ohLjpU8hjQ8Jyj7QPfO8fWvUdKD6jiicY1Zb7vck="];
//        } else {
//            imageNameString = [NSString stringWithFormat:@"https://media.istockphoto.com/id/969304474/photo/colorful-houses.webp?s=2048x2048&w=is&k=20&c=v4VidjRSRsoB4iVn8JO6HkYWATrYxa-vlPtT42evT7Q="];
//        }
//
//        [temDictionary setObject:string1 forKey:@"OptionA"];
//        [temDictionary setObject:string2 forKey:@"OptionB"];
//        [temDictionary setObject:string3 forKey:@"OptionC"];
//        [temDictionary setObject:string4 forKey:@"OptionD"];
//        [temDictionary setObject:imageNameString forKey:@"imageName"];
//
//        self.model = [[XLCardModel alloc] init];
//        [self.model setValuesForKeysWithDictionary:temDictionary];
//        [self.models addObject:self.model];
////        [self.transDataArray addObject:temDictionary];
////        NSLog(@"temDictionary = %@",temDictionary);
////        NSLog(@"self.transDataArray = %@",self.transDataArray);
////        NSLog(@"model= %@",self.model.OptionA);
////        NSLog(@"self.models = %@",self.models);
//    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self addImageView];
//        [self addCardSwitch];
//        self.cardSwitch.collectionView.delegate = self;
//        self.cardSwitch.collectionView.dataSource = self;
////        [self.cardSwitch.collectionView reloadData];
//        self.cardSwitch.models = self.models;
//
//        [self configImageViewOfIndex:self.cardSwitch.selectedIndex];
//    });
    
//    for (XLCardModel *model in self.models) {
//        NSLog(@"OptionA: %@", model.OptionA);
//        NSLog(@"OptionB: %@", model.OptionB);
//        NSLog(@"OptionC: %@", model.OptionC);
//        NSLog(@"OptionD: %@", model.OptionD);
//        NSLog(@"imageName: %@", model.imageName);
//        NSLog(@"---------------------");
//    }
    
//这个for循环暂时屏蔽
    for (NSDictionary *dic in array) {
//        NSLog(@"dic = %@", dic);

        NSString *string1 = [NSString stringWithFormat:@"%@", dic[@"OptionA"]];
        NSString *string2 = [NSString stringWithFormat:@"%@", dic[@"OptionB"]];
        NSString *string3 = [NSString stringWithFormat:@"%@", dic[@"OptionC"]];
        NSString *string4 = [NSString stringWithFormat:@"%@", dic[@"OptionD"]];
        NSString *imageName = dic[@"Issue"][@"image"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@"./" withString:@""];
        NSString *imageNameString = [NSString stringWithFormat:@"http://zy520.online:8081/%@", imageName];

//        NSString *imageNameString = [NSString stringWithFormat:@"http://zy520.online:8081/%@", dic[@"Issue"][@"image"]];
//        NSLog(@"imageNameString = %@", imageNameString);

        [temDictionary setObject:string1 forKey:@"OptionA"];
        [temDictionary setObject:string2 forKey:@"OptionB"];
        [temDictionary setObject:string3 forKey:@"OptionC"];
        [temDictionary setObject:string4 forKey:@"OptionD"];
        [temDictionary setObject:imageNameString forKey:@"imageName"];
        
        NSLog(@" temDictionary[] = %@",temDictionary[@"imageName"]);

        XLCardModel *model = [[XLCardModel alloc] init];
        [model setValuesForKeysWithDictionary:temDictionary];
        [self.models addObject:model];
//        [self.transDataArray addObject:temDictionary];
//        NSLog(@"temDictionary = %@",temDictionary);
//        NSLog(@"self.transDataArray = %@",self.transDataArray);
//        NSLog(@"self.transDataArray = %@",self.models);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self addImageView];
        [self addCardSwitch];
        [self.cardSwitch.submitButton addTarget:self action:@selector(submitButtonTapped) forControlEvents:UIControlEventTouchUpInside];
        self.cardSwitch.collectionView.delegate = self;
        self.cardSwitch.collectionView.dataSource = self;
//        [self.cardSwitch.collectionView reloadData];
        self.cardSwitch.models = self.models;
        
        [self configImageViewOfIndex:self.cardSwitch.selectedIndex];
    });
}

//提交按钮的点击方法
- (void)submitButtonTapped {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* token = [userDefaults objectForKey: @"Token"];
    [[Manager sharedManager] postColorBlindOptionArray: token success:^(OptionModel * _Nonnull optionModel) {
        
        self.optionDictionaryModel = [optionModel toDictionary];
        //        NSLog(@"网络请求成功");
        NSArray *dataArray = [[NSArray alloc] initWithArray:self.dictionaryModel[@"data"]];
//        NSLog(@"daraArray = %@", dataArray);
        
        [self saveReturnData:dataArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showPopup];
        });
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"post失败");
    } didSelectOption:optionArray];
}

- (void)showPopup {
    // 创建PopupViewController实例
    PopupViewController *popupViewController = [[PopupViewController alloc] init];
    
    // 设置数据源数组
    popupViewController.dataSourceArray = self.returnModels;
    
    // 设置弹出视图的样式
    popupViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    // 设置弹出视图的大小
    popupViewController.preferredContentSize = CGSizeMake(myWidth, myHeight - 200);
    
    // 弹出视图
    [self presentViewController:popupViewController animated:YES completion:nil];
}

- (void)saveReturnData:(NSArray *)array {
//    self.transDataArray = [[NSMutableArray alloc] init];
    
    self.returnModels = [NSMutableArray new];
    NSMutableDictionary *temDictionary = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dic in array) {
//        NSLog(@"dic = %@", dic);

        NSString *string1 = [NSString stringWithFormat:@"%@", dic[@"Key"]];
        NSString *string2 = [NSString stringWithFormat:@"%@", dic[@"Mykey"]];
        NSString *string3 = [NSString stringWithFormat:@"%@", dic[@"Point"]];
        NSString *Flag = [NSString stringWithFormat:@"%@", dic[@"Flag"]];
        
        NSString *imageName = dic[@"image"];
        imageName = [imageName stringByReplacingOccurrencesOfString:@"./" withString:@""];
        NSString *imageNameString = [NSString stringWithFormat:@"http://zy520.online:8081/%@", imageName];

        [temDictionary setObject:string1 forKey:@"Key"];
        [temDictionary setObject:string2 forKey:@"Mykey"];
        [temDictionary setObject:string3 forKey:@"Point"];
        [temDictionary setObject:imageNameString forKey:@"Image"];
        [temDictionary setObject:Flag forKey:@"Flag"];
        
//        NSLog(@" temDictionary[] = %@",temDictionary[@"imageName"]);

        ReturnModel *model = [[ReturnModel alloc] init];
        [model setValuesForKeysWithDictionary:temDictionary];
        [self.returnModels addObject:model];
    }
    
//    for (ReturnModel *model in self.returnModels) {
//        NSLog(@"Key: %@", model.Key);
//        NSLog(@"Mykey: %@", model.Mykey);
//        NSLog(@"Point: %@", model.Point);
//        NSLog(@"Image: %@", model.Image);
//        NSLog(@"Flag: %@", model.Flag);
//        NSLog(@"---------------------");
//    }
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    
//    });
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    self.imageView.frame = self.view.bounds;
    self.cardSwitch.frame = self.view.bounds;
}

//- (void)configNavigationBar {
//
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];
//    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
//
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
//
//    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"正常滚动", @"自动剧中"]];
//    seg.selectedSegmentIndex = 0;
//    [seg addTarget:self action:@selector(segMethod:) forControlEvents:UIControlEventValueChanged];
//    self.navigationItem.titleView = seg;
//}

- (void)addImageView {
    
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    
    //毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.bounds;
    [self.imageView addSubview:effectView];
}

- (void)addCardSwitch {
    //初始化
    self.cardSwitch = [[XLCardSwitch alloc] initWithFrame:self.view.bounds];
    
    [self.cardSwitch.collectionView registerClass:[XLCardCell class] forCellWithReuseIdentifier:@"XLCardCell"];
    //设置代理方法
    self.cardSwitch.delegate = self;
    //分页切换
    self.cardSwitch.pagingEnabled = true;
    [self.view addSubview:self.cardSwitch];
}


//- (void)buildData {
//    //初始化数据源
////    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"@DataPropertyList" ofType:@"plist"];
////    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
//    self.models = [NSMutableArray new];
////    for (NSDictionary *dic in arr) {
////        XLCardModel *model = [[XLCardModel alloc] init];
////        [model setValuesForKeysWithDictionary:dic];
////        [self.models addObject:model];
////    }
//
////    NSDictionary *testDic = @{@"imageName":@"1.png",@"title":@"艾德·史塔克"};
////    XLCardModel *model = [[XLCardModel alloc] init];
////    [model setValuesForKeysWithDictionary:testDic];
////    NSLog(@"%@, %d", model, __LINE__);
////    [self.models addObject:model];
//
//    //设置卡片数据源
//    self.cardSwitch.models = self.models;
//
//    //更新背景图
//    [self configImageViewOfIndex:self.cardSwitch.selectedIndex];
//}

- (void)segMethod:(UISegmentedControl *)seg {
//    NSLog(@"%ld", seg.selectedSegmentIndex);
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.cardSwitch.pagingEnabled = NO;
            break;
        case 1:
            self.cardSwitch.pagingEnabled = YES;
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return [self.models count];
    return 4;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"XLCardCell";
    XLCardCell *card = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    if (indexPath.item == 0) {
//        card.testButton1.tag = 1;
//        card.testButton1.tag = 1;
//    } else if (indexPath.item == 1) {
//
//    }
    card.delegate = self;
    card.model = self.models[indexPath.item];
    
//    NSString *imageName = [NSString stringWithFormat:@"http://192.168.0.135:8081/%@", self.transDataArray[indexPath.item][@"image"]];
//    NSString *labelA = [NSString stringWithFormat:@"%@", self.transDataArray[indexPath.item][@"OptionA"]];
//    NSString *labelB = [NSString stringWithFormat:@"%@", self.transDataArray[indexPath.item][@"OptionB"]];
//    NSString *labelC = [NSString stringWithFormat:@"%@", self.transDataArray[indexPath.item][@"OptionC"]];
//    NSString *labelD = [NSString stringWithFormat:@"%@", self.transDataArray[indexPath.item][@"OptionD"]];
//
//    card.backgroundColor = [UIColor blueColor];
//
//    card.testImageView.image = [UIImage imageNamed:imageName];
//    card.testLabel1.text = labelA;
//    card.testLabel2.text = labelB;
//    card.testLabel3.text = labelC;
//    card.testLabel4.text = labelD;
//
////    NSLog(@"%@",card.testLabel1.text);
    
    return card;
}

//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (!self.cardSwitch.pagingEnabled) {return;}
    self.cardSwitch.dragStartX = scrollView.contentOffset.x;
    self.cardSwitch.dragAtIndex = self.cardSwitch.selectedIndex;
}

//手指拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.cardSwitch.pagingEnabled) {return;}
    self.cardSwitch.dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cardSwitch fixCellToCenter];
    });
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    self.cardSwitch.selectedIndex = indexPath.row;
    [self.cardSwitch scrollToCenterAnimated:YES];
    [self.cardSwitch performClickDelegateMethod];
}

//点击卡片代理方法
- (void)cardSwitchDidClickAtIndex:(NSInteger)index {
    NSLog(@"点击了：%zd", index);
    [self configImageViewOfIndex:index];
}

//滚动卡片代理方法
- (void)cardSwitchDidScrollToIndex:(NSInteger)index {
    NSLog(@"滚动到了：%zd", index);
    [self configImageViewOfIndex:index];
}


- (void)configImageViewOfIndex:(NSInteger)index {
    //更新背景图
    XLCardModel *model = self.models[index];
//    NSLog(@"model.imageName = %@",model.imageName);
//    ColorTestModel *model = self.models[index];
//    self.imageView.image = [UIImage imageNamed:@"色盲.jpeg"];
    NSURL *url = [NSURL URLWithString:model.imageName];
//    NSURL *url = [NSURL URLWithString:@"http://zy520.online:8081/Asset/Upload/Color/Red/171161834259627142.jpeg"];
//    NSLog(@"url = %@",url);

//    self.imageView = [[UIImageView alloc] init];
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1.png"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"背景图片加载失败");
        } else {
            NSLog(@"背景图片加载成功");
        }
    }];
    
}

- (void)switchPrevious {
    NSInteger index = self.cardSwitch.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

- (void)switchNext {
    NSInteger index = self.cardSwitch.selectedIndex + 1;
    index = index > self.models.count - 1 ? self.models.count - 1 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

//???
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}

//- (void)xlCardCell:(XLCardCell *)cell didSelectOption:(NSString *)option {
//    // 此处应该替换为有效的 token 字符串
//    NSString *token = @"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySW5mb0lkIjoyLCJleHAiOjE3MTE1Njg0MTAsImlhdCI6MTcxMTUyNTIxMCwiaXNzIjoi5bCP6LW1Iiwic3ViIjoiY29sb3IifQ.scmm26xA1azxzdX8EAaTOJ4rNl_qCQALzTTy0ABbZUE";
//
//    [[Manager sharedManager] postColorBlindOptionArray:token success:^(OptionModel * _Nonnull optionModel) {
//        NSLog(@"post success");
//    } failure:^(NSError * _Nonnull error) {
//        NSLog(@"post fail");
//    } didSelectOption:optionArray];
//}

//- (void)cardCell:(XLCardCell *)cell didSelectOption:(NSString *)option atIndex:(NSInteger)index {
//    // 用户点击选项按钮后的处理
//
//    // 更新对应 cell 的选项按钮状态
//    [cell updateButtonSelectionAtIndex:index withOption:option];
//}


- (void)cardCellDidSelectAllOptions:(XLCardCell *)cell isAll:(BOOL)allQuestionAnswered {
    // 当所有题目都有选择时，显示提交按钮
    NSLog(@"allQuestionAnswered = %d", allQuestionAnswered);
    if (allQuestionAnswered) {
//        self.showSubmitButton = YES;
//        [self.cardSwitch.collectionView addSubview:self.submitButton];
        self.cardSwitch.submitButton.hidden = NO; //显示提交按钮
    } else {
//        self.showSubmitButton = NO;
        self.cardSwitch.submitButton.hidden = YES;
    }
}


- (NSIndexPath *)buttonTappedInCell:(UICollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.cardSwitch.collectionView indexPathForCell:cell];
//    NSLog(@"item = %ld", indexPath.item);
    return indexPath;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
