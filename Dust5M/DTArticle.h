//
//  Article.h
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DTArticle : NSManagedObject

@property (nonatomic, retain) NSString *contentId;
@property (nonatomic, retain) NSString *contentType;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSString *headline;
@property (nonatomic, retain) NSString *htmlBody;
@property (nonatomic, retain) NSData *imageBinary;
@property (nonatomic, retain) NSString *linkString;
@property (nonatomic, retain) NSString *thumbnailURL;
@property (nonatomic, retain) NSString *territory;
@property (nonatomic, retain) NSNumber *favourite;

// Only used for event type
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSDate *startDate;
@property (nonatomic, retain) NSDate *endDate;

- (void) setAttributes: (NSDictionary *) attributes;

@end
