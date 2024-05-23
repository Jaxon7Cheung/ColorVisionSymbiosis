//
//  ColorCameraController.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/12.
//

#import "ColorCameraController.h"
#import <AVFoundation/AVFoundation.h>
#import "Masonry/Masonry.h"

@interface ColorCameraController () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong)AVCaptureSession* captureSession;
@property (nonatomic, strong)AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong)UIView* colorView;
@property (nonatomic, strong)UILabel* colorLabel;

@property (nonatomic, strong) UIButton *cameraToggleButton;
@property (nonatomic, assign) AVCaptureDevicePosition currentCameraPosition;

//@property (nonatomic, strong)UISlider *zoomSlider;


@end

@implementation ColorCameraController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    AVCaptureDevice* videoDevice = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];
    NSError* error = nil;
    AVCaptureDeviceInput* videoInput = [AVCaptureDeviceInput deviceInputWithDevice: videoDevice error: &error];
    [self.captureSession addInput: videoInput];
    
    AVCaptureVideoDataOutput* videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    videoOutput.videoSettings = @{(id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)};
    [videoOutput setSampleBufferDelegate: self queue: dispatch_get_main_queue()];
    [self.captureSession addOutput: videoOutput];
    
    [self.captureSession startRunning];
    
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession: self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer: self.previewLayer];
    
    UIBlurEffect* blur = [UIBlurEffect effectWithStyle: UIBlurEffectStyleSystemThinMaterialDark];
    UIVisualEffectView* effectview = [[UIVisualEffectView alloc] initWithEffect: blur];
    effectview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height / 8);
//    effectview.alpha = 0.97;
    [self.view addSubview: effectview];
//    UIBlurEffect* blurS = [UIBlurEffect effectWithStyle: UIBlurEffectStyleSystemThinMaterialDark];
    UIVisualEffectView* effectviewS = [[UIVisualEffectView alloc] initWithEffect: blur];
    effectviewS.frame = CGRectMake(0, self.view.bounds.size.height * 6 / 7, self.view.bounds.size.width, self.view.bounds.size.height / 7);
//    effectviewS.alpha = 0.97;
    [self.view addSubview: effectviewS];
    
    UIView* centerPoint = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 23, 2)];
    centerPoint.center = self.view.center;
    centerPoint.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: centerPoint];
    UIView* centerPointS = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 2, 23)];
    centerPointS.center = self.view.center;
    centerPointS.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: centerPointS];
    
    self.colorView = [[UIView alloc] init];
    self.colorView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.colorView.layer.borderWidth = 2.7;
    [self.view addSubview: self.colorView];
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(effectview.mas_centerY).mas_offset(17);
            make.size.mas_equalTo(47);
            make.left.mas_equalTo(effectview.mas_left).mas_offset(37);
    }];
    
    self.colorLabel = [[UILabel alloc] initWithFrame: CGRectMake(137, 22, 177, 37)];
    self.colorLabel.textColor = [UIColor whiteColor];
    [self.view addSubview: self.colorLabel];
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.colorView.mas_right).mas_offset(17);
            make.right.mas_equalTo(effectview.mas_right).mas_offset(-107);
            make.centerY.mas_equalTo(effectview.mas_centerY).mas_offset(17);
    }];
    
    
    
    self.cameraToggleButton = [[UIButton alloc] init];
    [self.cameraToggleButton setTitle:@"Back" forState: UIControlStateNormal];
    [self.cameraToggleButton setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [self.cameraToggleButton addTarget:self action:@selector(toggleCameraPosition) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cameraToggleButton];
    [self.cameraToggleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(effectview.mas_right).mas_offset(-17);
            make.size.mas_equalTo(self.colorView).multipliedBy(2);
        make.centerY.mas_equalTo(effectview.mas_centerY).mas_offset(17);
    }];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.view.frame) - 60);
//    [button setImage:[UIImage imageNamed:@"Close_icn"] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = button.bounds.size.width/2.0f;
    [button addTarget:self action:@selector(popMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
//    self.zoomSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(self.colorView.frame) + 20, CGRectGetWidth(self.view.frame) - 40, 20)];
//    [self.zoomSlider addTarget:self action:@selector(zoomSliderChanged:) forControlEvents:UIControlEventValueChanged];
//    self.zoomSlider.minimumValue = 1.0;
//    self.zoomSlider.maximumValue = videoDevice.activeFormat.videoMaxZoomFactor;
//    [self.view addSubview:self.zoomSlider];
    
    self.colorStyles = @[@{@"name" : @"黑色", @"rgb" : @[@0, @0, @0], @"code" : @"#000000"}, @{@"name" : @"白色", @"rgb" : @[@255, @255, @255], @"code" : @"#FFFFFF"}, @{@"name" : @"象牙黑", @"rgb" : @[@88, @87, @86], @"code" : @"#666666"}, @{@"name" : @"天蓝灰", @"rgb" : @[@202, @235, @216], @"code" : @"#F0FFFF"}, @{@"name" : @"冷灰", @"rgb" : @[@128, @138, @135], @"code" : @"#808A87"}, @{@"name" : @"灰色", @"rgb" : @[@192, @192, @192], @"code" : @"#CCCCCC"}, @{@"name" : @"暖灰", @"rgb" : @[@128, @118, @105], @"code" : @"#808069"}, @{@"name" : @"象牙灰", @"rgb" : @[@251, @255, @242], @"code" : @"#FAFFF0"}, @{@"name" : @"石板灰", @"rgb" : @[@118, @128, @105], @"code" : @"#E6E6E6"}, @{@"name" : @"亚麻灰", @"rgb" : @[@250, @240, @230], @"code" : @"#FAF0E6"}, @{@"name" : @"白烟灰", @"rgb" : @[@245, @245, @245], @"code" : @"#F5F5F5"}, @{@"name" : @"杏仁灰", @"rgb" : @[@255, @235, @205], @"code" : @"#FFFFCD"}, @{@"name" : @"蛋壳灰", @"rgb" : @[@252, @230, @202], @"code" : @"#FCE6C9"}, @{@"name" : @"贝壳灰", @"rgb" : @[@255, @245, @238], @"code" : @"#FFF5EE"}, @{@"name" : @"红色", @"rgb" : @[@255, @0, @0], @"code" : @"#FF0000"}, @{@"name" : @"黄色", @"rgb" : @[@255, @255, @0], @"code" : @"#FFFF00"}, @{@"name" : @"镉红", @"rgb" : @[@227, @23, @13], @"code" : @"#E3170D"}, @{@"name" : @"镉黄", @"rgb" : @[@255, @153, @18], @"code" : @"#FF9912"}, @{@"name" : @"砖红", @"rgb" : @[@156, @102, @31], @"code" : @"#9C661F"}, @{@"name" : @"香蕉黄", @"rgb" : @[@227, @207, @87], @"code" : @"#E3CF57"}, @{@"name" : @"珊瑚红", @"rgb" : @[@255, @127, @80], @"code" : @"#FF7F50"}, @{@"name" : @"金黄", @"rgb" : @[@255, @215, @0], @"code" : @"#FFD700"}, @{@"name" : @"番茄红", @"rgb" : @[@255, @99, @71], @"code" : @"#FF6347"}, @{@"name" : @"肉黄", @"rgb" : @[@255, @125, @64], @"code" : @"#FF7D40"}, @{@"name" : @"粉红", @"rgb" : @[@255, @192, @203], @"code" : @"#FFC0CB"}, @{@"name" : @"粉黄", @"rgb" : @[@255, @227, @132], @"code" : @"#FFE384"}, @{@"name" : @"印度红", @"rgb" : @[@176, @23, @31], @"code" : @"#B0171F"}, @{@"name" : @"橘黄", @"rgb" : @[@255, @128, @0], @"code" : @"#FF8000"}, @{@"name" : @"深红", @"rgb" : @[@255, @0, @255], @"code" : @"#FF00FF"}, @{@"name" : @"萝卜黄", @"rgb" : @[@237, @145, @33], @"code" : @"#ED9121"}, @{@"name" : @"黑红", @"rgb" : @[@116, @0, @0], @"code" : @"#990033"}, @{@"name" : @"黑黄", @"rgb" : @[@85, @102, @0], @"code" : @"#8B864E"}, @{@"name" : @"绿色", @"rgb" : @[@0, @255, @0], @"code" : @"#00FF00"}, @{@"name" : @"棕色", @"rgb" : @[@128, @42, @42], @"code" : @"#802A2A"}, @{@"name" : @"青色", @"rgb" : @[@0, @255, @255], @"code" : @"#00FFFF"}, @{@"name" : @"土色", @"rgb" : @[@199, @97, @20], @"code" : @"#C76114"}, @{@"name" : @"黄绿色", @"rgb" : @[@127, @255, @0], @"code" : @"#7FFF00"}, @{@"name" : @"沙棕色", @"rgb" : @[@244, @164, @95], @"code" : @"#F4A460"}, @{@"name" : @"青绿色", @"rgb" : @[@64, @224, @205], @"code" : @"#40E0D0"}, @{@"name" : @"棕褐色", @"rgb" : @[@210, @180, @140], @"code" : @"#D2B48C"}, @{@"name" : @"靛青色", @"rgb" : @[@8, @46, @84], @"code" : @"#082E54"}, @{@"name" : @"玫瑰红", @"rgb" : @[@188, @143, @143], @"code" : @"#BC8F8F"}, @{@"name" : @"森林绿", @"rgb" : @[@34, @139, @34], @"code" : @"#228B22"}, @{@"name" : @"赫色", @"rgb" : @[@160, @82, @45], @"code" : @"#A0522D"}, @{@"name" : @"草绿色", @"rgb" : @[@107, @142, @35], @"code" : @"#6B8E23"}, @{@"name" : @"肖贡土色", @"rgb" : @[@199, @97, @20], @"code" : @"#C76114"}, @{@"name" : @"蓝色", @"rgb" : @[@0, @0, @255], @"code" : @"#0000FF"}, @{@"name" : @"肖贡土色", @"rgb" : @[@160, @32, @240], @"code" : @"#A020F0"}, @{@"name" : @"锰蓝", @"rgb" : @[@3, @168, @158], @"code" : @"#03A89E"}, @{@"name" : @"淡紫色", @"rgb" : @[@218, @112, @214], @"code" : @"#DA70D6"}, @{@"name" : @"深蓝", @"rgb" : @[@25, @25, @112], @"code" : @"#191970"}, @{@"name" : @"紫罗兰", @"rgb" : @[@138, @43, @226], @"code" : @"#8A2BE2"}, @{@"name" : @"土耳其蓝", @"rgb" : @[@0, @199, @140], @"code" : @"#00C78C"}, @{@"name" : @"胡紫色", @"rgb" : @[@153, @51, @250], @"code" : @"#9933FA"}];
}

// 视频数据输出的代理方法
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // 获取视频帧的图像数据
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    
    // 锁定像素缓冲区的基地址
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    // 获取像素缓冲区的基地址和大小
    uint8_t* baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer);
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    // 计算中心点像素位置
    NSUInteger x = width / 2;
    NSUInteger y = height / 2;
    NSUInteger byteIndex = 4 * (width * y + x);
    
    // 获取中心点的 RGB 颜色信息
    UInt8 blue = baseAddress[byteIndex];
    UInt8 green = baseAddress[byteIndex + 1];
    UInt8 red = baseAddress[byteIndex + 2];
    
    // 解锁像素缓冲区的基地址
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    NSLog(@"Center RGB Color - Red: %d, Green: %d, Blue: %d", red, green, blue);
    
    // 在这里可以将 RGB 颜色信息用途你需要的方式进行处理
    
    
    NSArray* realTimeRGB = @[@(red), @(green), @(blue)];
    self.colorLabel.text = [self searchMatchedColor: realTimeRGB];
    
    self.colorView.backgroundColor = [UIColor colorWithRed: red / 255.0 green: green / 255.0 blue: blue / 255.0 alpha: 1.0];
}

- (void)toggleCameraPosition {
    // 寻找要切换到的摄像头位置
    AVCaptureDevicePosition desiredPosition;
    if (self.currentCameraPosition == AVCaptureDevicePositionBack) {
        desiredPosition = AVCaptureDevicePositionFront;
        [self.cameraToggleButton setTitle:@"Front" forState: UIControlStateNormal];
    } else {
        desiredPosition = AVCaptureDevicePositionBack;
        [self.cameraToggleButton setTitle:@"Back" forState: UIControlStateNormal];
    }

    // 查找拥有所需位置的AVCaptureDevice并切换到该位置
    NSArray<AVCaptureDeviceType> *deviceTypes = @[AVCaptureDeviceTypeBuiltInWideAngleCamera, AVCaptureDeviceTypeBuiltInTelephotoCamera];
    AVCaptureDeviceDiscoverySession *discoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:deviceTypes mediaType:AVMediaTypeVideo position:desiredPosition];

    for (AVCaptureDevice *device in discoverySession.devices) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];

        if (newVideoInput) {
            [self.captureSession beginConfiguration];
            // 移除现有的输入
            for (AVCaptureInput *input in self.captureSession.inputs) {
                [self.captureSession removeInput:input];
            }
            // 添加新的输入
            [self.captureSession addInput:newVideoInput];
            [self.captureSession commitConfiguration];
            self.currentCameraPosition = desiredPosition;
            break;
        } else {
            NSLog(@"创建AVCaptureDeviceInput时出错: %@", error.localizedDescription);
        }
    }
}

//- (void)zoomSliderChanged:(UISlider *)slider {
////    CGFloat scale = 0.0;
////    if (slider.value > 27) {
////        scale = slider.value;
////    } else {
////        scale = slider.value / 10;
////    }
//    CGFloat scale = slider.value;
//    // 使用affineTransform来实现预览图像的缩放
//    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
//    self.previewLayer.affineTransform = transform;
//}

- (NSString *)searchMatchedColor: (NSArray *)realTimeRGB {
    CGFloat minDistance = CGFLOAT_MAX;
    NSInteger matchedIndex = -1;
    
    for (NSInteger i = 0; i < self.colorStyles.count; i++) {
        NSDictionary *colorStyle = self.colorStyles[i];
        NSArray *rgb = colorStyle[@"rgb"];
        
        // 欧几里德距离的平方
        CGFloat distanceSquared = pow([rgb[0] floatValue] - [realTimeRGB[0] floatValue], 2) + pow([rgb[1] floatValue] - [realTimeRGB[1] floatValue], 2) + pow([rgb[2] floatValue] - [realTimeRGB[2] floatValue], 2);
        
        
        if (distanceSquared < minDistance) {
            minDistance = distanceSquared;
            matchedIndex = i;
        }
    }
    
    NSString *matchedColorName = self.colorStyles[matchedIndex][@"name"];
    NSString* matchedColorHex = self.colorStyles[matchedIndex][@"code"];
    NSLog(@"匹配到的颜色名称：%@ - %@", matchedColorName, matchedColorHex);
    
    
    NSString* colorString = [NSString stringWithFormat: @"%@ - %@", matchedColorName, matchedColorHex];
    
    
    return colorString;
}

- (void)popMethod {
    [self.captureSession stopRunning];
    [self.navigationController popViewControllerAnimated: YES];
    
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
