//
//  DTBaseArticleCell.h
//  Dust5M
//
//  Created by Kemal Enver on 10/02/2014.
//  Copyright (c) 2014 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTBaseArticleCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *colorBarView;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) UIColor *articleTypeColor;

@end
