//
//  Article.m
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticle.h"


@implementation DTArticle

- (id) initWithAttributes: (NSDictionary *) attributes {
    
    if(self = [super init]) {
        
        self.contentId = attributes[@"id"];
        
        if([attributes[@"type"] isEqualToString: @"news"]) {
            
            self.contentType = ContentTypeNews;
        }
        else if([attributes[@"type"] isEqualToString: @"event"]) {
            
            self.contentType = ContentTypeEvent;
        }
        else {
            
            self.contentType = ContentTypeNone;
        }
        
        self.headline = attributes[@"headline"];
        self.thumbnailURL = attributes[@"thumbnail"];
        self.htmlBody = attributes[@"body"];
        self.countryCode = attributes[@"country"];
        self.linkString = attributes[@"link"];
        
        NSTimeInterval timeInterval = [attributes[@"date"] intValue];
        
        self.date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
        
    }
    
    return self;
}

- (ContentType) articleType {
    
    return self.contentType;
}

@end
