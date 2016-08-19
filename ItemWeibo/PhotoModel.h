//
//  PhotoModel.h
//  ItemWeibo
//
//  Created by 3014 on 16/8/19.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface PhotoModel : NSObject
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign) BOOL isSelect;

@end
