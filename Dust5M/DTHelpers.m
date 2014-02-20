//
//  DTMacros.m
//  Dust5M
//
//  Created by Kemal Enver on 13/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTHelpers.h"

@implementation DTHelpers

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
    
    return [stringToTrim stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
}


NSString * documentPath() {
    
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [documentPath objectAtIndex: 0];
}

UIColor * logoColor() {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = info[@"CFBundleDisplayName"];
    prodName = prodName.lowercaseString;
    
    if([prodName isEqualToString: @"avicola"]) {
        
        return RGB(238, 53, 35);
    }
    else if([prodName isEqualToString: @"beef"]) {
        
        return RGB(119, 99, 79);
    }
    else if([prodName isEqualToString: @"cattle"]) {
        
        return RGB(66, 18, 20);
    }
    else if([prodName isEqualToString: @"crop"]) {
        
        return RGB(140, 198, 63);
    }
    else if([prodName isEqualToString: @"dairy"]) {
        
        return RGB(246, 139, 32);
    }
    else if([prodName isEqualToString: @"fish"]) {
        
        return RGB(26, 176, 230);
    }
    else if([prodName isEqualToString: @"meat"]) {
        
        return RGB(150, 46, 53);
    }
    else if([prodName isEqualToString: @"pig"]) {
        
        return RGB(8, 64, 31);
    }
    else if([prodName isEqualToString: @"poultry"]) {
        
        return RGB(188, 166, 105);
    }
    else {
        
        return [UIColor blackColor];
    }
    
}

@end
