//
//  UserDefault.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/10.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "UserDefault.h"
#import <NSObject+YYModel.h>

static UserDefault *user = nil;
@implementation UserDefault

+ (id)shareUser{
    if (!user) {
        user = [UserDefault new];
    }
    return user;
}

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"uid":@"id",@"userClass":@"class",@"userDescription":@"description"};
}

@end
@implementation UserStatus

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"stateID":@"id"};
}

@end