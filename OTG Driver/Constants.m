//
//  Constants.m
//  BaseCode
//
//  Created by Mac33 on 30/09/15.
//  Copyright © 2015 E2logy. All rights reserved.
//

#import "Constants.h"
#import "NSData+AES.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"


NSString *CompanyId;
NSString *condoId;
NSString *user_unit_id;
NSString *Ext_condoId;
bool      ext_remeber_me;
NSString *kCondoID;
NSString *Ext_Staging;
NSString *Ext_unread_badge_count;

@implementation Constants

NSString *E_Encoded(NSString *plainText)
{
    NSData *cipherData;
    cipherData = [[plainText dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:encription_key];
    NSString* base64Text = [cipherData base64EncodedString];
    cipherData = nil;
    NSLog(@"decode %@", base64Text);
    return base64Text;
}

NSString *E_Decoded(NSString *base64Text)
{
     NSData *cipherData;
    cipherData = [base64Text base64DecodedData];
    NSString * plainText  = [[NSString alloc] initWithData:[cipherData AES256DecryptWithKey:encription_key] encoding:NSUTF8StringEncoding];
    cipherData = nil;
    NSLog(@"Plain text : %@",plainText);
    return plainText;
}

+(NSMutableDictionary*)GetImageDicWithObj:(UIImage*)img withSelectedID:(NSString*)strID{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:img,kImageObj,strID,kImageID, nil];
}
@end
