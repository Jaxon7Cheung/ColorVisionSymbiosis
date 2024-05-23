//
//  ColorSchemeView.m
//  ColorVisionSymbiosis
//
//  Created by 张旭洋 on 2024/4/15.
//

#import "ColorSchemeView.h"
#import "Masonry/Masonry.h"

@implementation ColorSchemeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, self.bounds.size.height / 9, self.bounds.size.width / 3.7, self.bounds.size.height * 7 / 9)];
    self.tableView.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 27.0;
    self.tableView.backgroundColor = [UIColor colorWithRed: 241 / 255.0 green: 241 / 255.0 blue: 241 / 255.0 alpha: 1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview: self.tableView];
//    [self.tableView selectRowAtIndexPath: [NSIndexPath indexPathForRow: 0 inSection: 0] animated: NO scrollPosition: UITableViewScrollPositionNone];
    
    UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    CGFloat itemWidth = (self.bounds.size.width * (1 - 1 / 3.7) - 10 - flowLayout.minimumInteritemSpacing) / 2;
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    self.collectionView = [[UICollectionView alloc] initWithFrame: CGRectMake(0, 0, 25, 25) collectionViewLayout: flowLayout];
    self.collectionView.frame = CGRectMake(self.bounds.size.width / 3.7 + 5, self.bounds.size.height / 9, self.bounds.size.width * (1 - 1 / 3.7) - 10, self.bounds.size.height * 7 / 9);
//    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.collectionView];
    
    self.addNameButton = [UIButton buttonWithType: UIButtonTypeCustom];
//    self.addNameButton.frame = CGRectMake(25, 350, 77, 77);
    self.addNameButton.tag = 101;
    [self.addNameButton setImage: [UIImage imageNamed: @"plus.png"] forState: UIControlStateNormal];
//    self.addNameButton.imageView.frame =
    [self.addNameButton addTarget: self action: @selector(appearAddView:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: self.addNameButton];
    [self.addNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(67);
            make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(17);
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
    }];
    
    self.deleteNameButton = [UIButton buttonWithType: UIButtonTypeCustom];
//    self.deleteNameButton.frame = CGRectMake(25, 450, 67, 77);
    self.deleteNameButton.tag = 100;
    [self.deleteNameButton setImage: [UIImage imageNamed: @"minus.png"] forState: UIControlStateNormal];
    [self.deleteNameButton addTarget: self action: @selector(appearAddView:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: self.deleteNameButton];
    [self.deleteNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(67);
            make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(17);
        make.centerX.mas_equalTo(self.collectionView.mas_centerX);
    }];
    
}

//创建方案
- (void)initNameView:(BOOL)isAdd {
    self.view = [[UIView alloc] initWithFrame: self.bounds];
    self.view.backgroundColor = [UIColor colorWithRed: 0.0 green: 0.0 blue: 0.0 alpha: 0.15];
    
    self.alertView = [[UIView alloc] init];
    self.alertView.backgroundColor = [UIColor whiteColor];
//    self.alertView.frame = CGRectMake(0, 0, self.view.bounds.size.width * 2.5 / 3, self.view.bounds.size.height / 5);
//    self.alertView.center = self.view.center;
    [self.view addSubview: self.alertView];
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.bounds.size.width * 2.5 / 3);
            make.height.mas_equalTo(self.view.bounds.size.height / 5);
            make.center.mas_equalTo(self.view);
    }];
    
    self.textField = [[UITextField alloc] init];
//    textField.frame = CGRectMake(0, 0, alertView.bounds.size.width * 2.5 / 3, 37);
//    textField.center = alertView.center;
//    self.textField.placeholder = @"Hhhhhhh";
    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.textColor = [UIColor blackColor];
    [self.view addSubview: self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.bounds.size.width / 1.5);
            make.height.mas_equalTo(37);
        make.top.mas_equalTo(self.alertView.mas_top).offset(57);
        make.centerX.mas_equalTo(self.alertView.mas_centerX);
    }];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont boldSystemFontOfSize: 15];
    self.nameLabel.text = @"方案名：";
    self.nameLabel.textColor = [UIColor blackColor];
    [self.view addSubview: self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.alertView.mas_top).mas_offset(27);
            make.width.mas_equalTo(self.view.bounds.size.width * 2.5 / 3);
        make.height.mas_equalTo(27);
        make.left.mas_equalTo(self.textField.mas_left);
    }];
    
    self.confirmAddButton = [UIButton buttonWithType: UIButtonTypeCustom];
    self.confirmAddButton.backgroundColor = [UIColor brownColor];
    [self.view addSubview: self.confirmAddButton];
    [self.confirmAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.view.bounds.size.width * 2.5 / 3);
            make.height.mas_equalTo(51);
            make.bottom.mas_equalTo(self.alertView.mas_bottom);
        make.centerX.mas_equalTo(self.alertView.mas_centerX);
    }];
    [self.confirmAddButton addTarget: self action: @selector(confirmAdd:) forControlEvents: UIControlEventTouchUpInside];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(removeAddView)];
    [self.view addGestureRecognizer: tapGesture];
    
//    self.addNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(77);
//
//    }
    
    if (isAdd) {
        self.textField.placeholder = @"请输入要添加的方案名";
        [self.confirmAddButton setTitle: @"确认添加" forState: UIControlStateNormal];
        self.confirmAddButton.tag = 201;
    } else {
        self.textField.placeholder = @"请输入要删除的方案名";
        [self.confirmAddButton setTitle: @"确认删除" forState: UIControlStateNormal];
        self.confirmAddButton.tag = 200;
    }
}

- (void)confirmAdd:(UIButton *)button {
    [_delegate confirmAddName: button.tag - 200];
}

- (void)appearAddView:(UIButton *)button {
    [_delegate addNameView: button.tag - 100];
}
- (void)addNameView {
//    [[UIApplication sharedApplication].keyWindow addSubview: self.view];
    [self addSubview: self.view];
}

- (void)removeAddView {
//    [self.alertView removeFromSuperview];
//    [self.textField removeFromSuperview];
//    [self.confirmAddButton removeFromSuperview];
    [_delegate removeNameView];
}
- (void)removeNameView {
    for (UIView* subView in self.view.subviews) {
        [subView removeFromSuperview];
    }
    [self.view removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initNavigationCustomViewWithFrame:(CGRect)frame {
    self.navigationCustomView = [[UIView alloc] initWithFrame: frame];
    
    UIImageView* triColor = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"sanse.png"]];
    triColor.frame = CGRectMake(self.navigationCustomView.bounds.size.width - (77 + 17), (self.navigationCustomView.bounds.size.height - 37) / 2, 47, 47);
    [self.navigationCustomView addSubview: triColor];
    
    UILabel *titleLabel         = [[UILabel alloc] initWithFrame: CGRectMake((self.navigationCustomView.bounds.size.width - 177) / 2, (self.navigationCustomView.bounds.size.height - 37) / 2, 177, 37)];
    titleLabel.text             = @"配色方案";
    titleLabel.font             = [UIFont boldSystemFontOfSize: 20.f];
//    titleLabel.textAlignment    = NSTextAlignmentCenter;
    titleLabel.textColor        = [UIColor blackColor];
    [self.navigationCustomView addSubview: titleLabel];
    
}

@end
