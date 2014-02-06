//
//  DTArticleCell.h
//  Dust5M
//
//  Created by Kemal Enver on 12/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTArticleCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *colorBarView;
@property (nonatomic, strong) IBOutlet UIImageView *thumbnailView;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) UIColor *articleTypeColor;

@end
