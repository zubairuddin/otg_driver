//
//  Constant.h
//  Restaurant
//
//  Created by bhavesh donga on 2/23/16.
//  Copyright © 2016 bhavesh donga. All rights reserved.
//

#import "AppDelegate.h"
#import "Driver.h"

#ifndef Constant_h
#define Constant_h

#define Terms_and_Conditions  @"https://api.rideotg-dev.xyz/tnc2.html"
#define Privacy @"https://api.rideotg-dev.xyz/pp2.html"

// Sadbox For Braintree
#define BASE_URL @"https://api.rideotg-dev.xyz"
#define register_driver_url  @"/payment/sandbox/register_driver.php"

//#define save_payment_method_url_live @"/payment/production/create_payment_method.php"
//#define register_rider_url  @"/payment/sandbox/register_rider.php"
//#define client_token_url  @"/payment/sandbox/create_token.php"
//#define charge_with_method_url @"/payment/sandbox/create_charge_with_method.php"
//#define save_payment_method_url @"/payment/sandbox/create_payment_method.php"


#define appDeleget [AppDelegate shareInstance]
#define kUserDetails [UserDetailsModal sharedUserDetails]

#define AlertTitle @"Ride OTG"
#define ErrorMessage @"Ride OTG experencing temporary problem."
#define ErrorWrongEmailPswd @"Incorrect Email-id or password."
#define NetworkConnectionError @"Your Internet connection is either slow \nor not available."
#define ReditionPopup  13
#define CornarReditionButton  4

#define TexfildePlaseHolderColre [UIColor colorWithRed:197.0f/255.0f green:202.0f/255.0f blue:205.0f/255.0f alpha:1.0]
#define TheamColor [UIColor colorWithRed:244.0f/255.0f green:0 blue:87.0f/255.0f alpha:1.0]

//PARIMARY DARK -------------
#define PrimaryDarkColor [UIColor colorWithRed:0.0 green:200.0f/255.0f blue:83.0f/255.0f alpha:1.0]
//PRIMARY -----------------
#define PrimaryColor [UIColor colorWithRed:0.0 green:230.0/255.0f blue:118.0/255.0f alpha:1.0]
//PRIMARY ACCENT ------------
#define PrimaryAccetColor [UIColor colorWithRed:38.0f/255.0f green:50.0f/255.0f blue:56.0f/255.0f alpha:1.0]

#define NCRemoveTabbar              @"NCRemoveTabbar"
#define NCAddTabbar                 @"NCAddTabbar"

#define GOOGLE_PLACES_KEY           @"AIzaSyC_2FWC1M8R7oppX0olCMZtJ8Qv1_nzxYo"

#define IS_NOT_NULL(dict, key) [dict objectForKey:key] && ![[dict objectForKey:key] isEqual:[NSNull null]]

#define GET_VALUE_STR(dict, key)     [dict objectForKey:key]

#define GET_VALUE_STRING(dict, key)     [dict objectForKey:key]

#define GET_VALUE_INT(dict, key)        [[dict objectForKey:key] intValue]

#define GET_VALUE_FLOAT(dict, key)      [[dict objectForKey:key] floatValue]

#define GET_VALUE_BOOL(dict, key)       [[dict objectForKey:key] boolValue]

#define GET_VALUE_OBJECT(dict, key)     [dict objectForKey:key]

#define GET_VALUE_OBJ(dict, key)     [dict objectForKey:key]


#define IS_HEIGHT_GTE_480 [[UIScreen mainScreen ] bounds].size.height == 480.0f
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height == 568.0f
#define IS_HEIGHT_GTE_667 [[UIScreen mainScreen ] bounds].size.height == 667.0f
#define IS_HEIGHT_GTE_736 [[UIScreen mainScreen ] bounds].size.height == 736.0f
#define IS_HEIGHT_GTE_812 [[UIScreen mainScreen ] bounds].size.height == 812.0f

#define IS_IPHONE_4     (IS_HEIGHT_GTE_480)
#define IS_IPHONE_5     (IS_HEIGHT_GTE_568)
#define IS_IPHONE_6     (IS_HEIGHT_GTE_667)
#define IS_IPHONE_6Plus (IS_HEIGHT_GTE_736)
#define IS_IPHONE_X     (IS_HEIGHT_GTE_812)

#define save_Merchanid @"braintreeMerchantId_sandbox"
#define kLatitude @"Latitude"
#define kLongitude @"Longitude"
#define kisDriverRemoved @"isDriverRemoved"

typedef void(^isSuccess)(BOOL);

//production For Braintree

//#define save_payment_method_url_live @"/payment/production/create_payment_method.php"
//#define register_rider_url  @"/payment/production/register_rider.php"
//#define register_driver_url  @"/payment/production/register_driver.php"
//#define client_token_url  @"/payment/production/create_token.php"
//#define charge_with_method_url @"/payment/production/create_charge_with_method.php"
//#define save_payment_method_url @"/payment/production/create_payment_method.php"



#define RIDE_BOOKED @"RIDE_BOOKED"  //= 0,  done
#define DRIVER_ARRIVED_TO_PICKUP @"DRIVER_ARRIVED_TO_PICKUP" // = 1, done
#define RIDE_STARTED @"RIDE_STARTED" // = 2, done
#define RIDE_ON_HALT @"RIDE_ON_HALT" // = 3,
#define ARRIVED_TO_DESTINATION @"ARRIVED_TO_DESTINATION" // = 4,
#define PAYMENT_COMPLETED @"PAYMENT_COMPLETED" // = 5,
#define RIDE_COMPLETED @"RIDE_COMPLETED" // = 6,
#define RIDE_CANCELED  @"RIDE_CANCELED" // = 10

#define  braintreeMerchantId_sendbox  @"braintreeMerchantId_sandbox"

#endif /* Constant_h */
