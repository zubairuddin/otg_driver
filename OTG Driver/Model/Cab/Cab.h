//
//  Cab.h
//  OTG Driver
//
//  Created by Ankur on 09/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cab : NSObject
@property NSString *driverName;
@property NSString *driverObjId;
@property NSString *driverDPUrl;
@property NSString *areaCity;

@property int cabType;
@property NSData *updatedAt;

//public long updatedMillis;

@property NSString *cancelledRideRequestId;

+(NSMutableDictionary *)GetRideRequest:(bool)isAvailable;
+(NSMutableDictionary *)GetObjForRide:(bool)isAvailable;
//:(BOOL)isAvailable;
@end
