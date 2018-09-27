//
//  Cab.m
//  OTG Driver
//
//  Created by Ankur on 09/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "Cab.h"
#import "GlobleMethod.h"
#import "SimpleLatLng.h"
#import "UserDetailsModal.h"

@implementation Cab

-(id)init{
    self = [super init];
    return self;
}

+(NSMutableDictionary *)GetRideRequest:(bool)isAvailable {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:kUserDetails.objDriverM.name forKey:@"driverName"];
    [dic setValue:kUserDetails.objDriverM.objectid forKey:@"driverObjId"];
    [dic setValue:kUserDetails.objDriverM.imageURL forKey:@"driverDPUrl"];
    [dic setValue:kUserDetails.objDriverM.carType forKey:@"cabType"];
    [dic setObject:[NSNumber numberWithBool:isAvailable] forKey:@"isAvailable"];
    return dic;
}

+(NSMutableDictionary *)GetObjForRide:(bool)isAvailable {
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:kUserDetails.objDriverM.name forKey:@"driver_name"];
    [dic setValue:kUserDetails.objDriverM.objectid forKey:@"driver_obj_id"];
    [dic setValue:kUserDetails.objDriverM.imageURL forKey:@"driver_dp_url"];
    [dic setValue:kUserDetails.objDriverM.carType forKey:@"cab_type"];
    [dic setObject:[NSNumber numberWithBool:isAvailable] forKey:@"isAvailable"];
    return dic;
}



@end
