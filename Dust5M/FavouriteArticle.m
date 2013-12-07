//
//  Article.m
//  Dust5M
//
//  Created by Kemal Enver on 05/12/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "FavouriteArticle.h"


@implementation FavouriteArticle

@dynamic contentId;
@dynamic contentType;
@dynamic countryCode;
@dynamic date;
@dynamic headline;
@dynamic htmlBody;
@dynamic linkString;
@dynamic thumbnailURL;

- (ContentType) articleType {
    
    return self.contentType.intValue;
}

@end
