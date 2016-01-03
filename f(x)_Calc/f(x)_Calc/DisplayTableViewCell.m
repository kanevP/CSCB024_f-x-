//
//  DispkayTableViewCell.m
//  f(x)_Calc
//
//  Created by Petar Kanev on 1/3/16.
//  Copyright © 2016 Petar Kanev. All rights reserved.
//

#import "DisplayTableViewCell.h"

@implementation DisplayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.5];
        self.textLabel.textColor = [UIColor whiteColor];
        [self setNeedsUpdateConstraints];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
