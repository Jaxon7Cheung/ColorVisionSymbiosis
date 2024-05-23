//
//  MainPageController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/8.
//

#import "MainPageController.h"
#import "MainPageView.h"
#import "BubbleTransition.h"
#import "NavigationCustomView.h"
#import "MainPageModel.h"
#define MINIGAP [UIScreen mainScreen].bounds.size.width / 16
#import "SquareCell.h"
#import "ColorCamera/ColorCameraController.h"
#import "ColorBlockGame/ColorGameController.h"
#import "ColorScheme/ColorSchemeController.h"
#import "PaletteController.h"
#import "DemoViewController.h"
#import "MultiLevelExampleVC.h"

@interface MainPageController () <DidSelectPageDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation MainPageController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: NO];
//    [self.navigationCustomView layoutSubviews];
    self.xl_popTranstion = nil;
    self.xl_pushTranstion = nil;
    
    // 更新布局
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpViewAndModel];
    
    
//    UIView* titleView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 100, 40)];
//    titleView.backgroundColor = [UIColor magentaColor];
//    self.navigationItem.titleView = titleView;
    
    
}

- (void)setUpViewAndModel {
    self.mainPageModel = [[MainPageModel alloc] init];
    
    self.mainPageView = [[MainPageView alloc] initWithFrame: self.view.bounds];
    self.mainPageView.delegate = self;
    self.mainPageView.collectionView.dataSource = self;
    self.mainPageView.collectionView.delegate = self;
    [self.view addSubview: self.mainPageView];
    
    [self.navigationItem setHidesBackButton: YES];
    
    self.navigationCustomView = [[NavigationCustomView alloc] initWithFrame: self.navigationController.navigationBar.bounds];
    self.navigationCustomView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = self.navigationCustomView;
    
    
//    self.collectionView = UICollectionView
}

#pragma mark DidSelectPageDelegate协议函数
- (void)selectCamera {
    self.xl_popTranstion = [BubbleTransition transitionWithAnchorRect: self.mainPageView.button.frame];
    self.xl_pushTranstion = [BubbleTransition transitionWithAnchorRect: self.mainPageView.button.frame];
    
//    UIViewController* viewController = [[UIViewController alloc] init];
//    viewController.view.backgroundColor = [UIColor magentaColor];
    ColorCameraController* colorCameraController = [[ColorCameraController alloc] init];
    
//    NSLog(@"%@", self.navigationController);
    [self.navigationController pushViewController: colorCameraController animated: YES];
}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.navigationController popViewControllerAnimated:true];
//}

#pragma mark CollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.mainPageModel.collectionArray count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SquareCell* squareCell = nil;
    
    if (indexPath.item == 0 || indexPath.item == 1 || indexPath.item == 3 || indexPath.item == 4) {
        squareCell = [collectionView dequeueReusableCellWithReuseIdentifier: @"squareCell" forIndexPath: indexPath];
        if (!indexPath.item) {
            squareCell.titleLabel.text = @"快速找出色块中不一样的颜色";
            squareCell.mainLabel.text = @"色觉挑战";
            squareCell.iconView.image = [UIImage imageNamed: @"sejue.png"];
        } else if (indexPath.item == 1) {
            squareCell.titleLabel.text = @"一分钟快速完成色弱测试";
            squareCell.mainLabel.text = @"色盲检测集";
            squareCell.iconView.image = [UIImage imageNamed: @"tiji.png"];
        } else if (indexPath.item == 3) {
            squareCell.titleLabel.text = @"一个好用的颜色收纳功能";
            squareCell.mainLabel.text = @"配色方案";
            squareCell.iconView.image = [UIImage imageNamed: @"peisefangan.png"];
        } else if (indexPath.item == 4) {
            squareCell.titleLabel.text = @"吸取图片中特定区域颜色";
            squareCell.mainLabel.text = @"图片取色";
            squareCell.iconView.image = [UIImage imageNamed: @"palette.png"];
        }

    } else {
        if (indexPath.item == 2) {
            squareCell = [collectionView dequeueReusableCellWithReuseIdentifier: @"longCell" forIndexPath: indexPath];
            squareCell.iconView.image = [UIImage imageNamed: @"article.png"];
            squareCell.titleLabel.text = @"深入了解色盲现象，增加对色盲议题的认识和理解";
            squareCell.mainLabel.text = @"科普文章和视频";
        } else {
            squareCell = [collectionView dequeueReusableCellWithReuseIdentifier: @"longCell" forIndexPath: indexPath];
            squareCell.iconView.image = [UIImage imageNamed: @"jiantou.png"];
//            squareCell.iconView.frame = CGRectMake(squareCell.bounds.size.height * 2 / 3, squareCell.bounds.size.height / 6, squareCell.bounds.size.height / 1.5, squareCell.bounds.size.height / 1.5);
            squareCell.titleLabel.text = @"点击下方相机📷，将世界的颜色装进你的手机";
            squareCell.mainLabel.text = @"采色识别";
        }
        
    }
    
//    if (indexPath.item == 4) {
//        UIImageView* eyeIcon = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"eye.png"]];
//        NSInteger along = Screen_WIDTH * 0.21 - MINIGAP * 2 / 3;
//        eyeIcon.frame = CGRectMake(along / 6, along / 6, Screen_WIDTH * 0.14 - MINIGAP * 4 / 9, Screen_WIDTH * 0.14 - MINIGAP * 4 / 9);
//        [circleCell.contentView addSubview: eyeIcon];
//    }

    
//    circleCell.layer.masksToBounds = YES;
//    circleCell.layer.borderWidth = 2.0;
//    circleCell.layer.borderColor = [UIColor blackColor].CGColor;
//    circleCell.backgroundColor = self.colorArray[indexPath.item];
    
    return squareCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemHeight = (collectionView.bounds.size.width - MINIGAP) / 2;
    if (indexPath.item == 2) {
        return CGSizeMake(collectionView.bounds.size.width, itemHeight);
    } else if (indexPath.item == 5) {
        return CGSizeMake(collectionView.bounds.size.width, itemHeight / 1.5);
    } else {
        return CGSizeMake(itemHeight, itemHeight);
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        ColorGameController* colorGameController = [[ColorGameController alloc] init];
        [self.navigationController pushViewController: colorGameController animated: YES];
    } else if (indexPath.item == 3) {
        ColorSchemeController* colorSchemeController = [[ColorSchemeController alloc] init];
        [self.navigationController pushViewController: colorSchemeController animated: YES];
    } else if (indexPath.item == 4) {
        PaletteController* paletteController = [[PaletteController alloc] init];
        [self.navigationController pushViewController: paletteController animated: YES];
    } else if (indexPath.item == 1) {
        DemoViewController* demoViewController = [[DemoViewController alloc] init];
        [self.navigationController pushViewController: demoViewController animated: YES];
    } else if (indexPath.item == 2) {
        MultiLevelExampleVC* multiLevelExampleVC = [[MultiLevelExampleVC alloc] init];
        [self.navigationController pushViewController: multiLevelExampleVC animated: YES];
    } else {
        NSLog(@"cell被点击");
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
