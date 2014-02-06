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


- (void) willMoveToSuperview:(UIView *)newSuperview {
    
    [super willMoveToSuperview: newSuperview];
    
    self.descriptionLabel.font = [UIFont fontWithName: @"BetonEF-DemiBold" size: 14.0f];
    self.dateLabel.font = [UIFont fontWithName: @"Arial" size: 12.0f];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    if(selected) {
        
        self.colorBarView.backgroundColor = [UIColor whiteColor];
    }
   // [super setSelected: selected animated: animated];

    // Configure the view for the selected state
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    if(highlighted) {
        self.colorBarView.backgroundColor = [UIColor whiteColor];
        
    }
    
    [super setHighlighted: highlighted animated: animated];
}

- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = self.thumbnailView.frame;
    
    frame.size = CGSizeMake(55, 55);
    
    self.thumbnailView.frame = frame;

}

@end
