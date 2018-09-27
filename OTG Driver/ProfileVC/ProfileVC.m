//
//  ProfileVC.m
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "ProfileVC.h"
#import "GlobleMethod.h"
#import "ProfileCell.h"
#import "LoginVC.h"
#import "Driver.h"
#import "EditCarVC.h"
#import "TermAndCondition.h"
#import "RegisterProfileVC.h"
#import "AboutViewController.h"
#import "UserDetailsModal.h"

@interface ProfileVC ()<UIGestureRecognizerDelegate, carTypeDelegate, editProfileDelegate, UIPickerViewDelegate, UIPickerViewDataSource, CountryDelegate>{
    
    BOOL isProfileEditing;
    BOOL isCarEditing;
    
    NSMutableDictionary *dictFinalData;
    NSMutableArray *arrayCarType;
    NSMutableArray *arrayCarTypeDisplay;
    int carType;
    NSString *tempCode;
}

@end

@implementation ProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isProfileEditing = FALSE;
    isCarEditing = FALSE;
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    tapGesture1.numberOfTapsRequired = 1;
    [tapGesture1 setDelegate:self];
    [self.imageDriver addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    tapGesture2.numberOfTapsRequired = 1;
    [tapGesture2 setDelegate:self];
    [self.imageDriver addGestureRecognizer:tapGesture1];
    [self.imageCar addGestureRecognizer:tapGesture2];
    
    [self LayoutSet];
}
- (void)viewWillAppear:(BOOL)animated{
    [ self.tabBarController.tabBar setHidden:NO];
    self.objTable.tableHeaderView = self.ViewHeadar;
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (appDelegate.isEditCar) {
        appDelegate.isEditCar = NO;
        if (![kUserDetails.objDriverM.carURL isEqualToString:@""]) {
            [self.imageCar sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.carURL] placeholderImage:[UIImage imageNamed:@"dp_dummy"]];
        }
    }
    if (appDelegate.isEditProfile) {
        appDelegate.isEditProfile = NO;
        if (![kUserDetails.objDriverM.imageURL isEqualToString:@""]) {
            [self.imageDriver sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.imageURL] placeholderImage:[UIImage imageNamed:@"ic_directions_car"]];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated{
    if (appDelegate.isLogout) {
        appDelegate.isLogout = NO;
        [self logout];
    }
}

#pragma Mark Othe Method

-(void)LayoutSet{
    [GlobleMethod CornarRediationset:self.imageDriver Color:[UIColor blackColor] Rediation:40];
    [GlobleMethod CornarRediationset:self.imageCar Color:[UIColor blackColor] Rediation:40];
    
    self.ArrayMenu = [[NSMutableArray alloc] initWithObjects:@"Help",@"Liabilities",@"Documents", @"About", @"Legal", @"Sign Out", nil];
    
    self.ArrayIcons = [[NSMutableArray alloc] initWithObjects:@"ic_help",@"ic_assignment_ind",@"ic_content_paste", @"ic_info", @"ic_border_color", @"ic_lock_outline", nil];
    
    [self tableviewReload];
    if (![kUserDetails.objDriverM.imageURL isEqualToString:@""]) {
        [self.imageDriver sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.imageURL] placeholderImage:[UIImage imageNamed:@"dp_dummy"]];
    }
    if (![kUserDetails.objDriverM.carURL isEqualToString:@""]) {
        [self.imageCar sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.carURL] placeholderImage:[UIImage imageNamed:@"ic_directions_car"]];
    }
    if (![kUserDetails.objDriverM.name isEqualToString:@""]) {
        self.lblDriverName.text = kUserDetails.objDriverM.name;
    }
}

-(void)tapGesture:(UITapGestureRecognizer *)sender{
    [EXPhotoViewer showImageFrom:(UIImageView *)sender.view];
}
#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ArrayMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProfileCell";
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lblTitle.text =[self.ArrayMenu objectAtIndex:indexPath.row];
    cell.imageMenu.tintColor = [UIColor blackColor];
    [cell.imageMenu setImage:[UIImage imageNamed:self.ArrayIcons[indexPath.row]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        HelpVC *Help =[self.storyboard instantiateViewControllerWithIdentifier:@"HelpVC"];
        [self.tabBarController.navigationController pushViewController:Help animated:YES];
    }else if (indexPath.row == 1) {
        LiabilitiesVC *Liabilities =[self.storyboard instantiateViewControllerWithIdentifier:@"LiabilitiesVC"];
        [self.navigationController presentViewController:Liabilities animated:YES completion:nil];
    }else if (indexPath.row == 2) {
        RegisterProfileVC *Document =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterProfileVC"];
        Document.IsDodument = YES;
        Document.isCommingFromProfile = TRUE;
        [self.navigationController presentViewController:Document animated:YES completion:nil];
    }else if (indexPath.row == 3) {
        AboutViewController *about =[self.storyboard instantiateViewControllerWithIdentifier:@"AboutViewController"];
        [self.navigationController presentViewController:about animated:YES completion:nil];
    }else if (indexPath.row == 4) {
        LegalVC *legalVC =[self.storyboard instantiateViewControllerWithIdentifier:@"LegalVC"];
        [self.tabBarController.navigationController pushViewController:legalVC animated:YES];
    }else if (indexPath.row == 5) {
        [self logout];
    }
}

-(void)tableviewReload {
    if (self.objTable.delegate == nil) {
        self.objTable.delegate = self;
        self.objTable.dataSource = self;
    }
    [self.objTable reloadData];
    
}
-(void)logout{
    [GlobleMethod showAlertWithOkCancel:self andMessage:@"Are you sure you want to sign out?" okButtonTitle:@"Sign Out" cancelButtonTitle:@"Cancel" completion:^(BOOL success) {
        if (success){
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"STAYLOGGED"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [kUserDetails driverLogOut];
            
            LoginVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
            [self.tabBarController.navigationController pushViewController:Login animated:YES];
            
//            NSArray *viewControllers = self.tabBarController.navigationController.viewControllers;
//            for (UIViewController *anVC in viewControllers) {
//                if ([anVC isKindOfClass:[LoginVC class]]) {
//                    [self.tabBarController.navigationController popToViewController:anVC animated:YES];
//                    break;
//                }else{
//                    LoginVC *Login = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
//                    [(UINavigationController *)appDeleget.window.rootViewController presentViewController:Login animated:true completion:nil];
//                }
//            }
        }else{
            NSLog(@"Closed");
        }
    }];
    
}
#pragma Mark - UIBUTTON Action

- (IBAction)edit:(id)sender {
//    self.tabBarController.tabBar.hidden=YES;
//    EditCarVC *editVC =[self.storyboard instantiateViewControllerWithIdentifier:@"EditCarVC"];
//    editVC.providesPresentationContextTransitionStyle = true;
//    editVC.definesPresentationContext = true;
//    editVC.isProfileEditing = TRUE;
//    editVC.isCarEditing = FALSE;
//    [editVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//    [editVC.view setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.64111111]];
//    editVC.hidesBottomBarWhenPushed = TRUE;
//    [self presentViewController:editVC animated:TRUE completion:nil];
    
    isProfileEditing = TRUE;
    isCarEditing = FALSE;
    [self loadEditingView];
}

- (IBAction)change:(id)sender {
//    self.tabBarController.tabBar.hidden=YES;
    //    self.tabBarController.tabBar.hidden=YES;
//    EditCarVC *editVC =[self.storyboard instantiateViewControllerWithIdentifier:@"EditCarVC"];
//    editVC.providesPresentationContextTransitionStyle = true;
//    editVC.definesPresentationContext = true;
//    editVC.isProfileEditing = FALSE;
//    editVC.isCarEditing = TRUE;
//
//    [editVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
//    [editVC.view setBackgroundColor:[UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:0.64111111]];
//    editVC.hidesBottomBarWhenPushed = TRUE;
//
//    [self presentViewController:editVC animated:TRUE completion:nil];
    
    isProfileEditing = FALSE;
    isCarEditing = TRUE;
    [self loadEditingView];
}

#pragma mark - dismissView
//-(void)dismissViewWithIndex:(NSString *)index{
//    [UIView animateWithDuration:0.2 animations:^{
//        self.viewEditProfile.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self.viewEditProfile removeFromSuperview];
//    }];
//}

-(void)loadEditingView{
//    self.viewEditProfile = [[[NSBundle mainBundle] loadNibNamed:@"EditProfileDetails" owner:self options:nil] objectAtIndex:0];
//    self.viewEditProfile.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    self.viewEditProfile.delegateEditProfile = self;
//    self.viewEditProfile.delegateCarType = self;
    
//    self.tabBarController.tabBar.hidden = true;
    
    [GlobleMethod CornarRediationset:self.imgDp Color:[UIColor blackColor] Rediation:40];
    
    [GlobleMethod CornarRediationset:self.imgCarDp Color:[UIColor blackColor] Rediation:40];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        self.viewEditProfile.alpha = 1.0;
//    } completion:^(BOOL finished) {
//
//    }];
    
    if(isProfileEditing){
        self.objEditProfileView.hidden = FALSE;
        self.objEditCarView.hidden = TRUE;
        [self updateProfileData];
    }else if(isCarEditing){
        self.objEditProfileView.hidden = TRUE;
        self.objEditCarView.hidden = FALSE;
        [self updateCarData];
    }
//    [[UIApplication sharedApplication].keyWindow addSubview:self.viewEditProfile];

    self.objMainEditView.hidden = NO;
}
///////////////////////////////////////////////////////////
//////////////////////EDIT PROFILE POPUP///////////////////
///////////////////////////////////////////////////////////

- (IBAction)btnDismissClick:(UIButton *)sender {
    self.objMainEditView.hidden = YES;
//    self.tabBarController. = NO;
}

- (NSDictionary *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (NSArray *)doSomethingWithTheJson:(NSString*)code
{
    NSDictionary *dictCountries = [self JSONFromFile];
    
    NSDictionary *data = [dictCountries objectForKey:@"Data"];
    NSMutableArray *arrCountries = [[NSMutableArray alloc] initWithCapacity:0];
    arrCountries = [data objectForKey:@"list"];
    
//    for (NSDictionary *country in arrCountries) {
//        NSString *name = [country objectForKey:@"Name"];
//        NSLog(@"country name: %@", name);
//    }

    NSArray *filterArray = [arrCountries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(Phonecode == %d)", [code intValue]]];

    
//    NSDictionary *tempDict = [[NSDictionary alloc] init];

    
    return filterArray;
}

-(void)updateProfileData {
     _txtName.text  = kUserDetails.objDriverM.name;
     _txtLast.text  = kUserDetails.objDriverM.lastName;
    _txtEmail.text  = kUserDetails.objDriverM.email;
    
    NSString *contactNo = [kUserDetails.objDriverM.contact substringWithRange:NSMakeRange(4, [kUserDetails.objDriverM.contact length] - 4)];
    
  _txtContact.text  = contactNo;
      _txtDOB.text  = (NSString*)kUserDetails.objDriverM.Dob;
    
    NSString *countryCode = [kUserDetails.objDriverM.contact substringWithRange:NSMakeRange(0, 4)];
    tempCode = countryCode;
    
    countryCode = [NSString stringWithFormat:@"%ld", (long)[countryCode integerValue]];
    NSLog(@"%@", countryCode);
    
    NSArray *arrTemp = [self doSomethingWithTheJson: countryCode];
    
    NSDictionary *tempDict = [[NSDictionary alloc] init];
    tempDict = [arrTemp objectAtIndex:0];
    
    [self.btnCountryCode  setTitle:[NSString stringWithFormat:@"+%@",[tempDict valueForKey:@"Phonecode"]] forState:UIControlStateNormal];
    [self.btnCountryCode setContentMode:(UIViewContentMode)UIControlContentHorizontalAlignmentLeft];
    self.imgCountryFlag.image = [UIImage imageNamed:[[tempDict valueForKey:@"ISO"] lowercaseString]];
    
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
    
    self.PickerView.delegate = self;
    self.PickerView.dataSource = self;
    [self.PickerView reloadAllComponents];
    
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *strTempCarType = [NSString stringWithFormat:@"%d",carType];
        [ParseHelper CarEditProfile:self.txtModel.text Type:strTempCarType CarRigisterNumber:self.txtNumber.text CarImage:self.imgCarDp completion:^(PFObject *obje, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (obje && error == nil) {
                appDelegate.isEditCar= YES;
                Driver *driver =[[Driver alloc]init];
                NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
                temp1 = obje;
                [driver initwithLogineDetaile:temp1];
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Information update sucessfull " preferredStyle:UIAlertControllerStyleAlert];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [appDelegate getDriverInfo:^(BOOL success) {
                        [self LayoutSet];
                        self.objMainEditView.hidden = TRUE;
                    }];
                }]];
                [self presentViewController:actionSheet animated:YES completion:nil];
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
    
    if(isProfileEditing){
        if (!self.imgDp){
            return;
        }
        
        // Picking Image from Camera/ Library
        [picker dismissViewControllerAnimated:YES completion:^{}];
        self.imgDp.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }else if(isCarEditing){
        if (!self.imgCarDp){
            return;
        }
        
        // Picking Image from Camera/ Library
        [picker dismissViewControllerAnimated:YES completion:^{}];
        self.imgCarDp.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    }
    
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    carType = [[arrayCarType objectAtIndex:row] intValue];
}

///////
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        tempCode = [NSString stringWithFormat:@"%@%@",tempCode, _txtContact.text];
        
        [GlobleMethod setValueFromUserDefault:self.txtDOB.text andkey:@"DOB"];
        
        [ParseHelper EditProfile:self.txtName.text LastName:self.txtLast.text Email:self.txtEmail.text SSN:self.txtSocSecNo.text Contact:tempCode DOB:self.PickerviewDate.date ProfileImage:self.imgDp completion:^(PFObject *obje, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
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
                    [appDelegate getDriverInfo:^(BOOL success) {
                        [self LayoutSet];
                        self.objMainEditView.hidden = TRUE;
                    }];
                }]];
                
                [self presentViewController:actionSheet animated:YES completion:nil];
            }else{
                [GlobleMethod showAlert:self andMessage:error];
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
