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
@dynamic territory;
@dynamic favourite;

@dynamic startDate;
@dynamic endDate;
@dynamic location;

- (void) setAttributes: (NSDictionary *) attributes {
    
    self.contentType = attributes[@"type"];
    if([self.contentType isEqualToString: @"help"]) {
        
        self.contentId = @"999";
    }
    else {
        
        self.contentId = attributes[@"id"];
    }
    
    self.headline = attributes[@"headline"];
    self.thumbnailURL = attributes[@"thumbnail"];
    self.htmlBody = attributes[@"body"];
    self.countryCode = attributes[@"country"];
    self.linkString = attributes[@"link"];
    self.territory = trimString(attributes[@"territory"]);
    
    self.favourite = 0;
    
    NSTimeInterval timeInterval = [attributes[@"date"] intValue];
    self.date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
    
    if(attributes[@"start"]) {
        
        NSTimeInterval startTimeInterval = [attributes[@"start"] intValue];
        self.startDate = [NSDate dateWithTimeIntervalSince1970: startTimeInterval];
    }
    
    if(attributes[@"end"]) {
        
        NSTimeInterval endTimeInterval = [attributes[@"end"] intValue];
        self.endDate = [NSDate dateWithTimeIntervalSince1970: endTimeInterval];
    }
    
    if(attributes[@"location"]) {
        
        self.location = attributes[@"location"];
    }
}


@end
