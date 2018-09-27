//
//  BrainTreeHealper.m
//  OTG Driver
//
//  Created by Vijay on 02/11/17.
//  Copyright © 2017 Vijay. All rights reserved.


#import "BrainTreeHealper.h"
#import "AFNetworking.h"
#import "BrainTreeHealper.h"
#import "Constant.h"

@implementation BrainTreeHealper

+(void)DriverRegisterForBrainTree:(NSMutableDictionary*)dic completion:(void (^)(NSDictionary*  obje , NSError *error))completionBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,register_driver_url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject  %@",responseObject);
        NSError* error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject
                                                             options:kNilOptions
                                                               error:&error];
        
        if (responseObject) {
            completionBlock(json , nil);
        }else{
            completionBlock(json , ErrorMessage);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error  %@",error);
        completionBlock(nil , ErrorMessage);
    }];
}


@end
