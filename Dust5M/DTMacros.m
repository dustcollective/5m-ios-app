//
//  DTMacros.m
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTMacros.h"

@implementation DTMacros

void loadImage(UIImageView *imageView, NSURL *imageURL, NSString *placeholderURLString) {
    
    imageView.image = nil;
    
    NSURLRequest *imageReq = [NSURLRequest requestWithURL: imageURL];
    
    __weak UIImageView *weakImageView = imageView;
    [imageView setImageWithURLRequest: imageReq
                     placeholderImage: [UIImage imageNamed: placeholderURLString]
                              success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                  
                                  if(response == nil && request == nil) {
                                      
                                      weakImageView.image = image;
                                  }
                                  else {
                                      
                                      [UIView transitionWithView: weakImageView
                                                        duration: 0.2f
                                                         options: UIViewAnimationOptionTransitionCrossDissolve
                                                      animations: ^{
                                                          
                                                          weakImageView.image = image;
                                                      }
                                                      completion: nil];
                                  }
                                  
                              } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                  
                              }];
}


NSString * trimString (NSString *stringToTrim) {
    
    if([stringToTrim isEqualToString: @"Africa"]) {
        
        NSLog(@"AFrica");
    }
    
    return [stringToTrim stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}


NSString * documentPath() {
    
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [documentPath objectAtIndex: 0];
}

@end
