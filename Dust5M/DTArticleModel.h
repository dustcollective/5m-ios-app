//
//  DTArticleModel.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DTArticle.h"

typedef enum {
    
    ArticleTypeInicio,
    ArticleTypeEvent,
    ArticleTypeNoticias
    
} ArticleType;

@interface DTArticleModel : NSObject

+ (AFHTTPRequestOperation *) articleListWithBlock: (void (^)(DTArticleModel *articleModel, NSError *error))block;

- (id) initWithAttributes: (NSDictionary *) attributes;

@property (nonatomic, strong) NSArray *newsContent;
@property (nonatomic, strong) NSArray *eventContent;
@property (nonatomic, strong) NSArray *favouriteContent;

@property (nonatomic, strong) NSArray *territories;

@property (nonatomic, assign) ArticleType selectedArticleType;

@end
