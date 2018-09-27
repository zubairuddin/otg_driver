//
//  CabType.m
//  Ride OTG
//
//  Created by Vijay on 30/11/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "CabType.h"
#import "Constant.h"
#import "GlobleMethod.h"

@implementation CabType
- (id)init{
    self =[super init];
    return self;
}
-(id)initwithAllCabsType:(NSDictionary *)dic{
    if (IS_NOT_NULL(dic, @"carPic")) {
        PFFile *carimage = GET_VALUE_STR(dic, @"carPic");
        self.strCabImgUrl = carimage.url;
    }
    if (IS_NOT_NULL(dic, @"code")) {
        self.strCarType = [dic[@"code"] intValue];
    }
    //strCarType
    if (IS_NOT_NULL(dic, @"title")) {
        self.strTitle = GET_VALUE_STR(dic, @"title");
    }
    if (IS_NOT_NULL(dic, @"capacity")) {
        self.capaCity = [dic valueForKey:@"capacity"];
    }
    if (IS_NOT_NULL(dic, @"base_fare")) {
        self.baseFare = [dic valueForKey:@"base_fare"];
    }
    if (IS_NOT_NULL(dic, @"time_per_minute")) {
        self.timeparMin = [dic valueForKey:@"time_per_minute"];
    }
    if (IS_NOT_NULL(dic, @"distance_mile")) {
        self.distanceMiles = [dic valueForKey:@"distance_mile"];
    }
    if (IS_NOT_NULL(dic, @"booking_fee")) {
        self.bookingFee = [dic valueForKey:@"booking_fee"];
    }

    return self;
    
}
@end
