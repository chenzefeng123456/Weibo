//
//  SelectPhotoCollectionViewCell.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/19.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "SelectPhotoCollectionViewCell.h"

@implementation SelectPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)selectPhoto:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.isSelect(sender.selected);
}
@end
