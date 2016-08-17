//
//  myOperation.h
//  多线程
//
//  Created by 3014 on 16/8/17.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
@interface myOperation : NSOperation
@property(nonatomic,strong) ViewController *vc;
@end
