//
//  RegisterProfileVC.m
//  OTG Driver
//
//  Created by Ankur on 25/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "RegisterProfileVC.h"
#import "GlobleMethod.h"
#import "CustomTabbarController.h"
#import "PaymentAccountVC.h"
#import "CountryVC.h"
#import "AppDelegate.h"
#import "UserDetailsModal.h"
#import "ACFloatingTextField.h"

@interface RegisterProfileVC ()<CountryDelegate, UITextFieldDelegate>{
    IBOutlet UIButton       *btnCountryCode;
    IBOutlet UIImageView    *imgCountryFlag;
    
    BOOL isLicenseDate;
    BOOL isCarRegDate;
    BOOL isWayBillDate;
    
    NSDateFormatter *formatter;
    NSString        *tempCode;
}

@end

@implementation RegisterProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayoutSetup];
    tempCode = @"0001";
}

- (void)viewWillAppear:(BOOL)animated{
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM-dd-YYYY"];
}

# pragma mark - All void Methord

- (void)LayoutSetup{
    
    if(_isCommingFromProfile){
        self.btnBack.hidden = FALSE;
    }else{
        self.btnBack.hidden = TRUE;
    }
    [GlobleMethod viewshadowandCornarRediation:self.viewTop Rediation:4.0];
    [GlobleMethod viewshadowandCornarRediation:self.viewBottom Rediation:4.0];
    [GlobleMethod CornarRediationset:self.imageDp Color:[UIColor blackColor] Rediation:45];
    [GlobleMethod CornarRediationset:self.imageCar Color:[UIColor blackColor] Rediation:45];
    
    if (![kUserDetails.objDriverM.name isEqualToString:@""]) {
        self.txtName.text = kUserDetails.objDriverM.name;//[GlobleMethod getValueFromUserDefault:@"NAME"];
    }
    
    if (![kUserDetails.objDriverM.contact isEqualToString:@""]) {
        NSString *strNumber = kUserDetails.objDriverM.contact;//[GlobleMethod getValueFromUserDefault:@"CONTACT"];
        NSString *strCode = [strNumber substringWithRange:NSMakeRange(0, 4)];
        self.txtContact.text = [strNumber substringWithRange:NSMakeRange(4, strNumber.length-4)];
        
        NSDictionary *dictCountries = [self JSONFromFile];
        NSDictionary *data          = [dictCountries objectForKey:@"Data"];
        NSMutableArray *arrCountries = [data objectForKey:@"list"];
        
        for (NSDictionary *country in arrCountries) {
            NSString *code = [NSString stringWithFormat:@"%@",[country objectForKey:@"Phonecode"]];
            NSInteger length = [code length];
            if(length == 1){
                tempCode = [NSString stringWithFormat:@"000%@", code];
            }else if (length == 2){
                tempCode = [NSString stringWithFormat:@"00%@", code];
            }else if (length == 3){
                tempCode = [NSString stringWithFormat:@"0%@", code];
            } else {
                tempCode = [NSString stringWithFormat:@"%@", code];
            }
            if ([tempCode isEqualToString:strCode]) {
                [btnCountryCode setTitle:[NSString stringWithFormat:@"+%@",[country objectForKey:@"Phonecode"]] forState:UIControlStateNormal];
                imgCountryFlag.image = [UIImage imageNamed:[[country valueForKey:@"ISO"] lowercaseString]];
                break;
            }
        }
    }
//    if ([GlobleMethod getValueFromUserDefault:@"DOB"]) {
        self.txtBOD.text = kUserDetails.objDriverM.Dob;//[GlobleMethod getValueFromUserDefault:@"DOB"];
//    }
//    if ([GlobleMethod getValueFromUserDefault:@"CARMODEL"]) {
    if (![kUserDetails.objDriverM.carModel isEqualToString:@""]) {
        self.txtCorModel.text = kUserDetails.objDriverM.carModel;//[GlobleMethod getValueFromUserDefault:@"CARMODEL"];
    }
    
//    if ([GlobleMethod getValueFromUserDefault:@"CARREGISTATIONNUM"]) {
    if (![kUserDetails.objDriverM.carRegisterNum isEqualToString:@""]) {
        self.txtCarRegistrationNum.text = kUserDetails.objDriverM.carRegisterNum;//[GlobleMethod getValueFromUserDefault:@"CARREGISTATIONNUM"];
    }
    
    if (![kUserDetails.objDriverM.socialSecurityNumber isEqualToString:@""]) {
        self.txtSSN.text = kUserDetails.objDriverM.socialSecurityNumber;//[GlobleMethod getValueFromUserDefault:@"CARMODEL"];
    }
    
//    if ([GlobleMethod getValueFromUserDefault:@"DP"]) {
    if (![kUserDetails.objDriverM.imageURL isEqualToString:@""]) {
        [self.imageDp sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.imageURL] placeholderImage:nil];
    }
    
//    if ([GlobleMethod getValueFromUserDefault:@"CARDP"]) {
    if (![kUserDetails.objDriverM.carURL isEqualToString:@""]) {
        [self.imageCar sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.carURL] placeholderImage:nil];
    }
    
//    if ([GlobleMethod getValueFromUserDefault:@"CARLICENSE"]) {
    if (![kUserDetails.objDriverM.licenseURL isEqualToString:@""]) {
        [self.imageLicense sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.licenseURL] placeholderImage:nil];
        [_btnLicense setImage:nil forState:UIControlStateNormal];
    }
    
//    if ([GlobleMethod getValueFromUserDefault:@"CARREGISTATION"]) {
    if (![kUserDetails.objDriverM.carRegistainURL isEqualToString:@""]) {
        [self.imageCarRegistation sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.carRegistainURL] placeholderImage:nil];
        [_btnCarRegistration setImage:nil forState:UIControlStateNormal];
    }
    
//    if ([GlobleMethod getValueFromUserDefault:@"LIABILITY"]) {
    if (![kUserDetails.objDriverM.liability isEqualToString:@""]) {
        [self.imageLiabilty sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.liability] placeholderImage:nil];
        [_btnLiability setImage:nil forState:UIControlStateNormal];
    }
    
//    if (![kUserDetails.objDriverM.licenseExpiryDate isEqualToString:@""]) {
    self.txtLlicenseDate.text = kUserDetails.objDriverM.licenseExpiryDate;//[NSString stringWithFormat:@"%@",[formatter stringFromDate:kUserDetails.objDriverM.licenseExpiryDate]];//[GlobleMethod getValueFromUserDefault:@"CARMODEL"];
    NSLog(@"%@", kUserDetails.objDriverM.strLicenseExpiryDate);
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM-dd-YYYY"];
//    licenseDate = [dateFormat dateFromString:kUserDetails.objDriverM.strLicenseExpiryDate];
//    }
    
//    if (![kUserDetails.objDriverM.registrationExpiryDate isEqualToString:@""]) {
    self.txtCarRegDate.text = kUserDetails.objDriverM.registrationExpiryDate;// [NSString stringWithFormat:@"%@",[formatter stringFromDate:kUserDetails.objDriverM.registrationExpiryDate]];//[GlobleMethod getValueFromUserDefault:@"CARMODEL"];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"MMM-dd-YYYY"];
//    carRegDate = [dateFormat1 dateFromString:kUserDetails.objDriverM.strRegistrationExpiryDate];
//    }
    
//    if (![kUserDetails.objDriverM.waybillExpiryDate isEqualToString:@""]) {
    self.txtLiabilityDate.text = kUserDetails.objDriverM.waybillExpiryDate;//[NSString stringWithFormat:@"%@",[formatter stringFromDate:kUserDetails.objDriverM.waybillExpiryDate]];//[GlobleMethod getValueFromUserDefault:@"CARMODEL"]; cc
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MMM-dd-YYYY"];
//    wayBillDate = [dateFormat2 dateFromString:kUserDetails.objDriverM.strWaybillExpiryDate];
//    }
    arrayOfGender =[[NSMutableArray alloc]initWithObjects:@"Male",@"Female", nil];
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
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
    [btnCountryCode  setTitle:[NSString stringWithFormat:@"+%@",countryCode] forState:UIControlStateNormal];
    [btnCountryCode setContentMode:(UIViewContentMode)UIControlContentHorizontalAlignmentLeft];
    imgCountryFlag.image = [UIImage imageNamed:imgCountryLogo];
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

# pragma mark - All Button Action

- (IBAction)licenseUploadAct:(id)sender {
    [self OpenCameraOrGallary];
    strButtonTag = @"License";
}
- (IBAction)CarRegistrationUploadAct:(id)sender {
    [self OpenCameraOrGallary];
    strButtonTag = @"CarRegistration";
}

- (IBAction)LiablityUpload:(id)sender {
    [self OpenCameraOrGallary];
    strButtonTag = @"Liablity";
}

- (IBAction)Gender:(id)sender {
    self.viewGender.hidden = NO;
}
- (IBAction)BirthDate:(id)sender {
    self.viewDOB.hidden = NO;
}

- (IBAction)dp:(id)sender {
    [self OpenCameraOrGallary];
    strButtonTag = @"Dp";
}

- (IBAction)CarimageUploadAct:(id)sender {
    [self OpenCameraOrGallary];
    strButtonTag = @"CarImage";
}

- (IBAction)Back:(id)sender {

    if (self.IsDodument) {
        self.IsDodument = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}

- (IBAction)Save:(id)sender {
    if (_txtName.text.length == 0) {
        [(ACFloatingTextField *)_txtName showErrorWithText : @"Please enter your name"];
    }else if (![GlobleMethod validatePhone:self.txtContact.text]){
        [(ACFloatingTextField *)_txtContact showErrorWithText : @"Please enter your valid Contact."];
    }else if (_txtBOD.text.length == 0){
        [(ACFloatingTextField *)_txtBOD showErrorWithText : @"Please selecte birth date"];
    }else if (_txtSSN.text.length == 0){
        [(ACFloatingTextField *)_txtSSN showErrorWithText : @"Please enter social security number"];
    }else if (self.btnGender.titleLabel.text.length == 0){
        [GlobleMethod showAlert:self andMessage: @"Please selecte gender"];
    }else if (_txtCorModel.text.length == 0){
        [(ACFloatingTextField *)_txtCorModel showErrorWithText : @"Please enter car Model"];
    }else if (_txtCarRegistrationNum.text.length == 0){
        [(ACFloatingTextField *)_txtCarRegistrationNum showErrorWithText : @"Please enter car Registration Number"];
    }else if (self.imageLicense.image == nil){
        [GlobleMethod showAlert:self andMessage:@"Please upload License"];
    }else if (self.imageCarRegistation.image == nil){
        [GlobleMethod showAlert:self andMessage:@"Please upload Car Registration Number"];
    }else if (self.imageLiabilty.image == nil){
        [GlobleMethod showAlert:self andMessage:@"Please upload Liability"];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        tempCode = [NSString stringWithFormat:@"%@%@",tempCode, _txtContact.text];
//        [GlobleMethod setValueFromUserDefault:_txtBOD.text andkey:@"DOB"];
        
        kUserDetails.objDriverM.Dob                     = [formatter dateFromString:_txtBOD.text];
    
        
        [ParseHelper CompletProfile:self.txtName.text Contact:tempCode DOB:dob Male:_btnGender.titleLabel.text CarModel:self.txtCorModel.text SSNO:self.txtSSN.text LicenseExpDate:licenseDate RegExpDate:carRegDate WayBillExpDate:wayBillDate CarRegistration:self.txtCarRegistrationNum.text ProfileImage:self.imageDp CarImage:self.imageCar LicenseImage:self.imageLicense CarRegistrationImage:self.imageCarRegistation LiablityImage:self.imageLiabilty completion:^(PFObject *obje, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if (obje && error == nil){
                
                [appDeleget getDriverInfo:^(BOOL isSsuccess) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (self.IsDodument) {
                        self.IsDodument = NO;
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }else{
                        CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
                        [self.navigationController pushViewController:Home animated:YES];
                    }
                }];
            }else{
                NSLog(@"PaymentAccountVC   is  NOT going ");
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [GlobleMethod showAlert:self andMessage:ErrorMessage];
            }
        }];
    }
}

- (IBAction)Done:(id)sender {
    
    if ([sender tag] == 2) {
        [self.btnGender setTitle:strGender forState:UIControlStateNormal];
        self.viewGender.hidden = YES;
        
    }else if ([sender tag] ==4){
        NSString *tempDate = [NSString stringWithFormat:@"%@",[formatter stringFromDate:_PickerviewDate.date]];
        
        if (isLicenseDate){
            isLicenseDate = NO;
            self.txtLlicenseDate.text = tempDate;
            licenseDate = _PickerviewDate.date;
        }else if (isCarRegDate){
            isCarRegDate = NO;
            self.txtCarRegDate.text = tempDate;
            carRegDate = _PickerviewDate.date;
        }else if(isWayBillDate){
            isWayBillDate = NO;
            self.txtLiabilityDate.text = tempDate;
            wayBillDate  = _PickerviewDate.date;
        }else{
            self.txtBOD.text = tempDate;
            dob = _PickerviewDate.date;
        }
        self.viewDOB.hidden = YES;
    }
}

- (IBAction)Cancel:(id)sender {
    
    if ([sender tag] == 1) {
        [self.btnGender setTitle:@"Gender" forState:UIControlStateNormal];
        self.viewGender.hidden = YES;
    }else if ([sender tag] ==3){
        self.txtBOD.text = @"";
        self.viewDOB.hidden = YES;
    }
}

-(void)OpenCameraOrGallary{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    actionSheet.title = nil;
    actionSheet.message = nil;
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:nil];
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
    
    //    if (!self.imgDp)
    //    {
    //        return;
    //    }
    if ([strButtonTag isEqualToString:@"Dp"]) {
        [picker dismissViewControllerAnimated:YES completion:^{}];
        self.imageDp.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
    }
    if ([strButtonTag isEqualToString:@"CarImage"]) {
        [picker dismissViewControllerAnimated:YES completion:^{}];
        self.imageCar.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
    }
    if ([strButtonTag isEqualToString:@"License"]) {
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        [self.btnLicense setImage:nil forState:UIControlStateNormal];
        self.imageLicense.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    if ([strButtonTag isEqualToString:@"CarRegistration"]) {
        [picker dismissViewControllerAnimated:YES completion:^{}];
        
        [self.btnCarRegistration setImage:nil forState:UIControlStateNormal];
        self.imageCarRegistation.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    if ([strButtonTag isEqualToString:@"Liablity"]) {
        [picker dismissViewControllerAnimated:YES completion:^{}];
        [self.btnLiability setImage:nil forState:UIControlStateNormal];
        self.imageLiabilty.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
    // Picking Image from Camera/ Library
}


#pragma mark - Picker view Delegate Methord

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString * title = nil;
    title=[arrayOfGender objectAtIndex:row];
    return title;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    strGender = [arrayOfGender objectAtIndex:row];
}

#pragma mark -UItextField Delegate Methord

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtName) {
        [textField resignFirstResponder];
        [self.txtContact becomeFirstResponder];
    } else if (textField == self.txtContact) {
        [textField resignFirstResponder];
        [self.txtCorModel becomeFirstResponder];
    }else if (textField == self.txtCorModel) {
        [textField resignFirstResponder];
        [self.txtCarRegistrationNum becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (textField == self.txtLlicenseDate){
        _btnDateDone.customView.tag = self.txtLlicenseDate.tag;
        isWayBillDate = NO;
        isLicenseDate = YES;
        isCarRegDate = NO;
        
    }else if (textField == self.txtCarRegDate){
        _btnDateDone.customView.tag = self.txtCarRegDate.tag;
        isWayBillDate = NO;
        isLicenseDate = NO;
        isCarRegDate = YES;
        
    }else if (textField == self.txtLiabilityDate) {
        _btnDateDone.customView.tag = self.txtLiabilityDate.tag;
        isWayBillDate = YES;
        isLicenseDate = NO;
        isCarRegDate = NO;
    }
    self.viewDOB.hidden = NO;
    return false;
}


@end
