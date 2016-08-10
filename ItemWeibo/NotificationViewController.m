//
//  NotificationViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/10.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSArray *dataSource;
  
}

@property(nonatomic,strong) UISwitch *selectSw;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
   self.selectSw = [UISwitch new];
}

- (void)setUI{
    self.title = @"通知";
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    [self.view addSubview:myTb];
    myTb.delegate = self;
    myTb.dataSource = self;
    dataSource = @[@[@"接收推送通知"],@[@"@我的",@"评论",@"赞",@"消息",@"群通知",@"未关注人消息",@"新粉丝"],@[@"好友圈微博",@"特别关注微博",@"群微博",@"微博热点"],@[@"免打扰设置",@"获取新消息"]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPathP
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuse"];
             switch (indexPathP.section) {
            case 0:
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 1:
            {
                switch (indexPathP.row) {
                    case 0:case 1:case 2:case 5:case 6:
                    {
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                        break;
                    case 3:case 4:
                    {
                        cell.accessoryView = self.selectSw;
                        
                    }
                        
                        break;
                    default:
                        break;
                }
            }
                break;
            case 2:
            {
                if (indexPathP.row == 1) {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }
                break;
            case 3:{
                 cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
               
            default:
                break;
        }
    }
    cell.textLabel.text = dataSource[indexPathP.section][indexPathP.row];

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        NSString *string = @"要开启或关闭微博的推送通知,请在iPhone的'设置'-'通知'中找到'微博'进行设置";
        return string;
    }
    return nil;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        NSString *str = @"新消息通知";
        return str;
    }else if (section == 2){
        return @"新微博推送通知";
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
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
