//
//  DTBaseArticleCell.m
//  Dust5M
//
//  Created by Kemal Enver on 10/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import "DTBaseArticleCell.h"

@implementation DTBaseArticleCell

- (void) willMoveToSuperview: (UIView *) newSuperview {
    
    [super willMoveToSuperview: newSuperview];
    
    self.descriptionLabel.font = [UIFont fontWithName: @"BetonEF-DemiBold" size: 14.0f];
   // self.dateLabel.font = [UIFont fontWithName: @"Arial" size: 12.0f];
    
}




@end
