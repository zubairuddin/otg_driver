/*
 //  BaseCode
 //
 //  Created by Mac33 on 30/09/15.
 //  Copyright © 2015 E2logy. All rights reserved.

 AES256 EnCrypt / DeCrypt
*/
#import "NSData+Base64.h"

@interface NSData (AESTest)
- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;
@end