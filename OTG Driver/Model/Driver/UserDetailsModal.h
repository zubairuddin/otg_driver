//
//  UserDetailsModal.h
//  Dedicaring
//
//  Created by pratik on 31/10/12.
//  Copyright (c) 2012. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Driver.h"

@interface UserDetailsModal : NSObject

@property (nonatomic, strong) Driver *objDriverM;


+ (UserDetailsModal *)sharedUserDetails;
- (void)saveUser;
- (Driver *)loadUser;
- (void)driverLogOut;
@end
