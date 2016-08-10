//
//  GlobalViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "GlobalViewController.h"
#import "MoreLanguageViewController.h"
#import "MoviePlayViewController.h"
@interface GlobalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSArray *array;
    UILabel *accessLabel;
    
}
@property(nonatomic,strong) UISwitch *loudSwitch;
@end

@implementation GlobalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    self.loudSwitch = [UISwitch new];
    [self.loudSwitch addTarget:self action:@selector(onSwitch) forControlEvents:UIControlEventValueChanged];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    self.loudSwitch.on = [user boolForKey:@"loudOn"];
   
}

- (void)setUI{
    self.title = @"通用设置";
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTb.delegate = self;
    myTb.dataSource = self;
    [self.view addSubview:myTb];
    array = @[@"声音",@"多语言环境",@"视频自动播放"];
}

- (void)onSwitch{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:self.loudSwitch.on forKey:@"loudOn"];
    [user synchronize];
    
   

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    switch (indexPath.section) {
        case 0:
        {
             cell.accessoryView = self.loudSwitch;
            
        }
            break;
        case 1:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"跟随系统";
            
        }
            break;
        case 2:
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"仅限WiFi";
            
        }
            break;
        default:
            break;
    }
   
    cell.textLabel.text = array[indexPath.section];
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            MoreLanguageViewController *more = [MoreLanguageViewController new];
            [self.navigationController pushViewController:more animated:YES];
        }
            break;
        case 2:
        {
            MoviePlayViewController *movie = [MoviePlayViewController new];
            [self.navigationController pushViewController:movie animated:YES];
        }
            break;
            
        default:
            break;
    }
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
