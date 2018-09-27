//
//  LoginVC.h
//  Ride OTG
//
//  Created by Ankur on 11/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "ACFloatingTextField.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>

@interface LoginVC : UIViewController{
    AppDelegate *appDelegate;
    BOOL isPWSsecure;
    BOOL isStayLogged;
    int randomNumber;
}
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtPopupEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtResetPW;
@property (weak, nonatomic) IBOutlet UITextField *txtResetConfirmPW;

@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnStayLogged;
@property (weak, nonatomic) IBOutlet UIButton *btnPwsVisiableOnOff;

@property (weak, nonatomic) IBOutlet UIView *viewPopupBg;
@property (weak, nonatomic) IBOutlet UIView *viewPopupCode;
@property (weak, nonatomic) IBOutlet UIView *viewPopupPW;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIImageView *bgLogin;

@end
