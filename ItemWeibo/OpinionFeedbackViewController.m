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
{
    UITextView *textView;
}
@end

@implementation OpinionFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setWeiboType];
}

- (void)setUI{
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
    
    textView = [[UITextView alloc] initWithFrame:self.view.frame];
    
   
    textView.font = [UIFont systemFontOfSize:22];
    textView.backgroundColor = CGCOLOR_RGB(227, 227, 227);
    [self.view addSubview:textView];
    
    UIView *tooBarView = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT-74, UISCREEN_WIDTH, 74)];
    tooBarView.backgroundColor = CGCOLOR_RGB(227, 227, 227);
    [self.view addSubview:tooBarView];
    UIToolbar *tooBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,30, UISCREEN_WIDTH, 44)];
    tooBar.backgroundColor = [UIColor whiteColor];
    [tooBarView addSubview:tooBar];
    UIBarButtonItem *picture = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"picture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pictureAction:)];
    picture.width = 20;
    UIBarButtonItem *and = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"@"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(andAction:)];
    UIBarButtonItem *jin = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"topic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(topicAction:)];
    UIBarButtonItem *emoji = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"emoji"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(emojiAction:)];
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [tooBar setItems:@[picture,space,and,space,jin,space,emoji,space,add] animated:YES];
    
    UIButton *show = [UIButton buttonWithType:UIButtonTypeCustom];
    [show setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    show.layer.cornerRadius = 15;
    show.layer.masksToBounds = YES;
    [show setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [show setTitle:@"显示位置" forState:UIControlStateNormal];
    show.frame = CGRectMake(10, 0, 100, 25);
    show.backgroundColor = [UIColor whiteColor];
    [tooBarView addSubview:show];
    
    UIButton *open = [UIButton buttonWithType:UIButtonTypeCustom];
    [open setImage:[UIImage imageNamed:@"global"] forState:UIControlStateNormal];
    [open setTitle:@"公开" forState:UIControlStateNormal];
    [open setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    open.backgroundColor = [UIColor whiteColor];
    open.layer.cornerRadius = 15;
    open.layer.masksToBounds = YES;
    open.frame = CGRectMake(UISCREEN_WIDTH-80, 0, 70, 25);
    [tooBarView addSubview:open];


}
- (void)setWeiboType{
    
    switch (self.type) {
        case UIOpinionFeedbackType:
        {
             self.title = @"发表反馈意见";
             textView.text = @"@微博iPhone客户端#iPhone客户端意见反馈#版本6.8.1,iPhone5,4,OS9.3.4,网络WIFI";
        }
            break;
        case UITextSendWeiboType:
        {
            self.title = @"发送微博";
            
        }
            
        default:
            break;
    }
   
   
    
    
    
}

- (void)addAction:(UIBarButtonItem *)sender{
    
}
- (void)emojiAction:(UIBarButtonItem *)sender{
    
}
- (void)topicAction:(UIBarButtonItem *)sender{
    
}
- (void)andAction:(UIBarButtonItem *)sender{
    
}
- (void)pictureAction:(UIBarButtonItem *)sender{
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
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
