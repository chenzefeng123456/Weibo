//
//  AddViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0,UISCREEN_HEIGHT-44, UISCREEN_WIDTH, 44)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    UIImageView *clearImage = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 -11, 11, 22, 22)];
    clearImage.image = [UIImage imageNamed:@"back"];
    [buttomView addSubview:clearImage];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"我被点了");
   
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
