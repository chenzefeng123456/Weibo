//
//  OpinionFeedbackViewController.h
//  ItemWeibo
//
//  Created by 3014 on 16/8/11.
//  Copyright © 2016年 3014. All rights reserved.
//
#import "GeneralViewController.h"
typedef NS_ENUM(NSUInteger,SendWeboFeedbackTupe){
    UITextSendWeiboType,
    UIFriendSendWeiboType,
    UIOpinionFeedbackType,
    
};
@interface OpinionFeedbackViewController : GeneralViewController
@property(nonatomic,assign) SendWeboFeedbackTupe type;

@end
