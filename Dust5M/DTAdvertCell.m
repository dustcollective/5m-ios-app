//
//  DTAdvertCell.m
//  Dust5M
//
//  Created by Kemal Enver on 09/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTAdvertCell.h"

@implementation DTAdvertCell

- (id) initWithStyle: (UITableViewCellStyle) style reuseIdentifier: (NSString *) reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}


- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.bounds;
}

@end
