//
//  OpinionSendWeiboViewController.h
//  ItemWeibo
//
//  Created by 陈泽峰 on 16/8/17.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,SendWeboFeedbackType){
    TextSendWeiboType,
    FriendSendWeiboType,
    OpinionFeedbackType,
    
};
@interface OpinionSendWeiboViewController : UINavigationController
@property(nonatomic,assign) SendWeboFeedbackType type;
@end
