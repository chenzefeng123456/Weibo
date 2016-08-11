//
//  NewfanViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/11.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "NewfanViewController.h"

@interface NewfanViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSArray *array;
    NSIndexPath *selectPath;
}
@end

@implementation NewfanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    selectPath = [NSIndexPath indexPathForRow:[user integerForKey:@"row"] inSection:0];
}

- (void)setUI{
    self.title = @"新粉丝设置";
    array = @[@"所有人",@"我关注的人",@"关闭"];
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTb.delegate = self;
    myTb.dataSource = self;
    [self.view addSubview:myTb];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if ([selectPath isEqual:indexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (selectPath) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:selectPath];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    UITableViewCell *cell =[ tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    selectPath = indexPath;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setInteger:selectPath.row forKey:@"row"];
    self.valueBlock(cell.textLabel.text);
    
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"我将收到这些人的关注通知";
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
