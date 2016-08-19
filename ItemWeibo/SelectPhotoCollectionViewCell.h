//
//  SelectPhotoCollectionViewCell.h
//  ItemWeibo
//
//  Created by 3014 on 16/8/19.
//  Copyright © 2016年 3014. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^block)(BOOL isSelect);
@interface SelectPhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imagegao;

@property(nonatomic,copy) block isSelect;

- (IBAction)selectPhoto:(UIButton *)sender;

@end
