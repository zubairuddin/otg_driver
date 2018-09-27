//
//  ProfileVC.h
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TermandConditionVC.h"
#import "HelpVC.h"
#import "SettingVC.h"
#import "LiabilitiesVC.h"
#import "DocumentVC.h"
#import "PaymentVC.h"
#import "LicencesVC.h"
#import "TermandConditionVC.h"
#import "AppDelegate.h"
#import "LegalVC.h"
#import "EditProfileDetails.h"

//@protocol carTypeDelegate <NSObject>
//@optional
//-(void) changeCarTypeImage;
//@end


@interface ProfileVC : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate,CountryDelegate>{
    AppDelegate *appDelegate;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageDriver;
@property (weak, nonatomic) IBOutlet UIImageView *imageCar;
@property (weak, nonatomic) IBOutlet UILabel *lblDriverName;
@property (weak, nonatomic) IBOutlet UILabel *lblNameCar;
@property (weak, nonatomic) IBOutlet UITableView *objTable;
@property NSMutableArray *ArrayMenu;
@property NSMutableArray *ArrayIcons;
@property (weak, nonatomic) IBOutlet UIView *ViewHeadar;
@property (weak, nonatomic) EditProfileDetails          *viewEditProfile;

////////////////////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet EditProfileDetails *objMainEditView;

@property (weak, nonatomic) IBOutlet UIView *objEditProfileView;
@property (weak, nonatomic) IBOutlet UIView *objEditCarView;

@property (weak, nonatomic) IBOutlet UIImageView *imgDpTop;
@property (weak, nonatomic) IBOutlet UIImageView *imgDp;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtLast;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtContact;
@property (weak, nonatomic) IBOutlet UITextField *txtDOB;
@property (weak, nonatomic) IBOutlet UITextField *txtSocSecNo;
@property (weak, nonatomic) IBOutlet UIView *ViewDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *PickerviewDate;
@property (weak, nonatomic) IBOutlet UIButton *btnCountryCode;
@property (weak, nonatomic) IBOutlet UIImageView *imgCountryFlag;
@property (nonatomic, weak) id <editProfileDelegate> delegateEditProfile;
-(void)updateProfileData;

///////

@property (weak, nonatomic) IBOutlet UIImageView *imgCarDp;
@property (weak, nonatomic) IBOutlet UIImageView *imgCarDpTop;
@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtCategory;
@property (weak, nonatomic) IBOutlet UIView *viewCarType;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;
//@property (nonatomic, weak) id <carTypeDelegate> delegateCarType;
-(void)updateCarData;
typedef void(^isSuccess)(BOOL);


@end
