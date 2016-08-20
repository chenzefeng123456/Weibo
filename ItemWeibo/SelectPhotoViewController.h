//
//  SelectPhotoViewController.h
//  ItemWeibo
//
//  Created by 3014 on 16/8/19.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "GeneralViewController.h"
typedef void(^imagesHandle) (NSArray *);
@interface SelectPhotoViewController : GeneralViewController
@property(nonatomic,strong) NSMutableArray *images;
@property(nonatomic,copy)imagesHandle imagesHandle;
@end
