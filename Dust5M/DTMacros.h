//
//  DTMacros.h
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface DTMacros : NSObject

void loadImage(UIImageView *imageView, NSURL *imageURL, NSString *placeholderURLString);

NSString * trimString (NSString *stringToTrim);

NSString * documentPath();

@end
