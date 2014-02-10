//
//  DTMainArticleCell.m
//  Dust5M
//
//  Created by Kemal Enver on 10/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTMainArticleCell.h"

@implementation DTMainArticleCell


- (void) layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect frame = CGRectMake(0, 0, 320, 226.0f);
    
    self.thumbnailView.frame = frame;
}


@end
