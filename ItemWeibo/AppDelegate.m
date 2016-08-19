//
//  AppDelegate.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/8.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "AppDelegate.h"
#import <WeiboSDK.h>
#import "ViewController.h"
#import "TabBarViewController.h"
#import "GeneralViewController.h"
#import "FirstViewController.h"
#import "WeViewController.h"

#import "LoginViewController.h"
#import <MBProgressHUD.h>
@interface AppDelegate ()<WeiboSDKDelegate>
{
    TabBarViewController *tabBar;
    UINavigationController *addNa;
}


@end

@implementation AppDelegate

@synthesize navigation = navigation;
@synthesize add = add;
@synthesize weNa = weNa;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAPPKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    tabBar = [TabBarViewController new];
    FirstViewController *first = [FirstViewController new];
    navigation = [[UINavigationController alloc]initWithRootViewController:first];
    add = [AddViewController new];
    addNa = [[UINavigationController alloc] initWithRootViewController:add];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]) {
        LoginViewController *login = [LoginViewController new];
        weNa = [[UINavigationController alloc] initWithRootViewController:login];
        tabBar.viewControllers = @[navigation,addNa,weNa];
        
    }else{
        WeViewController *we = [WeViewController new];
        weNa = [[UINavigationController alloc] initWithRootViewController:we];
        
        tabBar.viewControllers = @[navigation,addNa,weNa];
    }
   
  
    NSArray *names = @[@"首页",@"",@"我"];
    NSArray *images = @[[UIImage imageNamed:@"home"],[[UIImage imageNamed:@"arrow-up"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal],[UIImage imageNamed:@"person"]];
    for (int i = 0; i < tabBar.viewControllers.count; i++) {
        tabBar.viewControllers[i].tabBarItem.title = names[i];
        tabBar.viewControllers[i].tabBarItem.image = images[i];
        
        if (i == 1) {
            tabBar.viewControllers[1].tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            tabBar.viewControllers[1].tabBarItem.title = nil;
        }
        tabBar.selectedIndex = 0;
    }
    

    self.window.rootViewController = tabBar;
    return YES;
}

//下面两个方法都是被别的应用打开的时候被调用
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark WeiboSDKdelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    NSLog(@"收到请求");
    
}
//当收到微博响应调用此方法
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
   
    if ([response isMemberOfClass:[WBAuthorizeResponse class]]) {
        WBAuthorizeResponse *authorize = (WBAuthorizeResponse *)response;
        self.access_token = authorize.accessToken;
        self.user_id = authorize.userID;
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:self.access_token forKey:@"access_token"];
        [user setObject:self.user_id forKey:@"user_id"];
        [user synchronize];
        
        NSLog(@"access = %@",authorize.accessToken);
        NSLog(@"user_ID = %@",authorize.userID);
        [MBProgressHUD hideHUDForView:tabBar.viewControllers[2].view animated:YES];
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
           
            LoginViewController *login = [LoginViewController new];
            weNa = [[UINavigationController alloc] initWithRootViewController:login];
            tabBar.viewControllers = @[navigation,addNa,weNa];
            tabBar.viewControllers[2].tabBarItem.title = @"我";
            tabBar.viewControllers[2].tabBarItem.image = [UIImage imageNamed:@"person"];
            tabBar.selectedIndex = 0;
           
           
        }
        
        
    }
    
    
    
  
  
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
