//
//  Article.h
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

typedef enum {
    
    ContentTypeNone,
    ContentTypeNews,
    ContentTypeEvent
    
} ContentType;

@interface DTArticle : NSObject

@property (nonatomic, retain) NSString * contentId;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * thumbnailURL;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * htmlBody;
@property (nonatomic, retain) NSString * linkString;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, assign) ContentType contentType;
@property (nonatomic, assign) ContentType articleType;

- (id) initWithAttributes: (NSDictionary *) attributes;

- (ContentType) articleType;

@end
