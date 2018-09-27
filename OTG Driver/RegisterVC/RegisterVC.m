
//
//  RegisterVC.m
//  Ride OTG
//
//  Created by Ankur on 11/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "RegisterVC.h"
#import "Constant.h"
#import "GlobleMethod.h"
#import "LoginVC.h"
#import "TermAndCondition.h"
#import "UIButton+tintImage.h"
#import "HomeVC.h"
#import "CustomTabbarController.h"
#import "CountryVC.h"
#import "Driver.h"
#import "RegisterProfileVC.h"

@interface RegisterVC ()<CountryDelegate>{
    NSString *tempCode;
}
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Setlayout];
    
    tempCode = @"0001";
    
    [_btnRegister setBackgroundColor:PrimaryDarkColor];
    [GlobleMethod setCornerRadious:_btnRegister Rediation:5.0];
    
    if(IS_IPHONE_X){
        self.imgTopSpace.constant = 70.0;
    }else{
        self.imgTopSpace.constant = 70.0;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    [self checkSelectedandUnselected];
}

#pragma mark - country delegate

-(void)selectedCountry:(NSString *)countryCode imageName:(NSString *)imgCountryLogo{
    
    [self.btnCountryCode  setTitle:[NSString stringWithFormat:@"+%@",countryCode] forState:UIControlStateNormal];
    [self.btnCountryCode setContentMode:(UIViewContentMode)UIControlContentHorizontalAlignmentLeft];
    self.imgCountryLogo.image = [UIImage imageNamed:imgCountryLogo];
    NSInteger length = [countryCode length];
    if(length == 1){
        tempCode = [NSString stringWithFormat:@"000%@", countryCode];
    }else if (length == 2){
        tempCode = [NSString stringWithFormat:@"00%@", countryCode];
    }else if (length == 3){
        tempCode = [NSString stringWithFormat:@"0%@", countryCode];
    } else {
        tempCode = [NSString stringWithFormat:@"%@",countryCode];
    }
}

- (IBAction)btnPresentCountryView:(id)sender {
    CountryVC *countryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryVC"];
    countryVC.delegate = self;
    [self presentViewController:countryVC animated:YES completion:nil];
}
- (IBAction)showHidePassword:(UIButton*)sender {
    if ([sender tag] == 111) {
        if ([sender isSelected]) {
            sender.selected = FALSE;
            [self.txtPassword setSecureTextEntry:YES];
            [sender setImage:[UIImage imageNamed:@"ic_visibility_off_white"] forState:UIControlStateNormal];
        }else{
            sender.selected = TRUE;
            [self.txtPassword setSecureTextEntry:NO];
            [sender setImage:[UIImage imageNamed:@"ic_visibility_white"] forState:UIControlStateNormal];
        }
    }else{
        if ([sender isSelected]) {
            sender.selected = FALSE;
            [self.txtconfirmPassword setSecureTextEntry:YES];
            [sender setImage:[UIImage imageNamed:@"ic_visibility_off_white"] forState:UIControlStateNormal];
        }else{
            sender.selected = TRUE;
            [self.txtconfirmPassword setSecureTextEntry:NO];
            [sender setImage:[UIImage imageNamed:@"ic_visibility_white"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Void Method

- (void)checkSelectedandUnselected{
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.isTerm) {
        [self.btnTerm setSelected:YES];
        [self.btnTerm setImageTintColor:TheamColor forState:UIControlStateSelected];
    }
    if (appDelegate.isPolicy) {
        [self.btnPolicy setSelected:YES];
        [self.btnPolicy setImageTintColor:TheamColor forState:UIControlStateSelected];
        
    }
}

- (void)Setlayout {
    
    appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    UIColor *borderColor = [UIColor colorWithRed:170
                                           green:255
                                            blue:255
                                           alpha:0.3];
    
    CGFloat  width = 0.5;
    self.txtName.layer.borderWidth = width;
    self.txtName.layer.borderColor = borderColor.CGColor;
    
    self.txtLastName.layer.borderWidth = width;
    self.txtLastName.layer.borderColor = borderColor.CGColor;
    
    self.txtEmail.layer.borderWidth = width;
    self.txtEmail.layer.borderColor = borderColor.CGColor;
    
    self.txtContactNumber.layer.borderWidth = width;
    self.txtContactNumber.layer.borderColor = borderColor.CGColor;
    
    self.txtPassword.layer.borderWidth = width;
    self.txtPassword.layer.borderColor = borderColor.CGColor;
    
    self.txtconfirmPassword.layer.borderWidth = width;
    self.txtconfirmPassword.layer.borderColor = borderColor.CGColor;
    
    self.viewCountryCode.layer.borderWidth = width;
    self.viewCountryCode.layer.borderColor = borderColor.CGColor;
    
    self.txtName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    self.txtLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    
    self.txtContactNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Contact Number" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Create Password" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    self.txtconfirmPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirm Password" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];

    self.btnCountryCode.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:@"Code" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    
    [_txtName               setTintColor:PrimaryColor];
    [_txtLastName           setTintColor:PrimaryColor];
    [_txtEmail              setTintColor:PrimaryColor];
    [_txtContactNumber      setTintColor:PrimaryColor];
    [_txtPassword           setTintColor:PrimaryColor];
    [_txtconfirmPassword    setTintColor:PrimaryColor];
    
    [self.btnTerm setImageTintColor:PrimaryColor forState:UIControlStateNormal];
    [self.btnPolicy setImageTintColor:PrimaryColor forState:UIControlStateNormal];
}

# pragma mark - All Button Action

- (IBAction)Signin:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)registerHere:(id)sender {

    if (_txtName.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please enter your Name !"];
    }else  if (_txtEmail.text.length == 0) {
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your email address."];
    }else if ([GlobleMethod CheckSpace:_txtEmail.text] == NO){
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your valid email address."];
    }else if (![GlobleMethod emailValidation:_txtEmail.text]){
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your valid email address."];
    }else if (![GlobleMethod validatePhone:self.txtContactNumber.text]){
        [(ACFloatingTextField *)_txtContactNumber showErrorWithText : @"Please enter your valid Contact."];
    }else if (_txtPassword.text.length == 0) {
        [(ACFloatingTextField *)_txtContactNumber showErrorWithText : @"Please enter your password."];
    }else if ([GlobleMethod CheckSpace:_txtPassword.text] == NO){
        [(ACFloatingTextField *)_txtPassword showErrorWithText : @"Only blank space not allowed in Password"];
    }else if (_txtconfirmPassword.text.length == 0) {
        [(ACFloatingTextField *)_txtconfirmPassword showErrorWithText : @"Please enter your Confirmpassword."];
    }else if ([GlobleMethod CheckSpace:_txtconfirmPassword.text] == NO){
        [(ACFloatingTextField *)_txtconfirmPassword showErrorWithText : @"Only blank space not allowed in ConfirmPassword"];
    }else if (![_txtPassword.text isEqualToString: _txtconfirmPassword.text]){
        [(ACFloatingTextField *)_txtPassword showErrorWithText : @"Password does't match"];
    }else if (!isPhotoSelected){
        [GlobleMethod showAlert:self andMessage:@"Please select profile picture"];
    }else if (!isCondition){
        [GlobleMethod showAlert:self andMessage:@"Please select terms and conditions"];
    }else if (!isPolicy){
        [GlobleMethod showAlert:self andMessage:@"Please select Privacy policy"];
    }else{
        tempCode = [NSString stringWithFormat:@"%@%@", tempCode, self.txtContactNumber.text];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [ParseHelper registerQuery:self.txtName.text LastName:self.txtLastName.text Email:self.txtEmail.text Contact:tempCode Password:self.txtPassword.text ProfileDp:self.imgProfile.image completion:^(PFObject *obje, NSError *error) {
            
            if (obje && error == nil) {
                Driver *driver =[[Driver alloc]init];
                NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
                temp1 = (NSMutableDictionary*)obje;
                NSLog(@"Logine object  %@ ",temp1);
                [driver initwithLogineDetaile:temp1];
                
                [self welcomeNewUser];
                
                if ([[temp1 valueForKey:@"is_active"]boolValue] == FALSE) {
                    RegisterProfileVC *RegisterProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterProfileVC"];
                    RegisterProfile.isCommingFromProfile = FALSE;
                    [self.navigationController pushViewController:RegisterProfile animated:YES];
                }else{
                    CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
                    [self.navigationController pushViewController:Home animated:YES];
                }
            }else{
                [GlobleMethod showAlert:self andMessage:error];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }];
    }
}

-(void)welcomeNewUser{
    NSString *welcomeText = [NSString stringWithFormat:@"WELCOME, %@!\nTHANK YOU FOR REGISTERING WITH RIDE OTG FAMILY! \nENJOY YOUR EXPERIENCE!\nwww.rideotg.com",[_txtName.text uppercaseString]];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dict setValue:_txtEmail.text forKey:@"email"];
    [dict setValue:_txtName.text forKey:@"name"];
    [dict setValue:_txtContactNumber.text forKey:@"mobile"];
    [dict setValue:welcomeText forKey:@"emaiil_text"];
    [dict setValue:@"Welcome to DriveOTG" forKey:@"email_subject"];
    [dict setValue:welcomeText forKey:@"sms_text"];
    
    [PFCloud callFunctionInBackground:@"welcomeNewUser2" withParameters:dict];
}

- (IBAction)TermAndConditionandPolicy:(id)sender {
    
    TermAndCondition *objTerm =[self.storyboard instantiateViewControllerWithIdentifier:@"TermAndCondition"];
    if ([sender tag] == 1) {
        objTerm.title = @"Terms and Conditions";
    }else if ([sender tag] == 2){
        objTerm.title = @"Privacy Policy";
    }
    [self.navigationController presentViewController:objTerm animated:YES completion:nil];
    
}

- (IBAction)selectunSelectTermAndPolicy:(id)sender{
    
    [sender setImageTintColor:PrimaryDarkColor forState:UIControlStateSelected];
    
    if ([sender tag] == 1) {
        if (![sender isSelected]) {
            [sender setSelected:YES];
            isCondition = YES;
        }else{
            [sender setSelected:NO];
            isCondition = NO;
        }
    }else if ([sender tag] == 2){
        if (![sender isSelected]) {
            [sender setSelected:YES];
            isPolicy = YES;
        }else{
            [sender setSelected:NO];
            isPolicy = NO;
        }
    }
    
}

- (IBAction)Profile:(id)sender{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    actionSheet.title = nil;
    actionSheet.message = nil;
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Camera button tapped.
        UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Select from Library button tapped.
        UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Selecting Image from Camera and Library

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (!self.imgProfile)
    {
        isPhotoSelected = NO;
        return;
    }
    // Picking Image from Camera/ Library
    isPhotoSelected = YES;
    [picker dismissViewControllerAnimated:YES completion:^{}];
    self.imgProfile.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

#pragma mark -UItextField Delegate Methord

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtName) {
        [textField resignFirstResponder];
        [self.txtLastName becomeFirstResponder];
    }else if (textField == self.txtLastName) {
        [textField resignFirstResponder];
        [self.txtEmail becomeFirstResponder];
    }else if (textField == self.txtEmail) {
        [textField resignFirstResponder];
        [self.txtContactNumber becomeFirstResponder];
    }else if (textField == self.txtContactNumber) {
        [textField resignFirstResponder];
        [self.txtPassword becomeFirstResponder];
    }else if (textField == self.txtPassword) {
        [textField resignFirstResponder];
        [self.txtconfirmPassword becomeFirstResponder];
    }else if (textField == self.txtconfirmPassword) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end


