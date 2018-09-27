//
//  Routes.h
//  Ride OTG
//
//  Created by Vijay on 09/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Routes : NSObject

@property NSString *strTime;
@property NSString *strDistant;
@property NSString *strPoint;
@property NSMutableArray *arrPoints;

-(id)initwithAllRouteType:(NSDictionary *)dic;

@end
