//
//  LoginSetViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/10.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "LoginSetViewController.h"
#import "NotificationViewController.h"
#import "AboutWBViewController.h"
#import "OpinionFeedbackViewController.h"
#import "AppDelegate.h"
#import <WeiboSDK.h>
#import "WeViewController.h"

@interface LoginSetViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>
{
    UITableView *myTb;
    NSArray *dataSource;
    AppDelegate *appDelegate;
}
@end

@implementation LoginSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    appDelegate = [UIApplication sharedApplication].delegate;
    
}

- (void)setUI{
    self.title = @"设置";
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTb.delegate = self;
    myTb.dataSource = self;
    [self.view addSubview:myTb];
    dataSource = @[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私",@"通用设置"],@[@"清理缓存",@"意见反馈",@"关于微博"],@[@"退出当前账号"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = dataSource[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSArray *arr = dataSource[indexPath.section];
    if (indexPath.section == 3) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
       
    }
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            NSLog(@"账号管理和账号安全");
        }
            
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    NotificationViewController *noti = [NotificationViewController new];
                    [self.navigationController pushViewController:noti animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
            break;
        }
        case 2:{
            switch (indexPath.row) {
                case 0:
                {
                   
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                    UIAlertAction *command = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                         NSLog(@"清理缓存");
                    }];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:command];
                    [alert addAction:cancel];
               
                    [self presentViewController:alert animated:YES completion:nil];
                
                }
                    break;
                case 1:{
                    OpinionFeedbackViewController *opinion = [OpinionFeedbackViewController new];
                  
                    [self.navigationController pushViewController:opinion animated:YES];
                }
                    break;
                case 2:
                {
                    AboutWBViewController *wb = [AboutWBViewController new];
                    [self.navigationController pushViewController:wb animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 3:{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *command = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                NSString *accessgg = [user objectForKey:@"access_token"];
               
                [WBHttpRequest requestWithAccessToken:accessgg url:@"https://api.weibo.com/oauth2/revokeoauth2" httpMethod:@"GET" params:nil delegate:self withTag:@"1111"];
}];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:command];
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];

          
        }
            break;
            
            
        default:
            break;
    }
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    if ([result containsString:@"true"]) {
        NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
        [userD setObject:nil forKey:@"access_token"];
        [userD setObject:nil forKey:@"user_id"];
        AppDelegate *appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
        appD.weNa = [[UINavigationController alloc] initWithRootViewController:[WeViewController new]];
        self.tabBarController.viewControllers = @[appD.navigation,appD.add,appD.weNa];
        NSLog(@"ddd");

//        exit(0);
    }
    
    NSLog(@"result = %@",result);
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
