//
//  PrivacyViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/11.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()
{
    UITableView *myTb;
}
@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    
}

- (void)setUI{
    self.title = @"隐私";
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:myTb];
    
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
