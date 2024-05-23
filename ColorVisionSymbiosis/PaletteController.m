//
//  PaletteController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/18.
//

#import "PaletteController.h"
#import "PanView.h"

@interface PaletteController () <UIPopoverPresentationControllerDelegate, UIColorPickerViewControllerDelegate>

@property (nonatomic, strong)UIBarButtonItem* barItem;
@property (nonatomic, strong)UIColorPickerViewController* colorPickerViewController;
@property (nonatomic, strong)UIPopoverPresentationController* popoverPresentationController;
//@property (nonatomic, strong)UIView* cyanView;

@end

@implementation PaletteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.backView = [self backView];;
    self.backView.center = self.view.center;
    self.backView.image = [UIImage imageNamed: @"nihao.jpg"];
    self.backView.userInteractionEnabled = YES;
    [self.view addSubview: self.backView];
    
    self.barItem = [[UIBarButtonItem alloc] initWithTitle: @"调色板🎨" style: UIBarButtonItemStylePlain target: self action: @selector(rightButtonTapped:)];
    self.barItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = self.barItem;
    self.title = @"点击图片进行换取";
    
//    self.cyanView = [[UIView alloc] initWithFrame: CGRectMake(77, 77, 53, 53)];
//    self.cyanView.backgroundColor = [UIColor cyanColor];
//    self.cyanView.layer.borderColor = [UIColor blackColor].CGColor;
//    self.cyanView.layer.borderWidth = 3.0;
//    [self.view addSubview: self.cyanView];
//    UIPanGestureRecognizer* panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(pan:)];
//    [self.cyanView addGestureRecognizer: panGestureRecognizer];
    [self setPanView];

}

- (void)setTitle:(NSString *)title {
//    [super setTitle: title];
    UILabel *titleLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.text             = title;
    titleLabel.font             = [UIFont boldSystemFontOfSize:20.f];
    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.textColor        = [UIColor blackColor];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark 上传图片部分

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        _backView.backgroundColor = [UIColor grayColor];
        _backView.center = self.view.center;
        //下方的firstImage.jpg为初始化图片，可自定义
        _backView.image = [UIImage imageNamed:@"nihao.jpg"];
        //下方设置为YES使图片可以触发点击事件
        _backView.userInteractionEnabled = YES;
        UITapGestureRecognizer *clickTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage)];
        [_backView addGestureRecognizer:clickTap];
    }
    return _backView;
}

- (void)chooseImage {
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            self.imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:self.imagePickerController animated:YES completion:nil];
        }
    }];
  
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        self.imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

//获取选择的图片
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    CGFloat maxBackViewSize = MIN(self.view.bounds.size.width, self.view.bounds.size.height);
    CGFloat scaleFactor = MIN(maxBackViewSize / imageWidth, maxBackViewSize / imageHeight);
    CGFloat backViewWidth = imageWidth * scaleFactor;
    CGFloat backViewHeight = imageHeight * scaleFactor;
    
    self.backView.frame = CGRectMake(0, 0, backViewWidth, backViewHeight);
    self.backView.center = self.view.center;
    self.backView.image = image;
    
}

//从相机或相册界面弹出
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 可拖动View

- (void)setPanView {
    PanView* panView1 = [[PanView alloc] initWithFrame: CGRectMake(0, 0, 53, 53) withView: self.view andBackView: self.backView andNumber: @"1"];
    panView1.center = self.view.center;
    panView1.numLabel.text = @"1";
    [self.view addSubview: panView1];

    PanView* panView2 = [[PanView alloc] initWithFrame: CGRectMake(0, 0, 53, 53) withView: self.view andBackView: self.backView andNumber: @"2"];
    panView2.center = self.view.center;
    panView2.numLabel.text = @"2";
    [self.view addSubview: panView2];

    PanView* panView3 = [[PanView alloc] initWithFrame: CGRectMake(0, 0, 53, 53) withView: self.view andBackView: self.backView andNumber: @"3"];
    panView3.center = self.view.center;
    panView3.numLabel.text = @"3";
    [self.view addSubview: panView3];

    PanView* panView4 = [[PanView alloc] initWithFrame: CGRectMake(0, 0, 53, 53) withView: self.view andBackView: self.backView andNumber: @"4"];
    panView4.center = self.view.center;
    panView4.numLabel.text = @"4";
    [self.view addSubview: panView4];
    
}

#pragma mark 调色板部分

- (void)rightButtonTapped:(id)sender {
    if (!self.colorPickerViewController) {
        self.colorPickerViewController = [[UIColorPickerViewController alloc] init];
        self.colorPickerViewController.delegate = self;
        self.colorPickerViewController.preferredContentSize = CGSizeMake(10, 10);
        self.colorPickerViewController.modalPresentationStyle = UIModalPresentationPopover;
    }
    if (!self.popoverPresentationController) {
        self.popoverPresentationController = [self.colorPickerViewController popoverPresentationController];
        self.popoverPresentationController.delegate = self;
        self.popoverPresentationController.barButtonItem = self.barItem;
    }
    
    [self presentViewController: self.colorPickerViewController animated: YES completion: nil];
}

// 设立实现代理，注意要返回UIModalPresentationNone
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
