//
//  CatalogAppDelegate.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/17/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAppDelegate.h"
#import "Product.h"
#import "Category.h"
#import "CatalogAdminPanelAddProductView.h"
#import "CatalogAdminEditViewController.h"
#import "CatalogIntroViewController.h"

@implementation CatalogAppDelegate

@synthesize window = _window;
@synthesize dataArray;
@synthesize filterArray;
@synthesize fieldArray;
@synthesize chosenProduct;
@synthesize chosenCategory;
@synthesize currentImage;
@synthesize addProductView;
@synthesize fieldType;
@synthesize editViewController;
@synthesize introViewController;
@synthesize moviePath;
@synthesize introDataArray;

- (NSString*)saveFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *filePath = [self saveFilePath];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if (fileExists)
    {
        NSData *codedData = [NSData dataWithContentsOfFile:filePath];
        NSMutableArray *components = (NSMutableArray*)[NSKeyedUnarchiver unarchiveObjectWithData:codedData];
        self.dataArray = [components objectAtIndex:0];
        self.filterArray = [components objectAtIndex:1];
        self.fieldArray = [components objectAtIndex:2];
        self.introDataArray = [components objectAtIndex:3];
        // Intro Data Array contains
        // Video Link at 0, BL Image at 1, BC Image at 2, and BR Image at 3.
        self.moviePath = [self.introDataArray objectAtIndex:0];
    }
    else
    {
        self.dataArray = [[NSMutableArray alloc] init];
        self.filterArray = [[NSMutableArray alloc] init];
        self.fieldArray = [[NSMutableArray alloc] init];
        self.introDataArray = [[NSMutableArray alloc] init];
        // Fill four indices with blank strings.
        [self.introDataArray addObject:[NSNull null]];
        [self.introDataArray addObject:[NSNull null]];
        [self.introDataArray addObject:[NSNull null]];
        [self.introDataArray addObject:[NSNull null]];
        self.moviePath = [[NSString alloc] init];
    }
    self.currentImage = NULL;
    self.addProductView = NULL;
    self.fieldType = [[NSString alloc] init];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Save data.  Index 0 contains all entered products, 1 contains all the products that meet the filter settings, and 2 contains all the categories.  3 contains all intro screen related data.
    NSMutableArray *components = [[NSMutableArray alloc] initWithObjects:self.dataArray, self.filterArray, self.fieldArray, self.introDataArray, nil];
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:components];
    [archivedData writeToFile:[self saveFilePath] atomically:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
