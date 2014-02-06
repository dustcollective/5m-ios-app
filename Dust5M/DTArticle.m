//
//  Article.m
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticle.h"


@implementation DTArticle

@dynamic contentId;
@dynamic contentType;
@dynamic countryCode;
@dynamic date;
@dynamic headline;
@dynamic htmlBody;
@dynamic imageBinary;
@dynamic linkString;
@dynamic thumbnailURL;
@dynamic favourite;

- (void) setAttributes: (NSDictionary *) attributes {
    
    self.contentId = attributes[@"id"];
    self.contentType = attributes[@"type"];
    self.headline = attributes[@"headline"];
    self.thumbnailURL = attributes[@"thumbnail"];
    self.htmlBody = attributes[@"body"];
    self.countryCode = attributes[@"country"];
    self.linkString = attributes[@"link"];
    
    self.favourite = 0;
    
    NSTimeInterval timeInterval = [attributes[@"date"] intValue];
    self.date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
}



@end
