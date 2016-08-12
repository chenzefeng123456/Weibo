//
//  OpinionFeedbackViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/11.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "OpinionFeedbackViewController.h"
#import "UserDefault.h"
@interface OpinionFeedbackViewController ()

@end

@implementation OpinionFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
- (void)setUI{
    self.title = @"发表反馈意见";
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(0, 0, 44, 25);
    sendButton.layer.cornerRadius = 5;
    [sendButton setBackgroundColor:[UIColor orangeColor]];
    [sendButton setTintColor:[UIColor whiteColor]];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItem = sendItem;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.frame];
    textView.text = @"@微博iPhone客户端#iPhone客户端意见反馈#版本6.8.1,iPhone5,4,OS9.3.4,网络WIFI";
    textView.font = [UIFont systemFontOfSize:22];
    textView.backgroundColor = CGCOLOR_RGB(227, 227, 227);
    [self.view addSubview:textView];
    
   
}

- (void)sendAction:(UIBarButtonItem *)sender{
    NSLog(@"发送");
}
- (void)cancelAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
