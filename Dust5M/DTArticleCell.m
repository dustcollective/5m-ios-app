//
//  DTArticleCell.m
//  Dust5M
//
//  Created by Kemal Enver on 12/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticleCell.h"

@implementation DTArticleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
   // [super setSelected: selected animated: animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.thumbnailView.frame;
    
    frame.size = CGSizeMake(70, 70);
    
    self.thumbnailView.frame = frame;

}

@end
