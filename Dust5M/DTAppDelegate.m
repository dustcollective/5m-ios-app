//
//  DTAppDelegate.m
//  Dust5M
//
//  Created by Kemal Enver on 11/11/2013.
//  Copyright (c) 2013 dust. All rights reserved.
//

#import "DTAppDelegate.h"

#import "iRate.h"

BOOL splashShown = NO;

@implementation DTAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


+ (void)initialize {

    [iRate sharedInstance].daysUntilPrompt = 2;
    [iRate sharedInstance].usesUntilPrompt = 3;
    [iRate sharedInstance].previewMode = NO;
}


- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
    
    [GAI sharedInstance].optOut = NO;
    [GAI sharedInstance].dispatchInterval = 10;
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    self.tracker = [[GAI sharedInstance] trackerWithName: NSLocalizedString(@"APP_NAME", nil)
                                              trackingId: NSLocalizedString(@"TRACKER_ID", nil)];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    
    UIViewController *menuController = [storyboard instantiateViewControllerWithIdentifier: @"MenuController"];
    
    UINavigationController *startNavController = [storyboard instantiateViewControllerWithIdentifier: @"StartController"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController: startNavController
                                                            leftDrawerViewController: menuController];
    
    self.drawerController.showsShadow = NO;
    self.drawerController.maximumLeftDrawerWidth = 140.0f;
    self.drawerController.rightDrawerViewController = nil;
    //self.drawerController.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionModeFull;
    
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    
    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideVisualStateBlock]];
    
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
        
    return YES;
}


- (void) applicationWillResignActive: (UIApplication *) application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void) applicationDidEnterBackground: (UIApplication *) application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void) applicationWillEnterForeground: (UIApplication *) application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void) applicationDidBecomeActive: (UIApplication *) application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void) applicationWillTerminate: (UIApplication *) application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (NSManagedObjectContext *) managedObjectContext {
    
    if (_managedObjectContext != nil) {
        
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    
    return _managedObjectContext;
}


- (NSManagedObjectModel *) managedObjectModel {
    
    if (_managedObjectModel != nil) {
        
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles: nil];
    
    return _managedObjectModel;
}


- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"Favourites.sqlite"]];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    
    if(![_persistentStoreCoordinator addPersistentStoreWithType :NSSQLiteStoreType
                                                   configuration: nil URL: storeUrl options: nil error: &error]) {
    }
    
    return _persistentStoreCoordinator;
}


- (NSString *) applicationDocumentsDirectory {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
