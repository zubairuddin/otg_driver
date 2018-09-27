//
//  PrivecRide.m
//  Ride OTG
//
//  Created by Vijay on 28/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "PrivecRide.h"
#import "GlobleMethod.h"
@implementation PrivecRide
- (id)init{
    self =[super init];
    return self;
}
-(id)initwithRide:(PFObject *)dic{
    //    PFFile *carimage = GET_VALUE_STR(dic, @"drop_title");
    //    self.strDP = carimage.url;
    
    if (IS_NOT_NULL(dic, @"drop_title")) {
        self.strDrop = GET_VALUE_STR(dic, @"drop_title");
    }
    self.strTripID = dic.objectId;
    if (IS_NOT_NULL(dic, @"created")){
        NSString *dateString = [NSDateFormatter localizedStringFromDate:dic[@"created"]                                                              dateStyle:NSDateFormatterShortStyle                                                              timeStyle:NSDateFormatterMediumStyle];
        self.strDate = dateString;
    }
    if (IS_NOT_NULL(dic, @"charge")) {
        self.strPrice = GET_VALUE_STR(dic, @"charge");
    }
    if (IS_NOT_NULL(dic, @"status")) {
        self.strStatus = GET_VALUE_STR(dic, @"status");
    }
    if (IS_NOT_NULL(dic, @"pickup_title")) {
        self.strpickup = GET_VALUE_STR(dic, @"pickup_title");
    }
    if (IS_NOT_NULL(dic, @"rating_overall_driver")) {
        self.strOverAll = dic[@"rating_overall_driver"];
    }
    
    
    if (IS_NOT_NULL(dic, @"rider")) {
        PFObject *driverData =  dic[@"rider"];
        if (IS_NOT_NULL(driverData, @"name")) {
            self.strName = driverData[@"name"];
        }
//        if (IS_NOT_NULL(driverData, @"cab_type")) {
//            self.strCabType = [driverData[@"cab_type"] intValue];
//        }
        if (IS_NOT_NULL(driverData, @"dp")) {
            PFFile *image = [driverData objectForKey:@"dp"];
            self.strDP = image.url;
        }
        self.strDriverObjID = driverData.objectId;
        if (IS_NOT_NULL(driverData, @"ratings_count")) {
            float ratCount = [driverData[@"ratings_count"] floatValue];
            float ratValue = [driverData[@"ratings_value"] floatValue];
            self.Rate = [NSNumber numberWithFloat:(ratValue/ratCount)];
        }
    }
    
    if (IS_NOT_NULL(dic, @"payment_detail")){
        self.dictPaymentDetails = [NSJSONSerialization JSONObjectWithData:[dic[@"payment_detail"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    }
    if (IS_NOT_NULL(dic, @"rider")){
        PFUser *riderData =  dic[@"rider"];
        self.strRiderObjID = riderData.objectId;
    }
    
    return self;
}
@end

