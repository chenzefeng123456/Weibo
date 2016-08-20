
#import "AddViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "OpinionFeedbackViewController.h"
@interface AddViewController ()<CLLocationManagerDelegate>
{
    int index;
    NSArray *weekArray;
    UILabel *weatherLabel;
    NSString *locality;
    NSMutableString *mutableString;
  
}

@property(nonatomic,strong) CLLocationManager *locationManager;


@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    weekArray = @[[NSNull null],@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];

    [self setUI];
    index = 0;
    [self checkLocationState];
    self.navigationController.navigationBar.hidden = YES;

    

   
}

- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy= kCLLocationAccuracyBestForNavigation;
    }
    return _locationManager;
}


- (void)checkLocationState{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error = %@",error);
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    CLLocationDegrees latitude = location.coordinate.latitude;
    CLLocationDegrees longitude = location.coordinate.longitude;
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       if (error || placemarks.count == 0) {
           dispatch_async(dispatch_get_main_queue(), ^{
             
               NSString *str = [NSString stringWithFormat:@"%@",error];
               NSLog(@"error1 = %@",str);
           });
       }else{
           dispatch_async(dispatch_get_main_queue(), ^{
               CLPlacemark *placemark = [placemarks lastObject];
               locality = placemark.locality;
               mutableString = [NSMutableString stringWithString:locality];
               CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
               CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
               NSRange rangeStr = [mutableString rangeOfString:@" shi"];
               [mutableString deleteCharactersInRange:rangeStr];
               NSRange range = [mutableString rangeOfString:@" "];
               [mutableString deleteCharactersInRange:range];
               [self weather];

           });
           
       }
   }];
    
}
- (void)weather{
   weatherLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 150, 30)];
    [self.view addSubview:weatherLabel];
    //NSLog(@"muta = %@",mutableString);
    NSString *str = [NSString stringWithFormat:@"https://api.thinkpage.cn/v3/weather/now.json?key=4wnctvjabfnwbxhe&location=%@&language=zh-Hans&unit=c",mutableString];
    
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *array = dic[@"results"];
            NSDictionary *diction = array[0];
            weatherLabel.text = [NSString stringWithFormat:@"%@:%@ %@°C",diction[@"location"][@"name"],diction[@"now"][@"text"],diction[@"now"][@"temperature"]];
        });
        
    }];
    [task resume];

}
- (void)setUI{
    
    UIButton *oppoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oppoButton.frame = CGRectMake(UISCREEN_WIDTH-150, 44, UISCREEN_WIDTH-150, 100);
    [oppoButton setImage:[UIImage imageNamed:@"issue_AD"] forState:UIControlStateNormal];
    [oppoButton setImage:[UIImage imageNamed:@"issue_AD"] forState:UIControlStateHighlighted];
    UILabel *dateNumberLabel = [UILabel new];
    UILabel *weekLabel = [UILabel new];
    weekLabel.font = [UIFont systemFontOfSize:15];
    weekLabel.numberOfLines = 0;
    NSDate *date = [NSDate date];
    NSCalendar *current = [NSCalendar currentCalendar];
    NSDateComponents *components = [current components:NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitWeekday fromDate:date];
    dateNumberLabel.text = [NSString stringWithFormat:@"%lu",components.day];
    weekLabel.text = [NSString stringWithFormat:@"%@%lu/%lu",weekArray[components.weekday],components.month,components.year];
    dateNumberLabel.font = [UIFont systemFontOfSize:30];
    dateNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    weekLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:oppoButton];
    [self.view addSubview:dateNumberLabel];
    [self.view addSubview:weekLabel];
    NSArray *labelH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[dateNumberLabel(==40)]-5-[weekLabel(==80)]" options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom metrics:NULL views:NSDictionaryOfVariableBindings(dateNumberLabel,weekLabel)];
    NSArray *labelV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[dateNumberLabel(==80)]" options:0 metrics:NULL views:NSDictionaryOfVariableBindings(dateNumberLabel)];
    [self.view addConstraints:labelH];
    [self.view addConstraints:labelV];
    UIView *buttonView = [UIView new];
    buttonView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:buttonView];
    NSArray *viewH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[buttonView]-0-|" options:0 metrics:NULL views:NSDictionaryOfVariableBindings(buttonView)];
    NSArray *V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-200-[buttonView]-44-|" options:0 metrics:NULL views:NSDictionaryOfVariableBindings(buttonView)];
    [self.view addConstraints:V];
    [self.view addConstraints:viewH];
    
    NSArray *imageArray = @[[UIImage imageNamed:@"word"],[UIImage imageNamed:@"image"],[UIImage imageNamed:@"topline"],[UIImage imageNamed:@"checkin"],[UIImage imageNamed:@"video"],[UIImage imageNamed:@"issue_more"]];
    NSArray *labelArray = @[@"文字",@"照片/视频",@"头条文章",@"签到",@"直播",@"更多"];

    float buttonWidth = UISCREEN_WIDTH/5;
    float gapWidth = (UISCREEN_WIDTH - 3 * buttonWidth)/4;
    
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            index++;
            UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
            itemButton.frame = CGRectMake((j + 1) * gapWidth + j * buttonWidth,i *(buttonWidth + buttonWidth),buttonWidth,buttonWidth);
            [itemButton setImage:imageArray[index-1] forState:UIControlStateNormal];
            [buttonView addSubview:itemButton];
            itemButton.tag = 1000+index;
            [itemButton addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if (index ==2||index ==3) {
                if (index == 2) {
                    UILabel *itemLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(2*gapWidth + j *buttonWidth+9, i *(buttonWidth + buttonWidth)+buttonWidth+20, buttonWidth+40, 20)];
                    itemLabel2.text = labelArray[index -1];
                    [buttonView addSubview:itemLabel2];

                }else{
                    UILabel *itemLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(gapWidth*3 + j *buttonWidth+11,i *(buttonWidth + buttonWidth)+buttonWidth+20, buttonWidth+40, 20)];
                    itemLabel2.text = labelArray[index -1];
                    [buttonView addSubview:itemLabel2];

                }
                continue;
                }

            
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake((j+1) * gapWidth + j *buttonWidth+13,i *(buttonWidth + buttonWidth)+buttonWidth+20,buttonWidth,20)];
            itemLabel.text = labelArray[index-1];
            [buttonView addSubview:itemLabel];

        }
           }
}

- (void)itemAction:(UIButton *)sender{
    switch (sender.tag) {
        case 1001:
        {
           OpinionFeedbackViewController  *sendWeibodd = [OpinionFeedbackViewController new];
            sendWeibodd.type = UITextSendWeiboType;
             [self.navigationController pushViewController:sendWeibodd animated:YES];//self.navigationController指装载当前视图的导航视图
            
         
        }
            break;
            
        default:
            break;
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0,UISCREEN_HEIGHT-44, UISCREEN_WIDTH, 44)];
    buttomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomView];
    UIImageView *clearImage = [[UIImageView alloc] initWithFrame:CGRectMake(UISCREEN_WIDTH/2 -11, 11, 22, 22)];
    clearImage.image = [UIImage imageNamed:@"back"];
    [buttomView addSubview:clearImage];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.tabBarController.selectedIndex = 0;
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
