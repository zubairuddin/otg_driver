//
//  Constants.h
//  BaseCode
//
//  Created by Mac33 on 30/09/15.
//  Copyright © 2015 E2logy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define kUserDetails [UserDetailsModal sharedUserDetails]

#define CURRENT_USER_ID     @"userID"
#define CURRENT_USER_ROLE   @"userType"

#define kUserKey            @"loggedInUser"
#define kUserState          @"userState"

//#define selectedUnitID      "selectedUnitID"
//#define STR_RecordCount     @"RecordCount"
//#define STR_Email           @"email"
//#define STR_password        @"password"
//
//#define STR_Ext_condoId         @"Ext_condoId"
//#define STR_Ext_condo_unit_id   @"Ext_condo_unit_id"
//#define STR_Ext_condo_userID    @"Ext_condo_userID"
//#define STR_condo_name          @"condo_name"
//#define STR_temp_unit_name          @"unit_name"

typedef NS_ENUM (NSUInteger, USER_STATE)
{
    NOT_LOGGED_IN,
    LOGGED_IN,
};

#define IS_APP_FIRST_START @"IsAppFirstStart"
#define kImageObj @"kImageObj"
#define kImageID @"kImageID"

//-----Navigationbar Title Image Size---------//
#define titleImageWidth  (IS_IPAD || IS_IPHONE_6Plus || IS_IPHONE_6)?160:130
#define titleImageHeight (IS_IPAD || IS_IPHONE_6Plus || IS_IPHONE_6)?30:20
//-------------------------------------------//

//----------------------Application Color------------------//

#define appBackgroundColor [UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0]
#define appBtnBlueColor [UIColor colorWithRed:11.0/255.0 green:64.0/255.0 blue:132.0/255.0 alpha:1.0]
#define appBtnBlueLightColor [UIColor colorWithRed:49.0/255.0 green:131.0/255.0 blue:225.0/255.0 alpha:1.0]

#define appLightGrayColor [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]
#define appOrangeColor RGBCOLORAlpha(236.0,139.0,66.0,1.0)
#define appGrayColor RGBCOLORAlpha(96.0,96.0,96.0,1.0)
#define appLightBlackColor E_ConvertHEXtoRGB(@"#191919")

#define appPlaceholderColor [UIColor colorWithRed:110.0/255.0 green:110.0/255.0 blue:110.0/255.0 alpha:1.0]
#define appGrayTextPlaceHolderColor E_ConvertHEXtoRGB(@"#727272")

#define appGreenColor [UIColor colorWithRed:146.0/255.0 green:221.0/255.0 blue:94.0/255.0 alpha:1.0]
#define appRedColor [UIColor colorWithRed:255.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:1.0]

//----------------------------------------------------------//

#define FitToScreen ( [[UIScreen mainScreen] bounds])
#define FitToScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define FitToScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define versionOS ([[[UIDevice currentDevice] systemVersion] floatValue])

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)
#define RADIANS_TO_DEGREES(r) (r * 180 / M_PI)

#define KillTimer(t)  if(t){ [t invalidate]; t = nil;}

#define IS_HEIGHT_GTE_480 [[UIScreen mainScreen ] bounds].size.height == 480.0f
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height == 568.0f
#define IS_HEIGHT_GTE_667 [[UIScreen mainScreen ] bounds].size.height == 667.0f
#define IS_HEIGHT_GTE_736 [[UIScreen mainScreen ] bounds].size.height == 736.0f

#define IS_IPHONE_4     (IS_HEIGHT_GTE_480)
#define IS_IPHONE_5     (IS_HEIGHT_GTE_568)
#define IS_IPHONE_6     (IS_HEIGHT_GTE_667)
#define IS_IPHONE_6Plus (IS_HEIGHT_GTE_736)


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
#define IS_IOS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS_7_OR_bellow ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.0)

#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:1.f]
#define RGBCOLORAlpha(r,g,b,a) \
[UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
#define cellImageSize (IS_IPAD || IS_IPHONE_6Plus || IS_IPHONE_6)?@"large":@"small"

#define TostMessage 0
#define alertMessge 1

#define appDeleget [AppDelegate shareInstance]
#define comman [Comman shareInstance]

#define imgPickerCellHeight 80.0 // height widthBothSame
#define imgPickerCellHeight_totalImagesTxt 30.0 // height widthBothSame
#define E_defaultFontSize (IS_IPAD)?16:14

//#define appOrangeColor [UIColor colorWithRed:116.0/255.0 green:116.0/255.0 blue:116.0/255.0 alpha:1.0]


#define DtFormat            @"DD-MM-YYYY hh:mm:ss a"
#define DtFormatDateOnly    @"yyyy-MM-dd"
#define DtFormatYear        @"YYYY-MM-DD hh:mm:ss a"
#define DDmmyyyy            @"dd-MM-yyyy"

#pragma mark - fonts
#define FontProximaNovaThin         @"ProximaNova-Thin"
#define FontProximaNovaExtrabold    @"ProximaNova-Extrabld"
#define FontProximaNovaItalic       @"proxima-nova-italic"
#define FontProximaNovaRegular      @"ProximaNova-Regular"
#define FontProximaNovaSemibold     @"ProximaNova-Semibold"
#pragma ---

#define encription_key @"abcdefghijklmnopqrstuvwxyz123456"

#pragma mark- Image Name Refreance 
//Enabled Dasboard Images
#define E_Image_Home      @"home_ic"
#define E_Image_Back      @"back_ic"
#define E_Image_Search    @"search-128"
#define E_imgTitle        @"720"
#define E_Image_Logout    @"logout_ic"
#define E_Image_Checked_Box @"checked_check"
#define E_Image_Image_Placeholder @"image_placeholder"

#define E_Image_Snap_Shot          @"snap_shot"
#define E_Image_Owner_Rolodex      @"owner_rolodex"
#define E_Image_Active_Employees   @"active_emps"
#define E_Image_Full_Asset_Info    @"full_assets"
#define E_Image_System_Count       @"system_count"
#define E_Image_Assets_Nearby      @"assets_nearby"
#define E_Image_Eforms             @"eform"

#define openCamera      E_localize(@"btn_title_camera")
#define opengallery     E_localize(@"btn_titile_gallery")
#define openVideoURL    E_localize(@"btn_title_videoURL")

#define flagFriendRequestList           @"1"
#define flagCondoDirectory              @"2"
#define flagFriendList                  @"3"
#define flagBlockList                   @"4"
#define flagOccuptantList               @"5"
#define flagViewAll_Composee            @"6"

//its call for "flagFriendRequestList"
#define friendFilterFriendList          @"1"
#define friendFilterFriendRequestLsit   @"2"
#define FriendFilterNo                  @""

#define E_AllUser 1
#define E_OnlyFriends 2
#define E_NoOne 3

#define NOTIFICATION_Home_screen_change             @"HomeScreenChange"
#define NOTIFICATION_Change_wall_type               @"changeWallType"
#define NOTIFICATION_Reload_side_menu               @"SideMenu"
#define NOTIFICATION_unread_badge_count             @"unread_badge_count"
#define NOTIFICATION_unread_badge_count_sidemenu    @"unread_badge_count_sidemenu"
#define NOTIFICATION_Reload_MY_Unit                 @"Reload_my_unit"
#define NOTIFICATION_unread_badge_message           @"unread_message_count"

#define doc_private     1
#define doc_shared      2
#define doc_public      3

#pragma mark- Module Id's 

//don't change with out permission _jenish
#define Module_Id_Wall                  @"a8337c44-9b25-11e5-860a-f04da2688cd1"
#define Module_Id_Notification          @"b63979b7-d466-11e5-915b-001c23e2880a"
#define Module_Id_Units                 @"ab2aee6b-9b25-11e5-860a-f04da2688cd1"

#pragma mark-

#define role_id_owner           @"d3e08301-9b1f-11e5-860a-f04da2688cd1"
#define role_id_tenant          @"d6698982-9b1f-11e5-860a-f04da2688cd1"


#define ROLE_GROUP_COUNCIL_MEMBER 1
#define ROLE_GROUP_STAFF  2
#define ROLE_GROUP_RESIDENT  3
#define ROLE_GROUP_3RDPARTY  4
#define ROLE_GROUP_PM  5

#define templateId_Text         @"1"
#define templateId_Text_photo   @"2"
#define templateId_Text_video   @"3"

#define EditTag                 @"919"
#define DeleteTag               @"920"
#define NoDataTag               404

#define STR_unread_badge_count      @"unread_badge_count"
#define STR_unread_message_count    @"unread_message_count"

#define Poll_DateFormate            @"yyyy-MM-dd hh:mm a"
#define Poll_display_DateFormate    @"dd MMM' '''yy hh:mm a"
#define Post_dateFormate            @"dd-MM-yyyy"
#define Genral_dateFormate          @"yyyy-MM-dd HH:mm:ss"

#define General_Time_only           @"hh:mm a"
#define General_date_on_new_line    @"dd \n MMM' '''yy \n hh:mm a"

//Hemanshu
#define General_dateFormate_Without_time    @"yyyy-MM-dd"
#define Post_display_dateFormate            @"dd MMM' '''yy" //''' for space
#define Post_display_format_day_month       @"dd MMM' at 'hh:mm a'"
#define Post_display_format_day_month_year  @"dd MMM' '''yy' at 'hh:mm a'"
#define Genral_dateFormate_new              @"yyyy-MM-dd HH:mm"

#define ACTIVE_USERS        @"1"
#define ALL_TYPE_OF_USERS   @"0"

#define IS_ACTIVE_USER      @"isActiveUser"

extern NSString *CompanyId;
extern NSString *Ext_condoId;
extern NSString *Ext_condo_unit_id;
extern NSString *Ext_condo_userID;
extern bool     ext_remeber_me;
extern NSString *kCondoID;
extern NSString *Ext_Staging;
extern NSString *Ext_unread_badge_count;
extern NSString *Ext_condo_name;

@interface Constants : NSObject
/**
 
NSString *E_Encoded(NSString *plainText);
 
 ==========
 
 E_encode method use for Encode NSString to ASE256
 
 @param NSString
 .
 @return NSString
 .
 which is in decoded form
 
 */

NSString * E_Encoded(NSString *plainText);

/**
 
 NSString *E_Decoded(NSString *base64Text);
 
 ==========
 
 E_Decoded method use for Decoded base64Text to PlainText
 
 @param NSString
 . which is in base64Text
 @return NSString
 .
 which is in PlainText form
 
 */


NSString * E_Decoded(NSString *base64Text);
+(NSMutableDictionary*)GetImageDicWithObj:(UIImage*)img withSelectedID:(NSString*)strID;
@end
