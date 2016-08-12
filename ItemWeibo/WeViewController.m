//
//  WeViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "WeViewController.h"
#import <WeiboSDK.h>
#import <MBProgressHUD.h>
#import "SetViewController.h"
@interface WeViewController ()

@end

@implementation WeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addFriend];
    [self setUI];
  }

- (void)setUI{
    self.title = @"我";
 
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(pushSettingButton:)];
    self.navigationItem.rightBarButtonItem = bar;
      UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_WIDTH/2.11)];
    imageView.image = [UIImage imageNamed:@"my_background"];
    [self.view addSubview:imageView];
    
    UIView *guanzhuView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), UISCREEN_WIDTH, 44)];
    guanzhuView.backgroundColor = [UIColor whiteColor];
    UILabel *guanzhuLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 44)];
    guanzhuLabel.text = @"关注";
    guanzhuLabel.font = [UIFont systemFontOfSize:20];
    [guanzhuView addSubview:guanzhuLabel];
    
    UILabel *checkLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 0, 150, 44)];
    checkLabel.text = @"快看看大家都在观看谁";
    checkLabel.font = [UIFont systemFontOfSize:15];
    checkLabel.textColor = [UIColor grayColor];
    [guanzhuView addSubview:checkLabel];
   
    
    UIImageView *rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH-50, 7,30, 30)];
    rightImage.image = [UIImage imageNamed:@"cut"];
    [guanzhuView addSubview:rightImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkoutGuanzhu:)];
    [guanzhuView addGestureRecognizer:tap];
     [self.view addSubview:guanzhuView];
    
    UILabel *jieshouLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,CGRectGetMaxY(guanzhuView.frame) + (UISCREEN_HEIGHT-CGRectGetMaxY(guanzhuView.frame))/2-60, UISCREEN_WIDTH-120, 60)];
    jieshouLabel.text = @"登录后,你的微薄,相册,个人资料会显示在这里,展示给他人";
    jieshouLabel.textColor = [UIColor grayColor];
    jieshouLabel.numberOfLines = 0;
    jieshouLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:jieshouLabel];
    
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(UISCREEN_WIDTH/2-60, CGRectGetMaxY(jieshouLabel.frame)+20, 120, 44);
    [login setTitle:@"登录" forState:UIControlStateNormal];
    login.layer.borderColor = [UIColor lightGrayColor].CGColor;
    login.layer.borderWidth = 1.0;
    [login setTintColor:[UIColor whiteColor]];
    [self.view addSubview:login];
    
    [login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loginAction{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.scope = @"all";
   
    [WeiboSDK sendRequest:request];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)checkoutGuanzhu:(UITapGestureRecognizer *)sender{
    NSLog(@"我被点击了");
}

- (void)pushSettingButton:(UIBarButtonItem *)sender{
    SetViewController *setView = [SetViewController new];
    [self.navigationController pushViewController:setView animated:YES];
    
}
//- (void)viewWillDisappear:(BOOL)animated{
//
//}

- (void)addFriend{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
