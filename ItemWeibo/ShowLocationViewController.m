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
@interface ShowLocationViewController ()<CLLocationManagerDelegate,WBHttpRequestDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *myTb;
    NSMutableArray *dataSource;
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    
}

@property(nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ShowLocationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    dataSource = [NSMutableArray array];
    [self showLocation];
    [self setUI];
   
   
}

- (void)setUI{
    self.title = @"我在这里";
    UIBarButtonItem *cacel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cacelAction)];
    
    self.navigationItem.leftBarButtonItem = cacel;
    myTb = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:myTb];
    myTb.delegate = self;
    myTb.dataSource = self;
//    [MBProgressHUD showHUDAddedTo:myTb animated:YES];
    
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 44)];
    search.placeholder = @"搜附近位置";
    myTb.tableHeaderView = search;
 
    
    
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.distanceFilter = kCLHeadingFilterNone;
        
    }
    return _locationManager;
}

- (void)showLocation{
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    latitude = location.coordinate.latitude;
    longitude = location.coordinate.longitude;
    
    NSLog(@"latitude=%lf,longitude=%lf",latitude,longitude);
    [self initData];
}

- (void)initData{
    NSLog(@"latitude1=%lf,longitude1=%lf",latitude,longitude);
    [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/place/nearby/pois.json" httpMethod:@"GET" params:@{@"access_token":[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"],@"lat":[NSString stringWithFormat:@"%lf",latitude],@"long":[NSString stringWithFormat:@"%lf",longitude]} delegate:self withTag:@"2000"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
        Location *locationDescribe = dataSource[indexPath.row];
        cell.textLabel.text = locationDescribe.locationName;
        
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
    NSArray *dd = dic[@"pois"];
    for (NSDictionary *dic in dd) {
        Location *locationDescribe = [Location new];
    
        locationDescribe.locationName = dic[@"title"];
        [dataSource addObject:locationDescribe];

    }
   
  
   
   
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
