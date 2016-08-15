//
//  AppDelegate.h
//  ItemWeibo
//
//  Created by 3014 on 16/8/8.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property(nonatomic,strong) UINavigationController *navigation;
@property(nonatomic,strong)  UINavigationController *weNa;;
@property(nonatomic,strong) AddViewController *add;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong) NSString *access_token;
@property(nonatomic,strong) NSString *user_id;

@end

