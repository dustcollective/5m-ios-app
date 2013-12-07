//
//  DTArticleModel.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTArticleModel.h"


#import "DTAPIClient.h"

@implementation DTArticleModel

- (id) initWithAttributes: (NSDictionary *) attributes {
    
    if(self = [super init]) {
        
        self.selectedArticleType = ArticleTypeInicio;
        
        NSArray *contents = attributes[@"contents"];
        
        NSMutableArray *processedNews = [[NSMutableArray alloc] initWithCapacity: contents.count];
        NSMutableArray *processedEvents = [[NSMutableArray alloc] initWithCapacity: contents.count];
        
        for(NSDictionary *article in contents) {
            
            DTArticle *tempContent = [[DTArticle alloc] initWithAttributes: article];
            
            if(tempContent.contentType == ContentTypeNews) {
                [processedNews addObject: tempContent];
            }
            else if(tempContent.contentType == ContentTypeEvent) {
                [processedEvents addObject: tempContent];
            }
        }
        
        self.newsContent = processedNews;
        self.eventContent = processedEvents;
        
        
        NSArray *territories = attributes[@"territories"];
        NSMutableArray *processedTerritories = [NSMutableArray arrayWithCapacity: territories.count];

        for(NSDictionary *territoryItem in territories) {
            
            NSString *territoryName = territoryItem[@"name"];
            
            [processedTerritories addObject: territoryName];
            
        }
        
        self.territories = processedTerritories;
    }
    
    return self;
}

+ (AFHTTPRequestOperation *) articleListWithBlock: (void (^)(DTArticleModel *articleModel, NSError *error))block {
    
    return [[DTAPIClient sharedClient] GET: @"http://avicola.ios-app-feed.5m-app.dust.screenformat.com"
                                      parameters: nil
                                         success: ^(AFHTTPRequestOperation * __unused task, id JSON) {
                                             
                                             DTArticleModel *articleModel = [[DTArticleModel alloc] initWithAttributes: JSON];
                                             
                                             if (block) {
                                                 
                                                 block(articleModel, nil);
                                             }
                                         }
                                         failure:^(AFHTTPRequestOperation *__unused task, NSError *error) {
                                             
                                             if (block) {
                                                 
                                                 block(nil, error);
                                             }
                                         }];
}

@end
