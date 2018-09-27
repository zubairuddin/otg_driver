//
//  EditCarVC.h
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ACFloatingTextField.h"

@protocol carTypeDelegate <NSObject>
@optional
-(void) changeCarTypeImage;
@end

@interface EditCarVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate>{
    
//    BOOL isProfileEditing;
//    BOOL isCarEditing;
    
    NSMutableArray *arrayCarType;
    NSMutableArray *arrayCarTypeDisplay;
    int carType;
    NSString *tempCode;
    
    AppDelegate *appDelegate;
}

@property (nonatomic, assign) BOOL isProfileEditing;
@property (nonatomic, assign) BOOL isCarEditing;

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
//@property (nonatomic, weak) id <editProfileDelegate> delegateEditProfile;
-(void)updateProfileData;

///////

@property (weak, nonatomic) IBOutlet UIImageView *imgCarDp;
@property (weak, nonatomic) IBOutlet UIImageView *imgCarDpTop;
@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtCategory;
@property (weak, nonatomic) IBOutlet UIView *viewCarType;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;
@property (nonatomic, weak) id <carTypeDelegate> delegateCarType;
-(void)updateCarData;

@end
