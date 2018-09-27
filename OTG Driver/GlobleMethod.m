//
//  GlobleMethod.m
//  Go Glam
//
//  Created by vijay on 02/08/17.
//  Copyright © 2017 vijay. All rights reserved.
//

#import "GlobleMethod.h"
#include "Constant.h"

@implementation GlobleMethod


+ (void)viewshadowandCornarRediation:(UIView *)view Rediation:(float)Rediation{
    view.layer.shadowRadius  = 2.0f;
    view.layer.shadowColor   = [UIColor grayColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 0.5f;
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = Rediation;
}

+ (void)setCornerRadious:(UIView *)view Rediation:(float)Rediation {
    view.layer.shadowRadius  = 3.5f;
    view.layer.shadowColor   = [UIColor grayColor].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 1.0f;
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius  = Rediation;
}

+ (void)CornarRediationset:(UIView *)view Color: (UIColor*)Color Rediation:(float)Rediation {
    view.layer.cornerRadius = Rediation;
    view.layer.borderColor =Color.CGColor;
    view.layer.borderWidth = 1;
}

//Method for set value in user defaults

+(void)setValueFromUserDefault:(NSString *)setValue andValue:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setValue:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)setDictionaryValueInUserDefault:(NSMutableDictionary *)setValue andValue:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setValue:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//Method for alert
+(void)showAlert:(UIViewController *)vc andMessage:(NSString *)str {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:str
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * btnOk = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //  UIAlertController will automatically dismiss the view
                             }];
    [alert addAction:btnOk];
    alert.view.tintColor = [UIColor blackColor];
    [vc presentViewController:alert animated:YES completion:nil];
}

+(void)showAlertWithOkCancel:(UIViewController *)vc
                  andMessage:(NSString *)str
               okButtonTitle:(NSString *)okBtnTitle
               cancelButtonTitle:(NSString *)cancelBtnTitle
                  completion:(void (^)(BOOL success))completionBlock{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:nil
                                 message:str
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * btnOk = [UIAlertAction
                             actionWithTitle:okBtnTitle
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //  UIAlertController will automatically dismiss the view
                                 if (completionBlock != nil) completionBlock(YES);
                             }];
    
    UIAlertAction * btnCancel = [UIAlertAction
                             actionWithTitle:cancelBtnTitle
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //  UIAlertController will automatically dismiss the view
                                 if (completionBlock != nil) completionBlock(NO);
                             }];
    
    [alert addAction:btnCancel];
    [alert addAction:btnOk];
    alert.view.tintColor = [UIColor blackColor];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 1. Email Address Validation

+ (BOOL)emailValidation:(NSString*)emailAddress{
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailAddress options:0 range:NSMakeRange(0, [emailAddress length])];
    
    if (regExMatches == 0){
        return NO;
    }
    else{
        return YES;
    }
}
+ (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"[0-9]{10}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}

#pragma mark - 2. Check Blank Splace

+ (BOOL)CheckSpace :(NSString *)String{
    
    NSString *rawString = String;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0)
    {
        return NO;
    }
    else{
        return YES;
    }
}

#pragma mark-  dictionary UserDefauld

+(void)setDictionaryValueInUserDefault:(NSMutableDictionary *)setValue andKey:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setValue:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSMutableDictionary *)getDictionaryFromUserDefault:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]valueForKey:key];
}

#pragma mark-  array UserDefauld

+(void)setArrayValueInUserDefault:(NSMutableArray *)setValue andKey:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setValue:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSMutableArray *)getarrayUserDefauld:(NSString *)Key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:Key];
}

#pragma mark-  Number UserDefauld

+(void)setObjectFromUserDefault:(NSNumber *)setValue andkey:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setObject:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSNumber *)getNumberUserDefauld:(NSString *)Key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:Key];
}

#pragma mark-  String UserDefauld

+(void)setValueFromUserDefault:(NSString *)setValue andkey:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setValue:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getValueFromUserDefault:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults]valueForKey:key];
}

+(NSString *)stringWithPointValue:(float)price {
    return [NSString stringWithFormat:@"$%.2f",price];
}


#pragma mark - Date functions

+(NSDate *)getFirstDateOfMonthFromCurrnetDate{
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDate *arbitraryDate = [NSDate date];
    NSDateComponents *comp = [gregorian components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:arbitraryDate];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:comp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd-MM-yyyy - HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:firstDayOfMonthDate];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSLog(@"%@", firstDayOfMonthDate);
    NSLog(@"%@", dateString);
    NSLog(@"%@", date);
    
    return date;
}

+(NSDate *)getFirstDayOfTheCurrentWeekFromCurrentDate{
    NSDate *arbitraryDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:arbitraryDate];
    NSInteger week = [dateComponent weekOfMonth];
    NSDate *finalDate =  [self firstDayOfWeek:week inMonth:[dateComponent month] inYear:[dateComponent year]];
    NSLog(@"%@", finalDate);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:finalDate];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSLog(@"%@", finalDate);
    NSLog(@"%@", dateString);
    NSLog(@"%@", date);
    
    return date;
}

+(NSDate *)getFirstMontheOfYearFromCurrnetDate{
    NSDate *arbitraryDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:arbitraryDate];
    NSInteger month = [dateComponent month];
    NSDate *finalDate =  [self firstMonthOfYear:month inYear:[dateComponent year]];
    NSLog(@"%@", finalDate);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:finalDate];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSLog(@"%@", finalDate);
    NSLog(@"%@", dateString);
    NSLog(@"%@", date);
    
    return date;
}


+ (NSDate *)firstDayOfWeek:(NSInteger)weekNumber inMonth:(NSInteger)month inYear:(NSInteger)year
{
    NSDateComponents *comps=[[NSDateComponents alloc]init];
    [comps setWeekday:2];                                   //Change this to 2 if you want Monday rather than Sunday
    [comps setWeekOfMonth:weekNumber];
    [comps setMonth:month];
    [comps setYear:year];
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSDate *newDate=[cal dateFromComponents:comps];
    
    return newDate;
}

+ (NSDate *)firstMonthOfYear:(NSInteger)monthNumber inYear:(NSInteger)year
{
    NSDateComponents *comps=[[NSDateComponents alloc]init];
    [comps setMonth:1];
    [comps setYear:year];
    
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSDate *newDate=[cal dateFromComponents:comps];
    
    return newDate;
}

#pragma mark-  Bool UserDefauld

+(void)setBoolValueInUserDefault:(BOOL)setValue andKey:(NSString *)setKey{
    [[NSUserDefaults standardUserDefaults]setBool:setValue forKey:setKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)getBoolUserDefauld:(NSString *)Key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:Key];
}

#pragma mark-  Remove UserDefauld

+(void)removeFromUserDefault:(NSString *)key{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(double)getAmountFromParseObject:(PFObject *)object{
    double amount = 0.0;
    NSString *tempTip = @"0.0";
    
    if(object[@"payment_detail"]){
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[[object valueForKey:@"payment_detail"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        tempTip = [results valueForKey:@"tipAmount"];
        double tip = [tempTip doubleValue];
        
        NSString *tempTotalAmt   = [results valueForKey:@"totalAmount"];
        double totalAmount = [tempTotalAmt doubleValue];
        
        amount = [self calculateDriverCharges:tip totalAmount:totalAmount];
        NSString *strFinalAmount = [NSString stringWithFormat:@"%.2f", amount];
        amount = [strFinalAmount doubleValue];
    }
    return amount;
}

+(double)calculateDriverCharges:(double)driverTip totalAmount:(double)totalAmt{
    double totalAmount = totalAmt * 0.85f;
    return totalAmount + driverTip;
}

+(UIView *)E_noDataFound{
    UIView  *noData = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, [[UIScreen mainScreen] bounds].size.width)];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, noData.frame.size.width/2, [[UIScreen mainScreen] bounds].size.width, 31)];
    lbl.text = @"No Record Found";
    lbl.textAlignment = NSTextAlignmentCenter;
    noData.backgroundColor = [UIColor clearColor];
    
    [noData addSubview:lbl];
    lbl = nil;
    return noData;
}

@end
