//
//  UserDefault.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/10.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "UserDefault.h"

static UserDefault *user = nil;
@implementation UserDefault

+ (id)user{
    if (!user) {
        user = [UserDefault new];
    }
    return user;
}
@end
