//
//  LocationBaseService.m
//  Ride OTG
//
//  Created by Hiren on 06/11/17.
//  Copyright © 2017 Hiren. All rights reserved.
//

#import "LocationBaseService.h"

@implementation LocationBaseService

+ (instancetype)sharedInstance
{
    static LocationBaseService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationBaseService alloc] init];
        // Do any other initialisation stuff here

        sharedInstance.locationManager = [[CLLocationManager alloc] init];
    });
    return sharedInstance;
}

-(void)GetCurrentLocation
{
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    
    [self.locationManager startUpdatingLocation];
}

#pragma mark - Location update delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *newLocation = [locations lastObject];
    
    NSLog(@"Lat: %f", newLocation.coordinate.latitude);
    NSLog(@"Long: %f",newLocation.coordinate.longitude);
    
    [[NSUserDefaults standardUserDefaults] setObject:@(newLocation.coordinate.latitude) forKey:kLatitude];
    [[NSUserDefaults standardUserDefaults] setObject:@(newLocation.coordinate.longitude) forKey:kLongitude];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   // [self.locationManager stopUpdatingLocation];
}

@end
