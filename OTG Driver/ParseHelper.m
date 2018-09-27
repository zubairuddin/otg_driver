//
//  ParseHelper.m
//  Ride OTG
//
//  Created by Ankur on 15/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "ParseHelper.h"
#import "Reachability.h"
#import "GlobleMethod.h"
#import "UserDetailsModal.h"

@implementation ParseHelper

- (id)init{
    self =[super init];
    return self;
}

+ (void)signInAccountWithUserName:(NSString *)userName password:(NSString *)password completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    if ([self returnInternetConnectionStatus] == TRUE) {
        PFQuery *query = [PFQuery queryWithClassName:@"Driver"];
        [query  whereKey:@"email" equalTo:userName];
        
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (!error) {
                if(IS_NOT_NULL(object, @"password")){
                    NSString *Result =[self PasswordDecoding:[object valueForKey:@"password"]];
                    if ([Result isEqualToString:password]) {
                        completionBlock (object ,nil);
                    }else{
                        completionBlock(nil , ErrorWrongEmailPswd);
                    }
                }else{
                    completionBlock(nil ,@"You have previously signed in using Google or Facebook");
                }
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
                NSString *errCode = [[[error userInfo] valueForKey:@"code"] stringValue];
                if ([errCode isEqualToString:@"101"]){
                    completionBlock(nil ,ErrorWrongEmailPswd);
                }else{
                    completionBlock(nil ,ErrorMessage);
                }
                
            }
            
        }];
        
    }else{
        completionBlock(nil,@"No network");
    }
}

+(void)getUserData:(void (^)(NSArray*  obje , NSError *error))completionBlock{
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *query =[PFQuery queryWithClassName:@"Driver"];
    [query getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        
        if (object && error == nil) {
            completionBlock(object,nil);
        }else{
            completionBlock(nil,ErrorMessage);
        }
    }];
}

+(void)checkSocialAvilable:(NSString *)strSocialID completion:(void (^)(PFObject *, NSError *))completionBlock {
    if ([self returnInternetConnectionStatus] == TRUE) {
        PFQuery *query =[PFQuery queryWithClassName:@"Driver"];
        [query whereKey:@"auth_id" equalTo:strSocialID];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (!error) {
                completionBlock(object, nil);
            } else {
                completionBlock(nil,[error userInfo]);
            }
        }];
    }else{
        completionBlock(nil,@"No Internet Connection");
    }
}

+ (void)registerForSocialQuery:(NSMutableDictionary *)dictRequestData completion:(void (^)(PFObject *, NSError *))completionBlock{
    
    //REGISTER USER
    PFObject *appUser           = [PFObject objectWithClassName:@"Driver"];
    appUser[@"email"]           = dictRequestData[@"email"];
    appUser[@"name"]            = dictRequestData[@"first_name"];
    appUser[@"lastName"]        = dictRequestData[@"last_name"];
    appUser[@"contact"]         = dictRequestData[@"phone"];
    appUser[@"is_verified"]     = @YES;
    appUser[@"is_active"]       = @YES;
    appUser[@"dp_url"]          = dictRequestData[@"url"];
    appUser[@"ratings_value"]   = @0;
    appUser[@"ratings_count"]   = @0;
    appUser[@"is_test_acc"]     = @NO;
    appUser[@"auth_platform"]   = dictRequestData[@"from"];
    appUser[@"auth_id"]         = dictRequestData[@"id"];
    
    [appUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error  && succeeded) {
            NSLog(@"Registr succeeded");
            completionBlock(appUser, nil);
        }else{
            NSLog(@"Error: %@ %@", error, [error userInfo]);
            completionBlock(nil, [error userInfo]);
            //completionBlock(nil, ErrorMessage);
        }
    }];
}


+(void)registerQuery:(NSString*)name LastName:(NSString*)LastName Email:(NSString*)Email Contact:(NSString*)Contact Password:(NSString*)Password ProfileDp:(UIImage*)ProfileDp completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    if ([self returnInternetConnectionStatus] == TRUE) {
        PFQuery *query =[PFQuery queryWithClassName:@"Driver"];
        [query whereKey:@"email" equalTo:Email];
        [query countObjectsInBackgroundWithBlock:^(int number, NSError * _Nullable error) {
            if (number == 0) {
                
                NSData* data = UIImageJPEGRepresentation(ProfileDp, 0.5f);
                PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
                
                PFObject *appUser = [PFObject objectWithClassName:@"Driver"];
                NSMutableArray *arrayinterests =[[NSMutableArray alloc]init];
                NSString *base64Password = [self PasswordEncoding:Password];
                
                appUser[@"lastName"] = LastName ;
                appUser[@"name"] = name;
                appUser[@"email"] = Email;
                appUser[@"password"] = base64Password;
                appUser[@"contact"] = Contact;
                appUser[@"dp"] = imageFile;
                appUser[@"is_active"] = [NSNumber numberWithBool:NO];
                appUser[@"is_verified"] = [NSNumber numberWithBool:NO];
                
                [appUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (!error  && succeeded) {
                        NSLog(@"Registr succeeded");
                        completionBlock(appUser, error);
                    }
                }];
            }else{
                error = @"The email address you have entered is already registered";
                completionBlock(nil,error);
            }
        }];
        
    }else{
        completionBlock(nil,@"No network");
    }
}

+(void)getFAQData:(void (^)(NSArray*  obje , NSError *error))completionBlock{
    
    PFQuery *query =[PFQuery queryWithClassName:@"FAQ"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects && error == nil) {
            NSLog(@"objects  %@",objects);
            completionBlock(objects,nil);
        }else{
            completionBlock(nil,ErrorMessage);
        }
    }];
}

+(void)getPrivetionRideData:(void (^)(NSArray*  obje , NSError *error))completionBlock {
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFObject *currentDriverObject = [PFObject objectWithoutDataWithClassName:@"Driver" objectId:driverObjID];
    PFQuery *query =[PFQuery queryWithClassName:@"Ride"];
    [query includeKey:@"rider"];
    [query whereKey:@"driver" equalTo: currentDriverObject];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            completionBlock(objects,nil);
        } else {
            completionBlock(nil,ErrorMessage);
        }
    }];
}

+(void)getLicenseData:(void (^)(NSArray*  obje , NSError *error))completionBlock{
    
    PFQuery *query =[PFQuery queryWithClassName:@"License"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects && error == nil) {
            NSLog(@"objects  %@",objects);
            completionBlock(objects,nil);
        }else{
            completionBlock(nil,ErrorMessage);
        }
    }];
}

+(void)getSubmitRatinginPrivetionRideData:(NSNumber*)rating rideID:(NSString *)strRideObj drivreID:(NSString *)strDriverObj comment:(NSString *)strComment completionBlock:(void (^)(BOOL succeeded, NSError * _Nullable error))completionBlock {
    
    PFObject *rideUser = [PFObject objectWithoutDataWithClassName:@"Ride" objectId:strRideObj];
    [rideUser setObject:rating forKey:@"rating_overall_driver"];
    [rideUser setObject:strComment forKey:@"reviewText"];
    PFObject *driverUser = [PFObject objectWithoutDataWithClassName:@"Driver" objectId:strDriverObj];
    [driverUser incrementKey:@"ratings_count" byAmount:[NSNumber numberWithFloat: 1.0]];
    [driverUser incrementKey:@"ratings_value" byAmount:[NSNumber numberWithFloat:[rating floatValue]]];
    NSMutableArray *arrClass = [[NSMutableArray alloc] init];
    [arrClass addObject:rideUser];
    [arrClass addObject:driverUser];
    [PFObject saveAllInBackground:arrClass block:^(BOOL succeeded, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@",error.localizedDescription);
            completionBlock(nil, error);
        } else {
            completionBlock(succeeded, nil);
            NSLog(@"SUCCESS %d",succeeded);
        }
    }];
    /*
     PFQuery *appUser = [PFQuery queryWithClassName:@"Ride"];
     [appUser getObjectInBackgroundWithId:objectid block:^(PFObject * _Nullable object, NSError * _Nullable error) {
     if (!error && object) {
     object[@"rating_overall_driver"] = rating;
     [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
     if (!error  && succeeded) {
     completionBlock(object , nil);
     }else{
     completionBlock(nil , ErrorMessage);
     }
     }];
     }
     }];*/
}

+(void)getCarTypeCompletion:(void (^)(NSArray*  obje , NSError *error))completionBlock{
    
    if ([self returnInternetConnectionStatus] == TRUE) {
        PFQuery *query = [PFQuery queryWithClassName:@"CabType"];
        [query orderByAscending:@"carPic"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (objects != nil) {
                NSLog(@"***** CabType  **** %@ ",objects);
                NSMutableArray *arrobject =[objects mutableCopy];
                completionBlock(arrobject ,nil);
            }
        }];
    }else{
        
    }
}

+(void)EditProfile:(NSString *)FName LastName:(NSString *)LastName Email:(NSString*)Email Contact:(NSString *)Contact ProfileImage:(UIImageView*)ProfileImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock {
    
    NSData* data = UIImageJPEGRepresentation(ProfileImage.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
    [appUser getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error && object) {
            object[@"contact"] = Contact;
            object[@"email"] = Email;
            object[@"name"] = FName;
            object[@"lastName"] = LastName;
            object[@"dp"] = imageFile;
            
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error  && succeeded) {
                    
                    NSLog(@"Edit Profile Success full");
                    completionBlock(object , error);
                }else{
                    completionBlock(object , ErrorMessage);
                }
            }];
        }
    }];
}

+(void)CompletProfile:(NSString *)Name Contact:(NSString *)Contact DOB:(NSDate *)DOB Male:(NSString *)Male CarModel:(NSString *)CarModel SSNO:(NSString *)SSN LicenseExpDate:(NSDate *)licenseExpiryDate RegExpDate:(NSDate *)registrationExpiryDate WayBillExpDate:(NSDate *)waybillExpiryDate CarRegistration:(NSString *)CarRegistration ProfileImage:(UIImageView*)ProfileImage CarImage:(UIImageView*)CarImage LicenseImage:(UIImageView*)LicenseImage CarRegistrationImage:(UIImageView*)CarRegistrationImage  LiablityImage:(UIImageView*)LiablityImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    if ([self returnInternetConnectionStatus] == TRUE) {
        NSNumber *maleOrFemale;
        if ([Male isEqualToString:@"Male"]) {
            maleOrFemale = [NSNumber numberWithInt:1];
        }else{
            maleOrFemale = [NSNumber numberWithInt:0];
        }
        
        NSData* data = UIImageJPEGRepresentation(ProfileImage.image, 0.5f);
        PFFile *DpimageFile = [PFFile fileWithName:@"Image.jpg" data:data];
        
        NSData* data1 = UIImageJPEGRepresentation(CarImage.image, 0.5f);
        PFFile *CarImageFile = [PFFile fileWithName:@"Image1.jpg" data:data1];
        
        NSData* data2 = UIImageJPEGRepresentation(LicenseImage.image, 0.5f);
        PFFile *LicenseImageFile = [PFFile fileWithName:@"Image2.jpg" data:data2];
        
        NSData* data3 = UIImageJPEGRepresentation(CarRegistrationImage.image, 0.5f);
        PFFile *CarRegistrationImageFile = [PFFile fileWithName:@"Image2.jpg" data:data3];
        
        
        NSData* data4 = UIImageJPEGRepresentation(LiablityImage.image, 0.5f);
        PFFile *LiablityImageFile = [PFFile fileWithName:@"Image3.jpg" data:data4];
        
        NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
        
        PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
        [appUser getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (!error && object) {
                object[@"name"] = Name;
                object[@"contact"] = Contact;
                //  object[@"dob"] = DOB;
                object[@"gender"]                   = maleOrFemale;
                object[@"car_registration_number"]  = CarRegistration;
                object[@"car_model"]                = CarModel;
                object[@"socialSecurityNumber"]     = SSN;
                object[@"dp"]                       = DpimageFile;
                object[@"car_pic"]                  = CarImageFile;
                object[@"license"]                  = LicenseImageFile;
                object[@"car_registration_photo"]   = CarRegistrationImageFile;
                object[@"way_bill_photo"]           = LiablityImageFile;
                object[@"applied_for_verification"] = [NSNumber numberWithBool:YES];
                object[@"licenseExpiryDate"]        = licenseExpiryDate;
                object[@"registrationExpiryDate"]   = registrationExpiryDate;
                object[@"waybillExpiryDate"]        = waybillExpiryDate;

                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (!error  && succeeded) {
                        NSLog(@"Complet Profile Success full");
                        
                        completionBlock(object , nil);
                    }else{
                        completionBlock(object , ErrorMessage);
                    }
                }];
            }
        }];
        
    }else{
        completionBlock(nil,@"No network");
    }
}

+(void)EditProfile:(NSString *)FName LastName:(NSString *)LastName Email:(NSString*)Email SSN:(NSString*)SSN Contact:(NSString *)Contact DOB:(NSDate *)DOB ProfileImage:(UIImageView*)ProfileImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    NSData* data = UIImageJPEGRepresentation(ProfileImage.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
    [appUser getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error && object) {
            object[@"contact"]  = Contact;
            object[@"email"]    = Email;
            object[@"name"]     = FName;
            object[@"lastName"] = LastName;
            object[@"dp"]       = imageFile;
            object[@"dob"]      = DOB;
            object[@"socialSecurityNumber"] = SSN;
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error  && succeeded) {
                    
                    NSLog(@"Edit Profile Success full");
                    completionBlock(object , error);
                }else{
                    completionBlock(object , ErrorMessage);
                }
            }];
        }else{
            completionBlock(object , ErrorMessage);
        }
    }];
}

+(void)CarEditProfile:(NSString *)Model Type:(NSString *)Type CarRigisterNumber:(NSString*)CarRigisterNumber CarImage:(UIImageView*)CarImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    NSData* data = UIImageJPEGRepresentation(CarImage.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image2.jpg" data:data];
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
    [appUser getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error && object) {
            object[@"car_model"] = Model;
            object[@"car_registration_number"] = CarRigisterNumber;
            object[@"cab_type"] = [NSNumber numberWithInt:[Type intValue]];
            object[@"car_pic"] = imageFile;
            
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error  && succeeded) {
                    NSLog(@"CarEdit Profile Success full");
                    completionBlock(object , error);
                }else{
                    completionBlock(object , ErrorMessage);
                }
            }];
        }
    }];
}
+(void)EditLiability:(UIImageView*)LiabilityImage completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    NSData* data = UIImageJPEGRepresentation(LiabilityImage.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image2.jpg" data:data];
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
    [appUser getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error && object) {
            object[@"way_bill_photo"] = imageFile;
            object[@"applied_for_verification"]= [NSNumber numberWithBool:YES];
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error  && succeeded) {
                    NSLog(@"CarEdit Profile Success full");
                    completionBlock(object , error);
                }else{
                    completionBlock(object , ErrorMessage);
                }
            }];
        }
    }];
}

+(void)EditLicensens:(UIImageView*)Licensens completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    NSData* data = UIImageJPEGRepresentation(Licensens.image, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image2.jpg" data:data];
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
    [appUser getObjectInBackgroundWithId:driverObjID block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error && object) {
            object[@"license"] = imageFile;
            object[@"applied_for_verification"]= [NSNumber numberWithBool:YES];

            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error  && succeeded) {
                    NSLog(@"CarEdit Profile Success full");
                    completionBlock(object , error);
                }else{
                    completionBlock(object , ErrorMessage);
                }
            }];
        }
    }];
}

+(void)saveBraintreeMerchentid:(NSString *)Merchentid isBraintreeEnabled:(BOOL)isEnabled completion:(void (^)(PFObject*  obje , NSError *error))completionBlock {
    
    NSString *driverObjID = [GlobleMethod getValueFromUserDefault:@"DriverObjId"];
    
    PFQuery *appUser = [PFQuery queryWithClassName:@"Driver"];
    [appUser getObjectInBackgroundWithId:kUserDetails.objDriverM.objectid block:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (!error && object) {
            if(isEnabled){
                object[save_Merchanid] = Merchentid;
            }else{
                object[@"braintreeMerchantId"] = Merchentid;
            }
            
            [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (!error  && succeeded) {
                    completionBlock(object , nil);
                }else{
                    completionBlock(object , ErrorMessage);
                }
            }];
        }
    }];
}
+(BOOL)returnInternetConnectionStatus{
    
    Reachability *curReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    
    if ((netStatus != NotReachable)) {
        return TRUE;
    } else {
        return FALSE;
    }
}
+(NSString *)PasswordEncoding:(NSString *)Password{
    
    // Password Coding
    NSMutableArray *strResult1 = [[NSMutableArray alloc]init];
    
    for (NSUInteger i = 0; i < [Password length]; i++) {
        int asciiCode = [Password characterAtIndex:i];
        NSLog(@"ask  %d",asciiCode);
        [strResult1 addObject:[NSNumber numberWithInteger:asciiCode]];
    }
    NSLog(@"strResult1  %@",strResult1);
    
    NSString *str2 = @"some-secret-key-of-your-choice";
    NSMutableArray *strResult2 = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [str2 length]; i++) {
        int asciiCode = [str2 characterAtIndex:i];
        [strResult2 addObject:[NSNumber numberWithInteger:asciiCode]];
    }
    NSLog(@"strResult2  %@",strResult2);
    
    
    NSMutableString *strResult = [[NSMutableString alloc]init];
    for (int i = 0; i < strResult1.count ; i++) {
        int a = [[strResult1 objectAtIndex:i] intValue];
        int b = [[strResult2 objectAtIndex:i] intValue];
        
        int final = a ^ b;
        
        NSLog(@"final  %d",final);
        [strResult appendString:[NSString stringWithFormat:@"%c",final]];
        
    }
    NSLog(@"strResult  %@",strResult);
    
    NSData *basicAuthCredentials = [[NSString stringWithFormat:@"%@", strResult] dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Password = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
    return base64Password;
}
+(NSString *)PasswordDecoding:(NSString *)Password{
    
    NSString *str2 = @"some-secret-key-of-your-choice";
    NSMutableArray *strResult2 = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [str2 length]; i++) {
        int asciiCode2 = [str2 characterAtIndex:i];
        NSLog(@"asciiCode2 %d",asciiCode2);
        [strResult2 addObject:[NSNumber numberWithInteger:asciiCode2]];
    }
    
    NSData *nsdataFromBase64String = [[NSData alloc]
                                      initWithBase64EncodedString:Password options:0];
    
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
    
    NSLog(@"base64Decoded  %@",base64Decoded);
    
    NSMutableArray *strResult1 = [[NSMutableArray alloc]init];
    
    for (NSUInteger i = 0; i < [base64Decoded length]; i++) {
        int asciiCode = [base64Decoded characterAtIndex:i];
        NSLog(@"asciiCode1  %d",asciiCode);
        [strResult1 addObject:[NSNumber numberWithInteger:asciiCode]];
    }
    
    NSLog(@"strDeresulte  %@",strResult1);
    
    NSMutableString *Result = [NSMutableString new];
    
    for (int i = 0; i < strResult1.count ; i++) {
        
        int a = [[strResult1 objectAtIndex:i] intValue];
        int b = [[strResult2 objectAtIndex:i] intValue];
        
        int Xor = a ^ b;
        //        NSLog(@"Xor  %d",Xor);
        [Result appendString:[NSString stringWithFormat:@"%c",Xor]];
        
    }
    NSLog(@"Result  %@",Result);
    return Result;
}

+(void)creatRide:(NSMutableDictionary*)dic completion:(void (^)(PFObject*  obje , NSError *error))completionBlock {
    
    PFObject *ride = [PFObject objectWithClassName:@"Ride"];
    if ([dic valueForKey:@"drop_title"]) {
        ride[@"drop_title"] = [dic valueForKey:@"drop_title"];
    }
    if ([dic valueForKey:@"ride_firebase_id"]) {
        ride[@"ride_firebase_id"] = [dic valueForKey:@"ride_firebase_id"];
    }
    if ([dic valueForKey:@"ride_firebase_id"]) {
        ride[@"ride_firebase_id"] = [dic valueForKey:@"ride_firebase_id"];
    }
    if ([dic valueForKey:@"status"]) {
        ride[@"status"] = [NSNumber numberWithInt:0];
    }
    if ([dic valueForKey:@"pickup_title"]) {
        ride[@"pickup_title"] = [dic valueForKey:@"pickup_title"];
    }
    
    [ride saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (!error  && succeeded) {
            NSLog(@"Ride add succeeded");
            completionBlock(ride, nil);
        }else{
            completionBlock(nil, ErrorMessage);
        }
    }];
}

+(void)forgotPawword:(NSString *)NewPassword email:(NSString *)email completion:(void (^)(PFObject*  obje , NSError *error))completionBlock{
    
    if ([self returnInternetConnectionStatus] == TRUE) {
        PFQuery *query = [PFQuery queryWithClassName:@"Driver"];
        [query  whereKey:@"email" equalTo:email];
        
        [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
            if (!error  && object) {
                NSString *base64Password = [self PasswordEncoding:NewPassword];
                object[@"password"] = base64Password;
                [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (!error  && succeeded) {
                        NSLog(@"forgot Pawword Success full %@",object);
                        completionBlock(object , error);
                    }else{
                        completionBlock(nil , ErrorMessage);
                    }
                }];
            }
        }];
    }else{
        completionBlock(nil,@"No Internet Connection");
    }
}


+(void)ratingSubmint:(NSMutableDictionary*)dic completion:(void (^)(NSArray*  obje , NSError *error))completionBlock {
    
//    NSString *objectid = [dic valueForKey:@"Parse_obj_Firebase"];
    NSString *objectid = [dic valueForKey:@"prase_object_id"];
    
    int rating =  [[dic valueForKey:@"rating_overall_rider"] intValue];
    NSLog(@"rating  %d",rating);
    PFQuery *query = [PFQuery queryWithClassName:@"Ride"];
    [query  getObjectInBackgroundWithId:objectid block:^(PFObject * _Nullable ride, NSError * _Nullable error) {
        ride[@"rating_overall_rider"] = [NSNumber numberWithInt:rating];
        [ride saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (!error  && succeeded) {
                NSLog(@"rating submit succeeded");
                completionBlock(ride, nil);
            }else{
                completionBlock(nil, ErrorMessage);
            }
        }];
    }];
}

@end
