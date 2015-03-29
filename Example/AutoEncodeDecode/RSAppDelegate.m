//
//  RSAppDelegate.m
//  AutoEncodeDecode
//
//  Created by CocoaPods on 03/28/2015.
//  Copyright (c) 2014 Ravi Prakash Sahu. All rights reserved.
//

#import "RSAppDelegate.h"
#import "RSClassA.h"
#import "RSClassB.h"

@implementation RSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self testAutoEncoderDecoder];
    
    // Override point for customization after application launch.
    return YES;
}

- (void)testAutoEncoderDecoder {
    // Write to file
    NSString *fileNameWithPath = [self getFilePath:@"Class_A_File"];
    [NSKeyedArchiver archiveRootObject:[self getTestRSClassAObject] toFile:fileNameWithPath];
    
    // Read the file
    RSClassA *readObjA = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSLog(@"Alpha : %@, Gaama : %@, Array : %@", readObjA.alpha, readObjA.beta, [readObjA.listArray componentsJoinedByString:@"|"]);
    
    // Write to file
    fileNameWithPath = [self getFilePath:@"Class_B_File"];
    [NSKeyedArchiver archiveRootObject:[self getTestRSClassBObject] toFile:fileNameWithPath];
    
    // Read the file
    RSClassB *readObjB = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSLog(@"Windows : %@, Mac : %@", readObjB.windows, readObjB.mac);
}

- (RSClassA*)getTestRSClassAObject {
    RSClassA *classObject = [RSClassA new];
    classObject.alpha = @"Test";
    classObject.beta = @(10);
    classObject.listArray = @[@"A", @"B"];
    return classObject;
}

- (RSClassB*)getTestRSClassBObject {
    RSClassB *classObject = [RSClassB new];
    classObject.windows = @"I hate it";
    classObject.mac = @"I love it";
    return classObject;
}

- (NSString*)getFilePath:(NSString *)aFileName {
    if (aFileName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        return [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", aFileName]];
    }
    return nil;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
