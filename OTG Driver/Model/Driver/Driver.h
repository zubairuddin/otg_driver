//
//  Driver.h
//  OTG Driver
//
//  Created by Ankur on 09/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Driver : NSObject
@property (nonatomic, strong)NSString *objectid;
@property (nonatomic, strong)NSString *contact;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *email;
@property (nonatomic, strong)NSString *lastName;
@property (nonatomic, strong)NSString *clientToken;
@property (nonatomic, strong)NSString *bt_CustomerId;
@property (nonatomic, strong)NSString *bt_CustomerId_sd;
@property (nonatomic, strong)NSString *bt_CustomerLive;
@property (nonatomic, strong)NSString *lastLocation;
@property (nonatomic, strong)NSString *locale_overried;
@property (nonatomic, strong)NSString *carModel;
@property (nonatomic, strong)NSString *carRegisterNum;
@property (nonatomic, strong)NSString *due_amount;
@property (nonatomic, strong)NSString *total_earning;
@property (nonatomic, strong)NSString *recent_trips;
@property (nonatomic, assign)NSString *carType;
@property (nonatomic, strong)NSString *merchantid;
@property (nonatomic, strong)NSString *socialSecurityNumber;
@property (nonatomic, strong)NSString *imageURL;
@property (nonatomic, strong)NSString *carURL;
@property (nonatomic, strong)NSString *carRegistainURL;
@property (nonatomic, strong)NSString *licenseURL;
@property (nonatomic, strong)NSString *liability;
@property (nonatomic, strong)NSString *strLicenseExpiryDate;
@property (nonatomic, strong)NSString *strRegistrationExpiryDate;
@property (nonatomic, strong)NSString *strWaybillExpiryDate;

@property NSDate                      *Dob;
@property NSDate                      *licenseExpiryDate;
@property NSDate                      *registrationExpiryDate;
@property NSDate                      *waybillExpiryDate;

//@property NSMutableArray *arrayPayment_sd;
//@property NSMutableArray *arrayPaymentLive;
//@property NSMutableArray *arrayPayment_nonces;

@property (nonatomic, assign)NSString *isTest_acc;
@property (nonatomic, assign)NSString *isActive;
@property (nonatomic, assign)NSString *isVarified;
@property (nonatomic, assign)NSString *enableSandboxPaymentBraitree;

-(Driver*)initwithLogineDetaile:(NSMutableDictionary *)dic;

@end
