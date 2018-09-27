//
//  ParseHelper.h
//  Ride OTG
//
//  Created by Ankur on 15/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ParseHelper : NSObject
+ (void)signInAccountWithUserName:(NSString *)userName password:(NSString *)password completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)getUserData:(void (^)(NSArray*  obje , NSError *error))completionBlock;

+(void)registerForSocialQuery:(NSMutableDictionary *)dictRequestData completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)checkSocialAvilable:(NSString *)strSocialID completion:(void (^)(PFObject *, NSError *))completionBlock;

+(void)registerQuery:(NSString*)name LastName:(NSString*)LastName Email:(NSString*)Email Contact:(NSString*)Contact Password:(NSString*)Password ProfileDp:(UIImage*)ProfileDp completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)EditProfile:(NSString *)FName LastName:(NSString *)LastName Email:(NSString*)Email Contact:(NSString *)Contact ProfileImage:(UIImageView*)ProfileImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;


+(void)CompletProfile:(NSString *)Name Contact:(NSString *)Contact DOB:(NSDate *)DOB Male:(NSString *)Male CarModel:(NSString *)CarModel SSNO:(NSString *)SSN LicenseExpDate:(NSDate *)licenseExpiryDate RegExpDate:(NSDate *)registrationExpiryDate WayBillExpDate:(NSDate *)waybillExpiryDate CarRegistration:(NSString *)CarRegistration ProfileImage:(UIImageView*)ProfileImage CarImage:(UIImageView*)CarImage LicenseImage:(UIImageView*)LicenseImage CarRegistrationImage:(UIImageView*)CarRegistrationImage  LiablityImage:(UIImageView*)LiablityImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)CarEditProfile:(NSString *)Model Type:(NSString *)Type CarRigisterNumber:(NSString*)CarRigisterNumber CarImage:(UIImageView*)CarImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)EditProfile:(NSString *)FName LastName:(NSString *)LastName Email:(NSString*)Email SSN:(NSString*)SSN Contact:(NSString *)Contact DOB:(NSDate *)DOB ProfileImage:(UIImageView*)ProfileImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)getFAQData:(void (^)(NSArray*  obje , NSError *error))completionBlock;

+(void)getPrivetionRideData:(void (^)(NSArray*  obje , NSError *error))completionBlock;

+(void)getCarTypeCompletion:(void (^)(NSArray*  obje , NSError *error))completionBlock;

+(void)getLicenseData:(void (^)(NSArray*  obje , NSError *error))completionBlock;

+(void)getSubmitRatinginPrivetionRideData:(NSNumber*)rating rideID:(NSString *)strRideObj drivreID:(NSString *)strDriverObj comment:(NSString *)strComment completionBlock:(void (^)(BOOL succeeded, NSError * _Nullable error))completionBlock;

+(void)saveBraintreeMerchentid:(NSString *)Merchentid isBraintreeEnabled:(BOOL)isEnabled completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)EditLiability:(UIImageView*)LiabilityImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)EditLicensens:(UIImageView*)Licensens completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)creatRide:(NSMutableDictionary*)dic completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;

+(void)ratingSubmint:(NSMutableDictionary*)dic completion:(void (^)(NSArray*  obje , NSError *error))completionBlock;

+(void)forgotPawword:(NSString *)NewPassword email:(NSString *)email completion:(void (^)(PFObject*  obje , NSError *error))completionBlock;
@end
