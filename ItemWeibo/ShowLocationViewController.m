//
//  ShowLocationViewController.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/18.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "ShowLocationViewController.h"
#import <MBProgressHUD.h>
#import <CoreLocation/CoreLocation.h>
#import <WeiboSDK.h>
#import "Location.h"
#import <MJRefresh.h>
@interface ShowLocationViewController ()<CLLocationManagerDelegate,WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSMutableArray *dataSource;
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    MJRefreshNormalHeader *refresha ;
    
}
/*
 这些方法调用的顺序:
 先调用72行代码,再进行61行,又因为该代理的方法,由系统决定调用的时间,即获得定位后才调用,所以先调用42行代码,里面的代理即时调用133行,又因为dataSource没值,所以无法调用95行,所以最后可能才调用155这个代码方法,这时dataSource才有值,所以应该调用reloadData这个方法,对UItableview的代理方法再进行调用
 
 */

@property(nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ShowLocationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    [self showLocation];
    [self setUI];
    refresha = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    [refresha setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [refresha setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [refresha  setTitle:@"下载中..." forState:MJRefreshStateRefreshing];
    myTb.mj_header = refresha;
   
}

- (void)setUI{
    self.title = @"我在这里";
    UIBarButtonItem *cacel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cacelAction)];
    
    self.navigationItem.leftBarButtonItem = cacel;
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:myTb];
    myTb.delegate = self;
    myTb.dataSource = self;

   [MBProgressHUD showHUDAddedTo:myTb animated:YES];
    
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 44)];
    search.placeholder = @"搜附近位置";
    myTb.tableHeaderView = search;
  
    
    
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.distanceFilter = 1000;
        
    }
    return _locationManager;
}

- (void)showLocation{
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];//调用该方法开始定位
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    
    NSLog(@"latitude=%lf,longitude=%lf",latitude,longitude);
    [self initData];
    [self.locationManager stopUpdatingLocation];
}

- (void)initData{
    NSLog(@"latitude1=%lf,longitude1=%lf",latitude,longitude);
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/place/nearby/pois.json" httpMethod:@"GET" params:@{@"access_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"],@"lat":[NSString stringWithFormat:@"%lf",latitude],@"long":[NSString stringWithFormat:@"%lf",longitude]} delegate:self withTag:@"2000"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"reuse"];
        Location *locationDescribe = dataSource[indexPath.row];
        cell.textLabel.text = locationDescribe.locationName;
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%@人去过·%@",locationDescribe.numPerson,locationDescribe.detaiLocation];

        
    }
   
    return cell;
   
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"错误");
}
- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"response = %@",response);
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:
                         nil];
    NSLog(@"dic = %@",dic);
    NSArray *dd = dic[@"pois"];
    for (NSDictionary *dic in dd) {
        Location *locationDescribe = [Location new];
        locationDescribe.locationName = dic[@"title"];
        locationDescribe.numPerson = dic[@"district_info"][@"checkin_user_num"];
        locationDescribe.detaiLocation = dic[@"poi_street_address"];
        [dataSource addObject:locationDescribe];

    }
    [myTb.mj_header endRefreshing];
    [MBProgressHUD hideHUDForView:myTb animated:YES];

    [myTb reloadData];
   
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
    
}

- (void)cacelAction{
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
