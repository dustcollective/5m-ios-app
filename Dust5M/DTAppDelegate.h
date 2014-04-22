//
//  DTAppDelegate.h
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import <UIKit/UIKit.h>

extern BOOL splashShown;

@interface DTAppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic, strong) id<GAITracker> tracker;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MMDrawerController *drawerController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
