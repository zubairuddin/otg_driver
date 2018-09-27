//
//  RegisterVC.h
//  Ride OTG
//
//  Created by Ankur on 11/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface RegisterVC : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    AppDelegate *appDelegate;
    BOOL isPhotoSelected;
    BOOL isCondition;
    BOOL isPolicy;
}

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgTopSpace;
@property (weak, nonatomic) IBOutlet UIView *viewCountryCode;
@property (weak, nonatomic) IBOutlet UIButton *btnShowCPass;

@property (weak, nonatomic) IBOutlet UIButton *btnShowPass;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgCountryLogo;
@property (weak, nonatomic) IBOutlet UIButton *btnCountryCode;
@property (weak, nonatomic) IBOutlet UITextField *txtContactNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtconfirmPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@property (weak, nonatomic) IBOutlet UIButton *btnTerm;
@property (weak, nonatomic) IBOutlet UIButton *btnPolicy;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;

@end
