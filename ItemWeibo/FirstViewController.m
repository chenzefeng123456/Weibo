//
//  FirstViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "FirstViewController.h"
#import <WeiboSDK.h>
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    self.view.backgroundColor =[UIColor whiteColor];
}
- (void)setNavigationBar{
    
    UIBarButtonItem *loginBar = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"person"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(loginButtonAction:)];
    self.navigationItem.leftBarButtonItem = loginBar;
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"radar"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBar)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
}
- (void)rightBar{
    NSLog(@"我是雷达");
}
- (IBAction)loginButtonAction:(UIButton *)sender {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    request.userInfo = @{
                         @"SSO_From":@"ViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
    request.scope = @"all";
    [WeiboSDK sendRequest:request];
    
    
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
