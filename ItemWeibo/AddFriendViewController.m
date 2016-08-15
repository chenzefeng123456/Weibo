
#import "AddFriendViewController.h"
#import <MJRefresh.h>
#import "FirstViewController.h"
#import "ScanViewController.h"
@interface AddFriendViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSArray *dataSource;
    MJRefreshAutoNormalFooter *autoFooter;
}
@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self refreshHeader];
    
}

- (void)refreshHeader{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(upData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateWillRefresh];
    [header setTitle:@"释放更新" forState:MJRefreshStatePulling];
    myTb.mj_header = header;
    [myTb.mj_header beginRefreshing];

}
- (void)setUI{
    myTb = [[UITableView alloc] initWithFrame:self.view.frame];
    myTb.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myTb];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"· · ·" style:UIBarButtonItemStylePlain target:self action:@selector(rightMore:)];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (void)upData{
    myTb.delegate = self;
    myTb.dataSource = self;
    self.title = @"添加好友";
    myTb.rowHeight = 84;
    dataSource = @[@"扫一扫",@"通讯录好友"];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 44)];
    searchBar.placeholder = @"搜索昵称";
    myTb.tableHeaderView = searchBar;
    [myTb.mj_header endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = dataSource[indexPath.row];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"sweep"];
        
        cell.detailTextLabel.text = @"扫描二维码名片";
    }else{
        cell.imageView.image = [UIImage imageNamed:@"addressbook"];
        cell.detailTextLabel.text = @"添加或邀请通讯录现中的好友";
        
    }
       return cell;
}

- (void)rightMore:(UIBarButtonItem *)sender{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *upDataAction = [UIAlertAction actionWithTitle:@"刷新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self refreshHeader];
    }];
    
    UIAlertAction *backHomePage = [UIAlertAction actionWithTitle:@"返回首页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"首页");
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [alertController addAction:upDataAction];
    [alertController addAction:backHomePage];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ScanViewController *scan = [ScanViewController new];
        [self.navigationController pushViewController:scan animated:YES];
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
