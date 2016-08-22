//
//  OpinionFeedbackViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/11.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "OpinionFeedbackViewController.h"
#import "UserDefault.h"
#import "ShowLocationViewController.h"
#import "SelectPhotoViewController.h"
#import <WeiboSDK.h>
#import "EmojiModel.h"
#import <UIImageView+WebCache.h>
#import "EmojiCollectionViewCell.h"
#import "AndViewController.h"
@interface OpinionFeedbackViewController ()<WBHttpRequestDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UITextView *textView;
    UIView *tooBarView;
    CGRect rect ;
    NSMutableArray *dataSource;
    int index;
    UIView *emojiView ;
    UICollectionView *emojiCollection ;
    BOOL isShow;
}
@end

@implementation OpinionFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    [self setUI];
    [self emojiData];
    [self setWeiboType];
  
    
    self.navigationController.navigationBar.hidden = NO;
 
    index = 0;
  
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
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0,0, UISCREEN_WIDTH,  UISCREEN_HEIGHT - (rect.size.height + 84))];
    NSLog(@"hwight = %f",rect.size.height + 84);
    
    
    textView.font = [UIFont systemFontOfSize:22];
    textView.backgroundColor = CGCOLOR_RGB(227, 227, 227);
    [self.view addSubview:textView];
    tooBarView = [[UIView alloc] initWithFrame:CGRectMake(0, UISCREEN_HEIGHT-84, UISCREEN_WIDTH, 84)];
    tooBarView.backgroundColor = CGCOLOR_RGB(227, 227, 227);
    [self.view addSubview:tooBarView];
    UIToolbar *tooBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,40, UISCREEN_WIDTH, 44)];
    tooBar.backgroundColor = [UIColor whiteColor];
    [tooBarView addSubview:tooBar];
    UIBarButtonItem *picture = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"picture"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pictureAction:)];
    UIBarButtonItem *and = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"@"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(andAction:)];
    UIBarButtonItem *jin = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"topic"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(topicAction:)];
    UIBarButtonItem *emoji = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"emoji"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(emojiAction:)];
    emoji.tag = 100;
  
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [tooBar setItems:@[space, picture,space,and,space,jin,space,emoji,space,add,space] animated:YES];
    
    UIButton *show = [UIButton buttonWithType:UIButtonTypeCustom];
    [show setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    show.layer.cornerRadius = 15;
    show.layer.masksToBounds = YES;
    [show setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [show setTitle:@"显示位置" forState:UIControlStateNormal];
    show.frame = CGRectMake(10, 0, 100, 25);
    show.backgroundColor = [UIColor whiteColor];
    [show addTarget:self action:@selector(showLocation:) forControlEvents:UIControlEventTouchUpInside];
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
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenKeyBoard:) name:UIKeyboardWillHideNotification object:nil];

   
}

- (void)viewDidAppear:(BOOL)animated{
    [textView becomeFirstResponder];

}
- (void)showKeyBoard:(NSNotification *)noti{
    
     isShow = YES;
    NSDictionary *dic = noti.userInfo;
     rect = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@"hwight = %f",rect.size.height + 84);
    [UIView beginAnimations:@"animagtio" context:nil];
    NSLog(@"rect = %@",dic);
    tooBarView.frame = CGRectMake(0, rect.origin.y-84, UISCREEN_WIDTH, 84);
    [UIView commitAnimations];
    
    
    BOOL headConto = NO;
    for (UIView *view in self.view.subviews) {
        if (view.tag == 1000) {
            headConto = YES;
            break;
        }
        
    }
    if (!headConto) {
        [self showEmoji];
    }
}


- (void)hiddenKeyBoard:(NSNotification *)noti{
    isShow = NO;
    [UIView beginAnimations:@"animagtio" context:nil];
    [UIView commitAnimations];

  }
- (void)showEmoji{
    emojiView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.origin.y , UISCREEN_WIDTH, rect.size.height-64)];
    emojiView.tag = 1000;
    emojiView.hidden = YES;
    [self.view addSubview:emojiView];
    UICollectionViewFlowLayout *lay = [UICollectionViewFlowLayout new];
    lay.minimumLineSpacing = 5;
    lay.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    lay.minimumInteritemSpacing = 5;
    lay.itemSize = CGSizeMake(55, 55);
   emojiCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, rect.size.height-64) collectionViewLayout:lay];
    emojiCollection.backgroundColor =  CGCOLOR_RGB(227, 227, 227);
    [emojiView addSubview:emojiCollection];
    emojiCollection.pagingEnabled = YES;
    emojiCollection.delegate = self;
    emojiCollection.dataSource = self;
    [emojiCollection registerNib:[UINib nibWithNibName:@"EmojiCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([EmojiCollectionViewCell class])];
}

#pragma mark Collection代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EmojiCollectionViewCell *cell = (EmojiCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([EmojiCollectionViewCell class]) forIndexPath:indexPath];
    EmojiModel *emoji = dataSource[indexPath.row];
    [cell.emojiImageView sd_setImageWithURL:[NSURL URLWithString:emoji.url]];
    

   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
   
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
- (void)emojiData{
    [WBHttpRequest requestWithAccessToken:[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"] url:@"https://api.weibo.com/2/emotions.json" httpMethod:@"GET" params:nil delegate:self withTag:@"2003"];
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSArray *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (NSDictionary *dictrionary in dic) {
        EmojiModel *e = [EmojiModel new];
        e.url = dictrionary[@"icon"];
      
             [dataSource addObject:e];
             [emojiCollection reloadData];
        
       
    }
    
    
    
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"res = %@",response);
}

- (void)showLocation:(UIButton *)sender{
    ShowLocationViewController *show = [ShowLocationViewController new];
    [self.navigationController pushViewController:show animated:YES];
}
- (void)addAction:(UIBarButtonItem *)sender{
    
}
- (void)emojiAction:(UIBarButtonItem *)sender{
   
    if (sender.tag == 100) {
        sender.tag = 101;
        emojiView.hidden = NO;
        emojiCollection.hidden = NO;
        [emojiCollection becomeFirstResponder];
        [textView resignFirstResponder];

       
    }else{
        sender.tag = 100;
        emojiView.hidden = YES;
        emojiCollection.hidden = YES;
        [textView becomeFirstResponder];


    }
    
}
- (void)topicAction:(UIBarButtonItem *)sender{
    
}
- (void)andAction:(UIBarButtonItem *)sender{
    AndViewController *and = [AndViewController new];
    [self.navigationController pushViewController:and animated:YES];
}
- (void)pictureAction:(UIBarButtonItem *)sender{
    SelectPhotoViewController *select = [SelectPhotoViewController new];
    select.imagesHandle = ^(NSArray *images){
        NSLog(@"%@",images);
    };
    [self.navigationController pushViewController:select animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
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
