//
//  NewfanViewController.h
//  ItemWeibo
//
//  Created by 3014 on 16/8/11.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "GeneralViewController.h"
typedef void (^block)(NSString *);
@interface NewfanViewController : GeneralViewController
@property(nonatomic,copy)block valueBlock;
@end
