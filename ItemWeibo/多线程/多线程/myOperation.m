//
//  myOperation.m
//  多线程
//
//  Created by 3014 on 16/8/17.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "myOperation.h"

@implementation myOperation


- (void)main{
    for (int i = 0; i < 100; i++) {
        [NSThread sleepForTimeInterval:0.2];
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:YES];
    }
}

- (void)updateUI{
    self.vc.progressViewa.progress += 0.01;
}
@end
