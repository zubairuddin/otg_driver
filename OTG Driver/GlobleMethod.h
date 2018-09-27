//
//  GlobleMethod.h
//  Go Glam
//
//  Created by vijay on 02/08/17.
//  Copyright © 2017 vijay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constant.h"
@import AVFoundation;
@import AVKit;
@import UIKit;
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <GooglePlaces/GooglePlaces.h>
#import "ParseHelper.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LocationBaseService.h"
#import "EXPhotoViewer.h"

@interface GlobleMethod : NSObject{
    
}
+ (void)viewshadowandCornarRediation:(UIView *)view Rediation:(float)Rediation;
+ (void)setCornerRadious:(UIView *)view Rediation:(float)Rediation;
+ (void)CornarRediationset:(UIView *)view Color: (UIColor*)Color Rediation:(float)Rediation;
+(void)showAlert:(UIViewController *)vc andMessage:(NSString *)str;
+(void)showAlertWithOkCancel:(UIViewController *)vc
                  andMessage:(NSString *)str
               okButtonTitle:(NSString *)okBtnTitle
           cancelButtonTitle:(NSString *)cancelTitle           completion:(void (^)(BOOL success))completionBlock;
//Method for set value in user defaults

+(void)setDictionaryValueInUserDefault:(NSMutableDictionary *)setValue andKey:(NSString *)setKey;
+(NSMutableDictionary *)getDictionaryFromUserDefault:(NSString *)key;

+(void)setArrayValueInUserDefault:(NSMutableArray *)setValue andKey:(NSString *)setKey;
+(NSMutableArray *)getarrayUserDefauld:(NSString *)Key;

+(void)setObjectFromUserDefault:(NSNumber *)setValue andkey:(NSString *)setKey;
+(NSNumber *)getNumberUserDefauld:(NSString *)Key;

+(void)setValueFromUserDefault:(NSString *)setValue andkey:(NSString *)setKey;
+(NSString *)getValueFromUserDefault:(NSString *)key;

+(NSString *)stringWithPointValue:(float)price;

+(void)setBoolValueInUserDefault:(BOOL)setValue andKey:(NSString *)setKey;
+(BOOL)getBoolUserDefauld:(NSString *)Key;

+(void)removeFromUserDefault:(NSString *)key;

+(NSDate *)getFirstDateOfMonthFromCurrnetDate;
+(NSDateComponents *)getFirstDayOfTheCurrentWeekFromCurrentDate;
+(NSDate *)getFirstMontheOfYearFromCurrnetDate;

//+(NSString *)dateToFormatedDate:(NSString *)dateStr;

// Validetion

+ (BOOL)emailValidation:(NSString*)emailAddress;
+ (BOOL)CheckSpace :(NSString *)String;
+(BOOL)validatePhone:(NSString *)phoneNumber;
+(UIView *)E_noDataFound;
+(double)calculateDriverCharges:(double)driverTip totalAmount:(double)totalAmt;
+(double)getAmountFromParseObject:(PFObject *)object;
@end
