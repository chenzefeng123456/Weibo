//
//  LoginViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/9.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "LoginViewController.h"
#import "SetViewController.h"
#import <WBHttpRequest.h>
#import "UserDefault.h"
#import "myTableViewCell.h"
#import "LoginSetViewController.h"
@interface LoginViewController ()<WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSArray *dataSource;
    NSArray *imageArray;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self initData];
    [self setUI];

}
- (void)initData{
    imageArray = @[
                   @[[UIImage imageNamed:@"new_friend"],[UIImage imageNamed:@"weibo_level"]],
                   @[[UIImage imageNamed:@"my_photo"],[UIImage imageNamed:@"my_comment"],[UIImage imageNamed:@"my_zan"]],
                   @[[UIImage imageNamed:@"weibo_pay"],[UIImage imageNamed:@"weibo_exercise"]],
                   @[[UIImage imageNamed:@"fans_topline"],[UIImage imageNamed:@"fans_serve"]],
                   @[[UIImage imageNamed:@"draft"]],
                   @[[UIImage imageNamed:@"more"]]];
    dataSource = @[@[@"新的好友",@"新手任务"],@[@"我的相册",@"我的点评",@"我的赞"],@[@"微博支付",@"微博运动"],@[@"粉丝头条",@"粉丝服务"],@[@"草稿箱"],@[@"更多"]];
    NSString *access = [[NSUserDefaults standardUserDefaults ] objectForKey:@"access_token"];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSLog(@"access=%@,id=%@",access,user_id);
    
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:@{@"uid":user_id,@"access_token":access} delegate:self withTag:@"1007"];
    
}

- (void)setNavigationBar{
     self.title = @"我";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"好友添加" style:UIBarButtonItemStylePlain target:self action:@selector(addFriendAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setAction:)];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
}

- (void)setUI{
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    myTb.delegate = self;
    myTb.dataSource = self;
    [self.view addSubview:myTb];
    [myTb registerNib:[UINib nibWithNibName:@"myTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([myTableViewCell class])];
    
}

#pragma mark 数据请求
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"error %@",error);
        
    }else{
        
    }
}

#pragma mark UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section >= 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        }
        cell.textLabel.text = dataSource[indexPath.section-1][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = imageArray[indexPath.section-1][indexPath.row];
        
        return cell;

    }else{
        myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([myTableViewCell class])];
        UserDefault *user = [UserDefault user];
       
                                                                                               
        return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
//        tableView.rowHeight = 149;
        return 149;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    NSArray *array = dataSource[section-1];
    return array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return dataSource.count+1;
}

#pragma mark 跳转设置
- (void)setAction:(UIBarButtonItem *)sender{
    LoginSetViewController *set = [LoginSetViewController new];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)addFriendAction:(UIBarButtonItem *)sender{
    
}

#pragma mark WbDelegate
- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
}
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
    
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    NSLog(@"result = %@",result);
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
