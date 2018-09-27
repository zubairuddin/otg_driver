//
//  Driver.m
//  OTG Driver
//
//  Created by Ankur on 09/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "Driver.h"
#import "GlobleMethod.h"

#define M_objectId                      @"objectId"
#define M_is_active                     @"is_active"
#define M_enabledSPB                    @"enableSandboxPaymentBraintree"
#define M_is_verified                   @"is_verified"
#define M_due_amount                    @"due_amount"
#define M_total_earning                 @"total_earning"
#define M_recent_trips                  @"recent_trips"
#define M_email	                        @"email"
#define M_total_earning                 @"total_earning"
#define M_contact                       @"contact"
#define M_name                          @"name"
#define M_lastName                      @"lastName"
#define M_client_token                  @"client_token"
#define M_bt_customerid_live            @"bt_customerid_live"
#define M_bt_customerid_sandbox         @"bt_customerid_sandbox"
#define M_locale_override               @"locale_override"
#define M_car_model                     @"car_model"
#define M_car_registration_number       @"car_registration_number"
#define M_cab_type                      @"cab_type"
#define M_dob                           @"dob"
#define M_dp                            @"dp"
#define M_car_pic                       @"car_pic"
#define M_license                       @"license"
#define M_car_registration_photo        @"car_registration_photo"
#define M_way_bill_photo                @"way_bill_photo"
#define M_merchantid                    @"braintreeMerchantId_sendbox"
#define M_braintreeMerchantId           @"braintreeMerchantId"
#define M_socialSecurityNumber          @"socialSecurityNumber"
#define M_licenseExpiryDate             @"licenseExpiryDate"
#define M_registrationExpiryDate        @"registrationExpiryDate"
#define M_waybillExpiryDate             @"waybillExpiryDate"

@implementation Driver

- (id)init{
    self = [super init];
    return self;
}

- (Driver*)initwithLogineDetaile:(NSMutableDictionary *)dic{
    
    NSLog(@"dic  Profile Details %@",dic);
    
    PFObject *obj = (PFObject*)dic ;
    
    self.objectid  = obj.objectId;
    
    [GlobleMethod setValueFromUserDefault:self.objectid andkey:@"DriverObjId"];
    
    self.isActive = IS_NOT_NULL(dic, M_is_active) ? GET_VALUE_STR(dic, M_is_active) : @"1";
    
    if (IS_NOT_NULL(dic, M_enabledSPB)){
        NSString *temp = [dic valueForKey:M_enabledSPB];
        self.enableSandboxPaymentBraitree = [temp boolValue] == true ?  @"1" : @"0";
        
        NSLog(@"isSendBoxEnabled from Model:--> %@", self.enableSandboxPaymentBraitree);
    }

    if (IS_NOT_NULL(dic, M_is_verified)){
        NSString *temp = [dic valueForKey:M_is_verified];
        self.isVarified = [temp boolValue] == true ? @"1" : @"0";
        NSLog(@"is_verified from Model:--> %@", self.isVarified);
        
        [[NSUserDefaults standardUserDefaults] setBool:[self.isVarified boolValue] forKey:@"isVerified"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    self.due_amount = IS_NOT_NULL(dic, M_due_amount) ? GET_VALUE_STR(dic, M_due_amount) : @"";
    
    self.total_earning = IS_NOT_NULL(dic, M_total_earning) ? GET_VALUE_STR(dic, M_total_earning) : @"";
    
    self.recent_trips = IS_NOT_NULL(dic, M_recent_trips) ? [[dic valueForKey:M_recent_trips] stringValue] : @"";
    
    self.email = IS_NOT_NULL(dic, M_email) ? GET_VALUE_STR(dic,M_email) : @"";
    [GlobleMethod setValueFromUserDefault:self.email andkey:@"DriverEmail"];
    
    self.contact = IS_NOT_NULL(dic, M_contact) ? [dic valueForKey:M_contact] : @"";
    
    self.name = IS_NOT_NULL(dic, M_name) ? GET_VALUE_STR(dic,M_name) : @"";
    
    self.lastName = IS_NOT_NULL(dic, M_lastName) ? GET_VALUE_STR(dic,M_lastName) : @"";
    
    self.clientToken = IS_NOT_NULL(dic, M_client_token) ? GET_VALUE_STR(dic,M_client_token) : @"";
    
    self.bt_CustomerLive = IS_NOT_NULL(dic, M_bt_customerid_live) ? GET_VALUE_STR(dic,M_bt_customerid_live) : @"";
    
    self.bt_CustomerId_sd = IS_NOT_NULL(dic, M_bt_customerid_sandbox) ? GET_VALUE_STR(dic,M_bt_customerid_sandbox) : @"";
    
    self.locale_overried = IS_NOT_NULL(dic, M_locale_override) ? GET_VALUE_STR(dic,M_locale_override) : @"";
    
    self.carModel = IS_NOT_NULL(dic, M_car_model) ? GET_VALUE_STR(dic,M_car_model) : @"";
    
    self.carRegisterNum = IS_NOT_NULL(dic, M_car_registration_number) ? GET_VALUE_STR(dic,M_car_registration_number) : @"";
    
    self.carType = IS_NOT_NULL(dic, M_cab_type) ? GET_VALUE_STR(dic,M_cab_type) : @"0";
    
    
    self.licenseExpiryDate       = IS_NOT_NULL(dic, M_licenseExpiryDate) ? GET_VALUE_STR(dic,M_licenseExpiryDate) : @"";
    self.registrationExpiryDate  = IS_NOT_NULL(dic, M_registrationExpiryDate) ? GET_VALUE_STR(dic,M_registrationExpiryDate) : @"";
    self.waybillExpiryDate       = IS_NOT_NULL(dic, M_waybillExpiryDate) ? GET_VALUE_STR(dic,M_waybillExpiryDate) : @"";
    
    
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM-dd-YYYY"];
    
    if (IS_NOT_NULL(dic, M_dob)) {
        self.Dob  = GET_VALUE_STR(dic, M_dob);
        NSString *strdate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:self.Dob]];
        self.Dob = strdate;//[formatter dateFromString:strdate];
    }
    
    if (IS_NOT_NULL(dic, M_licenseExpiryDate)) {
        self.licenseExpiryDate  = GET_VALUE_STR(dic, M_licenseExpiryDate);
        NSString *strdate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:self.licenseExpiryDate]];
        self.licenseExpiryDate = strdate;//[formatter dateFromString:strdate];
        self.strLicenseExpiryDate = strdate;
    }
    
    if (IS_NOT_NULL(dic, M_registrationExpiryDate)) {
        self.registrationExpiryDate  = GET_VALUE_STR(dic, M_registrationExpiryDate);
        NSString *strdate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:self.registrationExpiryDate]];
        self.registrationExpiryDate = strdate;//[formatter dateFromString:strdate];
        self.strRegistrationExpiryDate = strdate;
    }
    
    if (IS_NOT_NULL(dic, M_waybillExpiryDate)) {
        self.waybillExpiryDate  = GET_VALUE_STR(dic, M_waybillExpiryDate);
        NSString *strdate=[NSString stringWithFormat:@"%@",[formatter stringFromDate:self.waybillExpiryDate]];
        self.waybillExpiryDate = strdate;//[formatter dateFromString:strdate];
        self.strWaybillExpiryDate = strdate;
    }
    
    if (IS_NOT_NULL(dic, M_dp)) {
        PFFile *image = [dic objectForKey:M_dp];
        self.imageURL = image.url;
    }
    
    if (IS_NOT_NULL(dic, M_car_pic)) {
        PFFile *image = [dic objectForKey:M_car_pic];
        self.carURL = image.url;
    }
    
    if (IS_NOT_NULL(dic, M_license)) {
        PFFile *image = [dic objectForKey:M_license];
        self.licenseURL = image.url;
    }
    
    if (IS_NOT_NULL(dic, M_car_registration_photo)) {
        PFFile *image = [dic objectForKey:M_car_registration_photo];
        self.carRegistainURL = image.url;
    }
    
    if (IS_NOT_NULL(dic, M_way_bill_photo)) {
        PFFile *image = [dic objectForKey:M_way_bill_photo];
        self.liability = image.url;
    }
    
    if (IS_NOT_NULL(dic, M_socialSecurityNumber)) {
        self.socialSecurityNumber = GET_VALUE_STR(dic,M_socialSecurityNumber);
    }
    
    if ([self.enableSandboxPaymentBraitree boolValue]) {
        self.merchantid = GET_VALUE_STR(dic, braintreeMerchantId_sendbox);
    }else{
        self.merchantid = GET_VALUE_STR(dic, @"braintreeMerchantId");
    }
    return self;
}

-(NSDate*)convertUTCtoLocale:(NSString*)strDate{
    // create dateFormatter with UTC time format
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss 'T'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDate *date = [dateFormatter dateFromString:strDate]; // create date from string
    
    // change to a readable time format and change to local time zone
    [dateFormatter setDateFormat:@"MMM-dd-yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *tempDate = [dateFormatter stringFromDate:date];
    NSDate *newDate = [dateFormatter dateFromString:tempDate]; // create date from string
    
    return newDate;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc

    [encoder encodeObject:self.objectid forKey:M_objectId];
    [encoder encodeObject:self.isActive forKey:M_is_active];
    [encoder encodeObject:self.enableSandboxPaymentBraitree forKey:M_enabledSPB];
    [encoder encodeObject:self.isVarified forKey:M_is_verified];
    [encoder encodeObject:self.due_amount forKey:M_due_amount];
    [encoder encodeObject:self.total_earning forKey:M_total_earning];
    [encoder encodeObject:self.recent_trips forKey:M_recent_trips];
    [encoder encodeObject:self.email forKey:M_email];
    [encoder encodeObject:self.total_earning forKey:M_total_earning];
    [encoder encodeObject:self.contact forKey:M_contact];
    [encoder encodeObject:self.name forKey:M_name];
    [encoder encodeObject:self.lastName forKey:M_lastName];
    [encoder encodeObject:self.clientToken forKey:M_client_token];
    [encoder encodeObject:self.bt_CustomerLive forKey:M_bt_customerid_live];
    [encoder encodeObject:self.bt_CustomerId_sd forKey:M_bt_customerid_sandbox];
    [encoder encodeObject:self.locale_overried forKey:M_locale_override];
    [encoder encodeObject:self.carModel forKey:M_car_model];
    [encoder encodeObject:self.carRegisterNum forKey:M_car_registration_number];
    [encoder encodeObject:self.carType forKey:M_cab_type];
    [encoder encodeObject:self.Dob forKey:M_dob];
    [encoder encodeObject:self.imageURL forKey:M_dp];
    [encoder encodeObject:self.carURL forKey:M_car_pic];
    [encoder encodeObject:self.licenseURL forKey:M_license];
    [encoder encodeObject:self.carRegistainURL forKey:M_car_registration_photo];
    [encoder encodeObject:self.liability forKey:M_way_bill_photo];
    [encoder encodeObject:self.merchantid forKey:M_merchantid];
    [encoder encodeObject:self.socialSecurityNumber forKey:M_socialSecurityNumber];
    [encoder encodeObject:self.licenseExpiryDate        forKey:M_licenseExpiryDate];
    [encoder encodeObject:self.strLicenseExpiryDate        forKey:M_licenseExpiryDate];
    [encoder encodeObject:self.registrationExpiryDate   forKey:M_registrationExpiryDate];
    [encoder encodeObject:self.strRegistrationExpiryDate   forKey:M_registrationExpiryDate];
    [encoder encodeObject:self.waybillExpiryDate        forKey:M_waybillExpiryDate];
    [encoder encodeObject:self.strWaybillExpiryDate        forKey:M_waybillExpiryDate];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if((self = [super init]))
    {
        //decode properties, other class vars
        self.socialSecurityNumber   = [decoder decodeObjectForKey:M_socialSecurityNumber];
        self.objectid               = [decoder decodeObjectForKey:M_objectId];
        self.contact                = [decoder decodeObjectForKey:M_contact];
        self.name                   = [decoder decodeObjectForKey:M_name];
        self.email                  = [decoder decodeObjectForKey:M_email];
        self.lastName               = [decoder decodeObjectForKey:M_lastName];
        self.clientToken            = [decoder decodeObjectForKey:M_client_token];
        self.bt_CustomerLive        = [decoder decodeObjectForKey:M_bt_customerid_live];
        self.bt_CustomerId_sd       = [decoder decodeObjectForKey:M_bt_customerid_sandbox];
        self.locale_overried        = [decoder decodeObjectForKey:M_locale_override];
        self.carModel               = [decoder decodeObjectForKey:M_car_model];
        self.carRegisterNum         = [decoder decodeObjectForKey:M_car_registration_number];
        self.due_amount             = [decoder decodeObjectForKey:M_due_amount];
        self.total_earning          = [decoder decodeObjectForKey:M_total_earning];
        self.recent_trips           = [decoder decodeObjectForKey:M_recent_trips];
        self.carType                = [decoder decodeObjectForKey:M_cab_type];
        self.enableSandboxPaymentBraitree   = [decoder decodeObjectForKey:M_enabledSPB];
        self.merchantid             = [decoder decodeObjectForKey:M_merchantid];
        self.imageURL               = [decoder decodeObjectForKey:M_dp];
        self.carURL                 = [decoder decodeObjectForKey:M_car_pic];
        self.carRegistainURL        = [decoder decodeObjectForKey:
                                       M_car_registration_photo];
        self.licenseURL             = [decoder decodeObjectForKey:M_license];
        self.liability              = [decoder decodeObjectForKey:M_way_bill_photo];
        self.Dob                    = [decoder decodeObjectForKey:M_dob];
        
        self.licenseExpiryDate      = [decoder decodeObjectForKey:M_licenseExpiryDate];
        self.registrationExpiryDate = [decoder decodeObjectForKey:M_registrationExpiryDate];
        self.waybillExpiryDate      = [decoder decodeObjectForKey:M_waybillExpiryDate];
        
        self.strLicenseExpiryDate      = [decoder decodeObjectForKey:M_licenseExpiryDate];
        self.strRegistrationExpiryDate = [decoder decodeObjectForKey:M_registrationExpiryDate];
        self.strWaybillExpiryDate      = [decoder decodeObjectForKey:M_waybillExpiryDate];
        
        self.isActive               = [decoder decodeObjectForKey:M_is_active];
        self.isVarified             = [decoder decodeObjectForKey:M_is_verified];
    }
    return self;
}


@end

