//
//  PrivecRide.h
//  Ride OTG
//
//  Created by Vijay on 28/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobleMethod.h"

@interface PrivecRide : NSObject
@property NSString *strpickup;
@property NSString *strRiderObjID;
@property NSString *strDriverObjID;
@property NSString *strTripID;
@property NSString *strDrop;
@property NSString *strDP;
@property NSString *strName;
@property NSString *strPrice;
@property NSNumber *Rate;
@property NSNumber *strOverAll;
@property NSString *strDate;
@property int strCabType;
@property NSString *strStatus;
@property NSMutableDictionary *dictPaymentDetails;
-(id)initwithRide:(PFObject *)dic;
@end

