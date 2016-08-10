//
//  AboutWBViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/10.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "AboutWBViewController.h"

@interface AboutWBViewController ()

@end

@implementation AboutWBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    self.title = @"关于微博";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2-50, 84, 100, 66)];
    imageView.image = [UIImage imageNamed:@"weiboIcon"];
    [self.view addSubview:imageView];
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
