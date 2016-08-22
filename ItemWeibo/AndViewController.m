
#import "AndViewController.h"
#import <WeiboSDK.h>
#import "andModel.h"
@interface AndViewController ()<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>
{
    UITableView *myTb;
    NSMutableArray *dataSource;
}
@end

@implementation AndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    [self setUI];
    [self initData];
    
}

- (void)setUI{
    self.title = @"联系人";
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    myTb.delegate = self;
    myTb.dataSource = self;
    [self.view addSubview:myTb];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
//        andModel *and = dataSource[indexPath.row];
//        cell.textLabel.text = and.idsName;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *array = dataSource[section];
//    return array.count;
    return dataSource.count;
}
- (void)initData{
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/friendships/friends.json" httpMethod:@"GET" params:@{@"access_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"],@"uid":[[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"]} delegate:self withTag:@"1009"];
    
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"dic = %@",dic);
    NSArray *idsArray = dic[@"ids"];
    for (NSString *ids in idsArray) {
        andModel *and = [andModel new];
        and.idsName = ids;
        [dataSource addObject:and];
        NSLog(@"and = %@",and.idsName);
    }
    [myTb reloadData];
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"res = %@",response);
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
