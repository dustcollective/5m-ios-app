//
//  DTArticleModel.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DTArticle.h"

@interface DTArticleModel : NSObject

+ (AFHTTPRequestOperation *) articleListWithBlock: (void (^)(DTArticleModel *articleModel, NSError *error))block;

- (void) setWithAttributes: (NSDictionary *) attributes;

- (NSArray *) fetchHelp;
- (void) fetchContentForContentType: (NSString *) contentType withRegionModel: (NSDictionary *) regionModel;
- (void) fetchFavouriteContentForContentType: (NSString *) contentType;

@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSArray *adverts;

@property (nonatomic, strong) NSArray *territories;

@property (nonatomic, strong) NSManagedObjectContext *managedContext;
@property (nonatomic, strong) NSManagedObjectModel *managedModel;


@property (nonatomic, strong) NSMutableArray *filteredContent;

@end
