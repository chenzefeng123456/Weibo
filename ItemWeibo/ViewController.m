
#import "ViewController.h"
#import <WeiboSDK.h>
#import "AppDelegate.h"
#import "GeneralViewController.h"
@interface ViewController ()<WBHttpRequestDelegate>
{
    GeneralViewController *genneral;
}
@property (weak, nonatomic) IBOutlet UILabel *access_token;
@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate *appD = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appD addObserver:self forKeyPath:@"access_token" options:NSKeyValueObservingOptionNew context:nil];
 
        
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"access_token"]) {
        self.access_token.text = change[NSKeyValueChangeNewKey];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
      self.access_token.text = [(AppDelegate *)[UIApplication sharedApplication].delegate access_token];
 
    
}

//- (IBAction)loginButtonAction:(UIButton *)sender {
//    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
//    request.redirectURI = kRedirectURL;
//    request.userInfo = @{
//                         @"SSO_From":@"ViewController",@"Other_Info_1":[NSNumber numberWithInteger:123]};
//    request.scope = @"all";
//    [WeiboSDK sendRequest:request];
//    
//    
//}
- (void)dealloc{
    [(AppDelegate *)[UIApplication sharedApplication].delegate removeObserver:self forKeyPath:@"access_token"];
}

- (IBAction)sendweibo:(id)sender {
    NSString *text = self.sendMessageTextField.text;
    //     text = [text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/update.json" httpMethod:@"POST" params:@{@"status":text,@"access_token":self.access_token.text} delegate:self withTag:@"1001"];
    
}


- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"错误信息");
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"收到微博的响应");
    NSLog(@"res = %@",response);
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result{
    
}
- (WBMessageObject *)messageObject{
    WBMessageObject *mess = [WBMessageObject message];
    mess.text = self.sendMessageTextField.text;
    return mess;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
