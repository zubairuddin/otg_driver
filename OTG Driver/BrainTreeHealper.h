//
//  BrainTreeHealper.h
//  OTG Driver
//
//  Created by Vijay on 02/11/17.
//  Copyright © 2017 Vijay. All rights reserved.

#import <Foundation/Foundation.h>

@interface BrainTreeHealper : NSObject

+(void)DriverRegisterForBrainTree:(NSMutableDictionary*)dic completion:(void (^)(NSDictionary*  obje , NSError *error))completionBlock;

@end
