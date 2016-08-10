//
//  MoreLanguageViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "MoreLanguageViewController.h"
#import <MBProgressHUD.h>
@interface MoreLanguageViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *myTb;
    NSArray *array;
    NSInteger current;
   
}
@property(nonatomic,strong) NSIndexPath *selectPath;
@end

@implementation MoreLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    self.selectPath = [NSIndexPath indexPathForRow:[user integerForKey:@"select"] inSection:0];
   
    
}
- (void)setUI{
    self.title = @"多语言环境";
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTb.delegate = self;
    myTb.dataSource = self;;
    [self.view addSubview:myTb];
    array = @[@"随机手机系统",@"简体中文",@"繁体中文",@"English"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectPath = indexPath;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:self.selectPath.row forKey:@"select"];
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if ([self.selectPath isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
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
