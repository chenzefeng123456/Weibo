//
//  myTableViewCell.m
//  ItemWeibo
//
//  Created by 3014 on 16/8/10.
//  Copyright © 2016年 3014. All rights reserved.
//

#import "myTableViewCell.h"

@implementation myTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.wbName.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
