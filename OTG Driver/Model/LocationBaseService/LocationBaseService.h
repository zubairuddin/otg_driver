//
//  LocationBaseService.m
//  Ride OTG
//
//  Created by Hiren on 06/11/17.
//  Copyright © 2017 Hiren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"

@interface LocationBaseService : NSObject <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;

+ (instancetype)sharedInstance;
-(void)GetCurrentLocation;
@end
