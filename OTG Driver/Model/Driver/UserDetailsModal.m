//
//  UserDetailsModal.m
//  Dedicaring
//
//  Created by pratik on 31/10/12.
//  Copyright (c) 2012. All rights reserved.
//

#import "UserDetailsModal.h"

@interface UserDetailsModal () {
    NSArray *imagesArray;
}

@end

@implementation UserDetailsModal

- (void)initialize {
    //Generate Random background image
}

+ (UserDetailsModal *)sharedUserDetails
{
	static dispatch_once_t once;
	static id sharedInstance;
	dispatch_once(&once, ^{
	    sharedInstance = [[self alloc] init];
	    [sharedInstance initialize];
	});
	return sharedInstance;
}

#pragma mark - CustomObject Methods

- (void)saveUser{
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.objDriverM];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"DriverInfo"];
    [defaults synchronize];
}

- (Driver *)loadUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"DriverInfo"];
    self.objDriverM = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return self.objDriverM;
}

-(void)driverLogOut{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"DriverInfo"];
    [defaults synchronize];
}

@end
