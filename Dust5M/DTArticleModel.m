//
//  DTArticleModel.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTAppDelegate.h"

#import "DTArticleModel.h"


#import "DTAPIClient.h"

@interface DTArticleModel () {

    int _inlineFrequency;
}

@end

@implementation DTArticleModel


- (id) init {
    
    if(self = [super init]) {
        
        self.managedContext = ((DTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        
        self.managedModel = ((DTAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectModel;
    }
    
    return self;
}


- (void) setWithAttributes: (NSDictionary *) attributes {
    
    [self syncTerritories: attributes[@"territories"]];
    
    [self syncContentFromFeed: attributes[@"contents"]];
    
    [self syncAds: attributes[@"adverts"]];
}


- (void) syncAds: (NSDictionary *) adAttributes {
    
    _inlineFrequency = [adAttributes[@"inline_frequency"] intValue];
    
    self.adverts = adAttributes[@"inline"];
}


- (void) syncTerritories: (NSArray *) territories {
    
    NSMutableArray *processedTerritories = [NSMutableArray arrayWithCapacity: territories.count];
    
    for(NSDictionary *territoryItem in territories) {
        
        NSString *territoryName = territoryItem[@"name"];
        
        [processedTerritories addObject: territoryName];
    }
    
    self.territories = processedTerritories;
}


- (void) syncContentFromFeed: (NSArray *) contents {
    
    for(NSDictionary *article in contents) {
        
        if(![article[@"type"] isEqualToString: @"help"]) {
            
            NSString *articleid = article[@"id"] ? article[@"id"] : @"999";
            
            NSFetchRequest *articleForIDFetch = [self.managedModel fetchRequestFromTemplateWithName: @"articleForIDFetch"
                                                                              substitutionVariables: @{@"CONTENT_ID" : articleid}];
            
            NSError *countError = nil;
            NSUInteger count = [self.managedContext countForFetchRequest: articleForIDFetch error: &countError];
            
            if(countError) {
                
                NSLog(@"Count error %@", countError);
            }
            
            if(count == 0) {
                
                DTArticle *tempContent = [NSEntityDescription insertNewObjectForEntityForName: @"DTArticle" inManagedObjectContext: self.managedContext];
                
                [tempContent setAttributes: article];
            }
        }
    }
    
    NSError *error = nil;
    [self.managedContext save: &error];
    
    if(error) {
        
        NSLog(@"Error syncing content %@", error);
    }
}


- (NSArray *) fetchHelp {
    
    NSFetchRequest *fetchRequest = [self.managedModel fetchRequestTemplateForName: @"helpFetch"
                                                                 ] ;
    
    return [self.managedContext executeFetchRequest: fetchRequest error: nil];
}


- (void) fetchContentForContentType: (NSString *) contentType withRegionModel: (NSDictionary *) regionModel {
    
    NSFetchRequest *fetchRequest = nil;
    
    BOOL allEnabled = [regionModel[@"all"] boolValue];
    
    if(allEnabled) {
        
        fetchRequest = [self.managedModel fetchRequestFromTemplateWithName: @"allRegionsContentFetch"
                                                     substitutionVariables: @{@"CONTENT_TYPE" : contentType}];
    }
    else {
        
        NSMutableSet *regions = [NSMutableSet setWithCapacity: 1];
        NSArray *terArray = regionModel[@"territories"];
        
        for(NSDictionary *territoryDictionary in terArray) {
            
            if([territoryDictionary[@"selected"] boolValue]) {
                
                [regions addObject: territoryDictionary[@"name"]];
            }
        }
        
        //Filter the array and get a list of territories we want.
        fetchRequest = [self.managedModel fetchRequestFromTemplateWithName: @"filteredRegionsContentFetch"
                                                     substitutionVariables: @{@"CONTENT_TYPE" : contentType,
                                                                              @"REGIONS" : regions}];
        
        
    }
    fetchRequest.fetchLimit = 80;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"date" ascending: NO];
    fetchRequest.sortDescriptors= @[sortDescriptor];
    
    NSArray *fetchedEvents = [self.managedContext executeFetchRequest: fetchRequest error: nil];
    
    self.content = fetchedEvents;
    
    NSLog(@"Fetched %ld objects", (unsigned long)self.content.count);
    
    [self insertAdverts];
}


- (void) fetchFavouriteContentForContentType: (NSString *) contentType {
    
    NSFetchRequest *fetchRequest = [self.managedModel fetchRequestFromTemplateWithName: @"favouriteContentFetch"
                                                                 substitutionVariables: @{@"CONTENT_TYPE" : contentType}] ;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending: NO];
    fetchRequest.sortDescriptors= @[sortDescriptor];
    
    NSArray *fetchedEvents = [self.managedContext executeFetchRequest: fetchRequest error: nil];

    self.content = fetchedEvents;
}


- (void) insertAdverts {
    
    NSMutableArray *mutableContent = [NSMutableArray arrayWithArray: self.content];
    
    int position = _inlineFrequency;
    int i = 0;
    while (i < self.adverts.count) {
        
        if(i < self.adverts.count && position < mutableContent.count) {
            
            [mutableContent insertObject: [NSNumber numberWithInt: i] atIndex: position];
            position = position + _inlineFrequency + 1;
        }
        else {
            
            break;
        }
        i++;
    }
    
    self.content = mutableContent;
}


+ (AFHTTPRequestOperation *) articleListWithBlock: (void (^)(DTArticleModel *articleModel, NSError *error)) block {
    
    return [[DTAPIClient sharedClient] GET: @""
                                      parameters: nil
                                         success: ^(AFHTTPRequestOperation * __unused task, id JSON) {
                                             
                                             DTArticleModel *articleModel = [[DTArticleModel alloc] init];
                                             [articleModel setWithAttributes: JSON];
                                             
                                             if (block) {
                                                 
                                                 block(articleModel, nil);
                                             }
                                         }
                                   failure: ^(AFHTTPRequestOperation *__unused task, NSError *error) {
                                       
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle: NSLocalizedString(@"NETWORK_ERROR_TITLE", @"Network error Title")
                                                                                       message: NSLocalizedString(@"NETWORK_ERROR_MESSAGE", @"Network error Message")
                                                                                      delegate: Nil
                                                                             cancelButtonTitle: NSLocalizedString(@"OK", @"Ok")
                                                                             otherButtonTitles: nil];
                                       [alert show];
                                       
                                       // If there's an error we create the model and perhaps use
                                             // unsynced data
                                             DTArticleModel *articleModel = [[DTArticleModel alloc] init];
                                             
                                             if (block) {
                                                 
                                                 block(articleModel, error);
                                             }
                                         }];
}


@end
