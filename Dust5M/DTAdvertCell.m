//
//  DTAdvertCell.m
//  Dust5M
//
//  Created by Kemal Enver on 09/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTAdvertCell.h"

@implementation DTAdvertCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        //self.imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //self.imageView.layer.borderWidth = 1.0f;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

@end
