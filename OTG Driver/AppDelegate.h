//
//  AppDelegate.h
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobleMethod.h"
#import "Driver.h"

@import Firebase;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
typedef void(^isSuccess)(BOOL);

@property (strong, nonatomic) UIWindow *window;
@property  BOOL isTerm;
@property  BOOL isPolicy;
@property  BOOL isAvalable;
@property  BOOL isEditCar;
@property  BOOL isEditProfile;
@property  BOOL isRideObserv;
@property  BOOL isLogout;
@property NSMutableArray *arryAllCab;
@property (strong, nonatomic) Driver *objDriver;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (nonatomic,strong) IBOutlet UINavigationController *rootNavController;

-(void)getDriverInfo:(isSuccess)completion;

#pragma mark-
+(AppDelegate *) shareInstance;
@end

