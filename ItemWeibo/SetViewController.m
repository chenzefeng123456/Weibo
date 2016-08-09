//
//  SetViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "SetViewController.h"
#import "GlobalViewController.h"
#import "AboutWeiboViewController.h"
@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTable;
    NSMutableArray *mu;
    NSArray *array;
}
@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI{
    mu = [NSMutableArray array];
    self.title = @"设置";
    myTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTable.delegate = self;
    myTable.dataSource = self;
    [self.view addSubview:myTable];
    array = @[@"通用设置"];
    NSArray *arr = @[@"关于微薄"];
   
    [mu addObject:array];
    [mu addObject:arr];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            GlobalViewController *global = [GlobalViewController new];
            [self.navigationController pushViewController:global animated:YES];

        }
            break;
        case 1:{
            AboutWeiboViewController *about = [AboutWeiboViewController new];
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = mu[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    NSArray *arr = mu[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
