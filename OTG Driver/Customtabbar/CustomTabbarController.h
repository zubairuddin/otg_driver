//
//  CustomTabbarController.h
//  tab
//
//  Created by Hiren varu on 31/08/17.
//  Copyright © 2017 Hiren varu. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import "CustomTabbar.h"

@interface CustomTabbarController : UITabBarController
{
    CustomTabbar *viewTabbar;
 }
+ (void)HiddenTabbar:(BOOL)Hidden1;
@end
