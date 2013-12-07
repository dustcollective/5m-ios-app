//
//  Article.h
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DTArticleModel.h"

@interface FavouriteArticle : NSManagedObject

@property (nonatomic, retain) NSString * contentId;
@property (nonatomic, retain) NSNumber * contentType;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * headline;
@property (nonatomic, retain) NSString * htmlBody;
@property (nonatomic, retain) NSString * linkString;
@property (nonatomic, retain) NSString * thumbnailURL;

- (ContentType) articleType;

@end
