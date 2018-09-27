//
//  Routes.m
//  Ride OTG
//
//  Created by Vijay on 09/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "Routes.h"
#import "Constant.h"

@implementation Routes

- (id)init{
    self =[super init];    
    return self;
}
-(id)initwithAllRouteType:(NSDictionary *)dic{
    if (IS_NOT_NULL(dic, @"legs")) {
        self.arrPoints = [[NSMutableArray alloc] init];
        NSMutableArray *arraTemp =[NSMutableArray new];
        arraTemp = [dic valueForKey:@"legs"];
        if (dic[@"overview_polyline"][@"points"]){
            self.strPoint = dic[@"overview_polyline"][@"points"];
            [self.arrPoints addObject:[self polylineWithEncodedString:dic[@"overview_polyline"][@"points"]]];
        }
        for (NSDictionary *temDic in arraTemp) {
            if ([temDic valueForKey:@"distance"] ) {
                self.strDistant = [[temDic valueForKey:@"distance"] valueForKey:@"text"];
            }
            if ([temDic valueForKey:@"duration"] ) {
                self.strTime = [[temDic valueForKey:@"duration"] valueForKey:@"text"];
            }
            
            /*if([temDic valueForKey:@"steps"]) {
                if (dic[@"overview_polyline"][@"points"]){
                    [self.arrPoints addObject:[self polylineWithEncodedString:dic[@"overview_polyline"][@"points"]]];
                }
                //NSMutableArray *arrTmpRoute = [[NSMutableArray alloc] initWithArray:[temDic valueForKey:@"steps"]];
                //for (NSMutableDictionary *dictData in arrTmpRoute) {
                    //[self.arrPoints addObject:[self polylineWithEncodedString:dictData[@"polyline"][@"points"]]];
                    NSMutableDictionary *dictLatLong = [[NSMutableDictionary alloc] init];
                    if([dictData valueForKey:@"start_location"]){
                        dictLatLong[@"latitude"] = [[dictData valueForKey:@"start_location"] valueForKey:@"lat"];
                        dictLatLong[@"longitude"] = [[dictData valueForKey:@"start_location"] valueForKey:@"lng"];
                        [self.arrPoints addObject:dictLatLong];
                    /
                }
            }*/
        }
    }
    
    return self;
}

-(NSMutableArray *)polylineWithEncodedString:(NSString *)encodedString {
    const char *bytes = [encodedString UTF8String];
    NSUInteger length = [encodedString lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    NSUInteger idx = 0;    
    NSUInteger count = length / 4;
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    __block NSUInteger coordIdx = 0;
    NSMutableArray *arrWayPoint = [[NSMutableArray alloc] init];
    float latitude = 0;
    float longitude = 0;
    while (idx < length) {
        char byte = 0;
        int res = 0;
        char shift = 0;
        
        do {
            byte = bytes[idx++] - 63;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLat = ((res & 1) ? ~(res >> 1) : (res >> 1));
        latitude += deltaLat;
        
        shift = 0;
        res = 0;
        
        do {
            byte = bytes[idx++] - 0x3F;
            res |= (byte & 0x1F) << shift;
            shift += 5;
        } while (byte >= 0x20);
        
        float deltaLon = ((res & 1) ? ~(res >> 1) : (res >> 1));
        longitude += deltaLon;
        
        float finalLat = latitude * 1E-5;
        float finalLon = longitude * 1E-5;
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(finalLat, finalLon);
            coords[coordIdx++] = coord;
            NSMutableDictionary *dictLatLong = [[NSMutableDictionary alloc] init];
        dictLatLong[@"latitude"]  = [NSNumber numberWithDouble:coord.latitude];//[NSString stringWithFormat:@"%.7f",coord.latitude];
        dictLatLong[@"longitude"] = [NSNumber numberWithDouble:coord.longitude];//[NSString stringWithFormat:@"%.7f",coord.longitude];
            [arrWayPoint addObject:dictLatLong];
        if (coordIdx == count) {
            NSUInteger newCount = count + 10;
            coords = realloc(coords, newCount * sizeof(CLLocationCoordinate2D));
            count = newCount;
        }
    }
    free(coords);
    return arrWayPoint;
}

@end
