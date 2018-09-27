//
//  AppDelegate.m
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © Vijay. All rights reserved.
//com.onthegoGlam
//com.socialbevy

#import "AppDelegate.h"
#import "Parse.h"
#import <Parse/Parse.h>
#import "Cab.h"
#import "IQKeyboardManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "HomeVC.h"
#import "Constant.h"
#import "Constants.h"
#import "UserDetailsModal.h"
#import "LoginVC.h"
#import "SplashVideo.h"

@import GoogleMaps;
@import GooglePlaces;
@import Firebase;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.arryAllCab         = [[NSMutableArray alloc]init];
    // Goog Map
    //    [GMSServices provideAPIKey:@"AIzaSyBHk_PxpdbzoGNh-Apeh9XM30VDX0RW26M"];
    //    [GMSPlacesClient provideAPIKey:@"AIzaSyBc9JhUk0nHcx-NgSE2hrHZd-6SGJaIaIc"];
    
    self.objDriver = [[Driver alloc] init];
    
    [GMSPlacesClient provideAPIKey:GOOGLE_PLACES_KEY];
    [GMSServices provideAPIKey:GOOGLE_PLACES_KEY];
    
    // Firebase
    
    [FIRApp configure];
    self.ref = [[FIRDatabase database] reference];
    [GIDSignIn sharedInstance].clientID = [FIRApp defaultApp].options.clientID;
    
    
    // Parse    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"vPFf4LtDjbOZXH6l4GpIauDfRNpWP3cQpqKEhj0h";
        configuration.clientKey = @"M4Wj9TEi93ODsdsrcxgx8LOlOoTSpEU08ulDV8P3";
        configuration.server = @"https://parseapi.back4app.com/";
        configuration.localDatastoreEnabled = YES;
    }]];
    [self keyBoardIconeColorChange];

    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    
    
//    BOOL isStayLoged = [[[NSUserDefaults standardUserDefaults] valueForKey:@"STAYLOGGED"] boolValue];
//
//    if(isStayLoged){
//        SplashVideo *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SplashVideo"];
//        self.rootNavController = [[UINavigationController alloc] initWithRootViewController:rootVC];
//    }else{
//        LoginVC *lvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"];
//        self.rootNavController = [[UINavigationController alloc] initWithRootViewController:lvc];
//    }
    
//    self.window.rootViewController = self.rootNavController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

+(AppDelegate *)shareInstance{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//PRAGMA MARK:- Driver Info
-(void)getDriverInfo:(isSuccess) completion{
    [ParseHelper getUserData:^(NSArray *obje, NSError *error) {
        NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
        temp1 = (NSMutableDictionary*)obje;
        NSLog(@"Logine object  %@ ",temp1);
    
        Driver *objDriver = [[Driver alloc] initwithLogineDetaile:temp1];
        kUserDetails.objDriverM = objDriver;
        [kUserDetails saveUser];
        kUserDetails.objDriverM = [kUserDetails loadUser];
        completion(YES);
    }];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application                                                            openURL:url                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    if (handled == false) {
        return  [[GIDSignIn sharedInstance] handleURL:url                                            sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]                                           annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }
    // Add any custom logic here.
    return handled;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:kisDriverRemoved];
    [self removeDriverFromFireBase];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"callViewWillAppear"
     object:self];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:kisDriverRemoved];
    [self removeDriverFromFireBase];
}

-(void) removeDriverFromFireBase{
    //Remove Driver From FireBase : Make Drive Offline
    if ([GlobleMethod getValueFromUserDefault:@"CABID"]) {
        NSString *cabId = [GlobleMethod getValueFromUserDefault:@"CABID"];
        [[[self.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]] child:cabId]removeValueWithCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if (!error) {
                NSLog(@"remove object");
            }
        }];
    }
}
-(void)keyBoardIconeColorChange{
    [[IQKeyboardManager sharedManager] setEnable: YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar: YES];
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField: 15];
    [[IQKeyboardManager sharedManager] setToolbarTintColor: [UIColor blackColor]];
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour: IQAutoToolbarByTag];
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside: YES];
}
@end
