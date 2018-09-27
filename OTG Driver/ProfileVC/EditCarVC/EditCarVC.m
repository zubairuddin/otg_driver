//
//  EditCarVC.m
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "EditCarVC.h"
#import "GlobleMethod.h"
#import "Driver.h"
#import "UserDetailsModal.h"
#import "CountryVC.h"

@interface EditCarVC ()

@end

@implementation EditCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayCarTypeDisplay = [[NSMutableArray alloc]initWithObjects:@"OTG MINI",
                           @"OTG SEDAN",
                           @"OTG SUV",
                           @"OTG BLACK",
                           @"OTG PREMIUM", nil];
    
    arrayCarType = [[NSMutableArray alloc]initWithObjects:@"0", @"1",@"2",@"3", @"4", nil];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [self Layoutset];
    [self loadEditingView];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - Picker view Delegate Methord

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return arrayCarType.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    title=[arrayCarTypeDisplay objectAtIndex:row];
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    carType = [[arrayCarType objectAtIndex:row] intValue];
}


-(void)loadEditingView{

    [GlobleMethod CornarRediationset:self.imgDp Color:[UIColor blackColor] Rediation:40];
    
    [GlobleMethod CornarRediationset:self.imgCarDp Color:[UIColor blackColor] Rediation:40];
    
    if(_isProfileEditing){
        self.objEditProfileView.hidden = FALSE;
        self.objEditCarView.hidden = TRUE;
        [self updateProfileData];
    }else if(_isCarEditing){
        self.objEditProfileView.hidden = TRUE;
        self.objEditCarView.hidden = FALSE;
        [self updateCarData];
    }
}
///////////////////////////////////////////////////////////
//////////////////////EDIT PROFILE POPUP///////////////////
///////////////////////////////////////////////////////////

- (IBAction)btnDismissClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
    //    self.tabBarController. = NO;
}

-(void)updateProfileData {
    _txtName.text   = kUserDetails.objDriverM.name;
    _txtLast.text   = kUserDetails.objDriverM.lastName;
    _txtEmail.text  = kUserDetails.objDriverM.email;
    _txtContact.text = kUserDetails.objDriverM.contact;
    _txtDOB.text    = kUserDetails.objDriverM.Dob;
    
    NSLog(@"SSN:->%@", kUserDetails.objDriverM.socialSecurityNumber);
    
    _txtSocSecNo.text = kUserDetails.objDriverM.socialSecurityNumber;
    [_imgDp sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.imageURL]];
}

-(void)updateCarData{
    //set carTypePicker
    arrayCarTypeDisplay = [[NSMutableArray alloc]initWithObjects:@"OTG MINI",
                           @"OTG SEDAN",
                           @"OTG SUV",
                           @"OTG BLACK",
                           @"OTG PREMIUM", nil];
    
    arrayCarType = [[NSMutableArray alloc]initWithObjects:@"0", @"1",@"2",@"3", @"4", nil];
    
    if (![kUserDetails.objDriverM.carURL isEqualToString:@""]) {
        [self.imgCarDp sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.carURL] placeholderImage:[UIImage imageNamed:@"ic_directions_car"]];
    }
    if (![kUserDetails.objDriverM.carModel isEqualToString:@""]) {
        self.txtModel.text = kUserDetails.objDriverM.carModel;
    }
    if (![kUserDetails.objDriverM.carRegisterNum isEqualToString:@""]) {
        self.txtNumber.text = kUserDetails.objDriverM.carRegisterNum;
    }
    if (kUserDetails.objDriverM.carType != nil) {
        NSString *carTypeIdx = [NSString stringWithFormat:@"%@",kUserDetails.objDriverM.carType];
        self.txtCategory.text = [arrayCarTypeDisplay objectAtIndex:[carTypeIdx integerValue]];
    }
}


#pragma mark - textFieldDelegate Event
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _txtName){
        
    }else if (textField == _txtLast){
        
    }else if (textField == _txtEmail){
        
    }else if (textField == _txtContact){
        
    }else if (textField == _txtDOB){
        
    }else if (textField == _txtSocSecNo){
        
    }
}

#pragma MARK Car editing details

- (IBAction)Done:(id)sender {
    self.txtCategory.text = [arrayCarTypeDisplay objectAtIndex:carType];
    self.viewCarType.hidden = YES;
}

- (IBAction)Cancel:(id)sender {
    self.txtCategory.text = @"";
    self.viewCarType.hidden = YES;
}
- (IBAction)selectCarTyep:(id)sender {
    self.viewCarType.hidden = NO;
}

- (IBAction)updateinfomation:(id)sender {
    if (_txtName.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please enter your Name !"];
    }else  if (_txtEmail.text.length == 0) {
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your email address."];
    }
    if (self.txtModel.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please enter car model"];
    }else if (self.txtNumber.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please enter vahicale plate number"];
    }else if (self.txtCategory.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please select car catergory"];
    }else if (self.imgDp.image == nil){
        [GlobleMethod showAlert:self andMessage:@"Please selecte car picture"];
    }else{
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        NSString *strTempCarType = [NSString stringWithFormat:@"%d",carType];
        [ParseHelper CarEditProfile:self.txtModel.text Type:strTempCarType CarRigisterNumber:self.txtNumber.text CarImage:self.imgDp completion:^(PFObject *obje, NSError *error) {
            [MBProgressHUD hideHUDForView:self animated:YES];
            if (obje && error == nil) {
                appDelegate.isEditCar= YES;
                Driver *driver =[[Driver alloc]init];
                NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
                temp1 = obje;
                [driver initwithLogineDetaile:temp1];
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Information update sucessfull " preferredStyle:UIAlertControllerStyleAlert];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:TRUE completion:nil];
                }]];
                
                
            }else{
                [GlobleMethod showAlert:self andMessage:error];
            }
        }];
    }
}

- (IBAction)imageupload:(id)sender {
    UIViewController *currentTopVC = [self currentTopViewController];
    
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
        
        
        [currentTopVC presentViewController:picker animated:YES completion:^{}];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Select from Library button tapped.
        UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [currentTopVC presentViewController:picker animated:YES completion:^{}];
    }]];
    
    // Present action sheet.
    [currentTopVC presentViewController:actionSheet animated:YES completion:nil];
    
}


#pragma mark - Selecting Image from Camera and Library

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    if (!self.imgDp){
        return;
    }
    
    // Picking Image from Camera/ Library
    [picker dismissViewControllerAnimated:YES completion:^{}];
    self.imgDp.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

#pragma MARK Profile editing
#pragma mark - UIBUTTON Action

- (IBAction)Date:(id)sender {
    self.ViewDate.hidden = NO;
}

- (IBAction)DateDone:(id)sender {
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MMM-YYYY"];
    self.txtDOB.text=[NSString stringWithFormat:@"%@",[formatter stringFromDate:_PickerviewDate.date]];
    self.ViewDate.hidden = YES;
}

- (IBAction)DateCancel:(id)sender {
    self.txtDOB.text = @"";
    self.ViewDate.hidden = YES;
}

- (IBAction)updateProfilefomation:(id)sender {
    
    if (self.txtName.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please enter first name"];
    }else if (self.txtLast.text.length == 0) {
        [(ACFloatingTextField *)_txtLast showErrorWithText : @"Please enter last name"];
    }else if (self.txtEmail.text.length == 0) {
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter email"];
    }else if (![GlobleMethod emailValidation:_txtEmail.text]){
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your valid email address"];
    }else if (![GlobleMethod validatePhone:self.txtContact.text]){
        [(ACFloatingTextField *)_txtContact showErrorWithText : @"Please enter your valid Contact"];
    }
    else if (self.imgDp.image == nil){
        [GlobleMethod showAlert:self andMessage:@"Please selecte profile picture"];
    }else{
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        
        tempCode = [NSString stringWithFormat:@"%@%@",tempCode, _txtContact.text];
        
        [GlobleMethod setValueFromUserDefault:self.txtDOB.text andkey:@"DOB"];
        
        [ParseHelper EditProfile:self.txtName.text LastName:self.txtLast.text Email:self.txtEmail.text SSN:self.txtSocSecNo.text Contact:tempCode DOB:self.PickerviewDate.date ProfileImage:self.imgDp completion:^(PFObject *obje, NSError *error) {
            [MBProgressHUD hideHUDForView:self animated:YES];
            if (obje && error == nil) {
                appDelegate.isEditProfile= YES;
                NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
                temp1 = obje;
                Driver *objDriver = [[Driver alloc] initwithLogineDetaile:temp1];
                kUserDetails.objDriverM = objDriver;
                [kUserDetails saveUser];
                kUserDetails.objDriverM = [kUserDetails loadUser];
                
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Information update sucessfull " preferredStyle:UIAlertControllerStyleAlert];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [self dismissViewControllerAnimated:TRUE completion:nil];
                }]];
                
                [self presentViewController:actionSheet animated:YES completion:nil];
            }else{
                [GlobleMethod showAlert:self andMessage:[error localizedDescription]];
            }
        }];
    }
}

- (UIViewController *)currentTopViewController {
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

#pragma  mark - All BUtton Action
- (IBAction)btnPresentCountryView:(id)sender {
    CountryVC *countryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CountryVC"];
    countryVC.delegate = self;
    [self presentViewController:countryVC animated:YES completion:nil];
}

#pragma mark - country delegate
-(void)selectedCountry:(NSString *)countryCode imageName:(NSString *)imgCountryLogo {
    //self.lblTitle.hidden = NO;
    [_btnCountryCode  setTitle:[NSString stringWithFormat:@"+%@",countryCode] forState:UIControlStateNormal];
    [_btnCountryCode setContentMode:(UIViewContentMode)UIControlContentHorizontalAlignmentLeft];
    _imgCountryFlag.image = [UIImage imageNamed:imgCountryLogo];
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


@end
