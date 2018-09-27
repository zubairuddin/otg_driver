//
//  CabType.h
//  Ride OTG
//
//  Created by Vijay on 30/11/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CabType : NSObject

@property NSString *strCabImgUrl;
@property NSString *strTitle;
@property NSNumber *capaCity;
@property NSNumber *baseFare;
@property NSNumber *timeparMin;
@property NSNumber *distanceMiles;
@property NSNumber *bookingFee;
@property int       strCarType;

-(id)initwithAllCabsType:(NSDictionary *)dic;

@end
