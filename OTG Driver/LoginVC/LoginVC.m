//
//  LoginVC.m
//  Ride OTG
//
//  Created by Ankur on 11/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "LoginVC.h"
#import "Constant.h"
#import "GlobleMethod.h"
#import "RegisterVC.h"
#import "HomeVC.h"
#import "GlobleMethod.h"
#import "MBProgressHUD.h"
#import "CustomTabbarController.h"
#import "Driver.h"
#import "RegisterProfileVC.h"
#import "Constant.h"
#import "UserDetailsModal.h"

@interface LoginVC ()<GIDSignInDelegate, GIDSignInUIDelegate, UIPickerViewDelegate, UIPickerViewDataSource>{
    UIPickerView        *objPickerView;
    UIToolbar           *toolBar;
    NSMutableArray      *arrPickerData;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"STAYLOGGED"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self Setlayout];
    [self setupPickerView];
}

- (void)viewWillAppear:(BOOL)animated{
    
    _bgLogin.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    UIColor *borderColor = [UIColor colorWithRed:170
                                           green:255
                                            blue:255
                                           alpha:0.3];
    
    CGFloat  width = 0.5;
    _txtEmail.layer.borderWidth = width;
    _txtEmail.layer.borderColor = borderColor.CGColor;
    
    _txtPassword.layer.borderWidth = width;
    _txtPassword.layer.borderColor = borderColor.CGColor;
    
    [_txtPopupEmail setTintColor:PrimaryColor];
}

-(void)doneClick {
    if (objPickerView.tag != 0) {
        if (objPickerView.tag == 4){
            [GlobleMethod setValueFromUserDefault:@"" andkey:@"MODE"];
        } else {
            [GlobleMethod setValueFromUserDefault:arrPickerData[objPickerView.tag] andkey:@"MODE"];
        }
        [self removeFromView];
    }
}

-(void)cancelClick {
    [self removeFromView];
}

-(void)removeFromView {
    [UIView animateWithDuration:0.3 animations:^{
        objPickerView.frame     = CGRectMake(0, self.view.frame.size.height+150, self.view.frame.size.width, 150);
        toolBar.frame           = CGRectMake(0, self.view.frame.size.height+194, self.view.frame.size.width, 44);
    }];
}

#pragma mark : setupPickerView
-(void)setupPickerView {
    objPickerView               = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height+150, self.view.frame.size.width, 150)];
    objPickerView.backgroundColor = [UIColor lightGrayColor];
    objPickerView.delegate      = self;
    objPickerView.dataSource    = self;
    objPickerView.showsSelectionIndicator = YES;
    [self.view addSubview:objPickerView];
    [self.view bringSubviewToFront:objPickerView];
    
    [GlobleMethod setValueFromUserDefault:@"" andkey:@"MODE"];
    arrPickerData = [[NSMutableArray alloc] initWithArray:@[@"-- select mode --", @"_dev", @"_qa", @"_test", @"_prod"]];
    [objPickerView reloadAllComponents];
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height+194, self.view.frame.size.width, 44)];
    [toolBar sizeToFit];
    toolBar.tintColor           = [UIColor blackColor];
    toolBar.translucent         = true;
    toolBar.barStyle = UIBarStyleDefault;
    
    UIBarButtonItem *btnDone    = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    UIBarButtonItem *btnSpace   = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *btnCancel  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    [toolBar setItems:@[btnCancel, btnSpace, btnDone]];
    [toolBar setUserInteractionEnabled:true];
    [self.view addSubview:toolBar];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView
numberOfRowsInComponent:(NSInteger)component {
    return arrPickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return arrPickerData[row];
}

- (void)pickerView:(UIPickerView *)thePickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (row == 4) {
        objPickerView.tag = row;
        [GlobleMethod setValueFromUserDefault:@"" andkey:@"MODE"];
    } else if (row != 0) {
        objPickerView.tag = row;
        [GlobleMethod setValueFromUserDefault:arrPickerData[row] andkey:@"MODE"];
    }
    
}

# pragma mark - picker Button Action
-(IBAction)btnPickerClick:(UIButton *)sender {
    [objPickerView reloadAllComponents];
    [UIView animateWithDuration:0.3 animations:^{
        objPickerView.frame     = CGRectMake(0, self.view.frame.size.height-150, self.view.frame.size.width, 150);
        toolBar.frame           = CGRectMake(0, self.view.frame.size.height-194, self.view.frame.size.width, 44);
    }];
}

- (void)Setlayout {
    self.btnStayLogged.selected = YES;
    
    [_btnSignIn setBackgroundColor:PrimaryDarkColor];
//    [GlobleMethod setCornerRadious:_btnSignIn Rediation:5.0];
    
    appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    self.txtPopupEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    self.txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : TexfildePlaseHolderColre }];
    
    self.txtEmail.leftViewMode = UITextFieldViewModeAlways;
    self.txtEmail.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.txtPassword.leftViewMode = UITextFieldViewModeAlways;
    self.txtPassword.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.viewPopupBg.hidden = YES;
    self.btnReset.layer.cornerRadius = CornarReditionButton;
    
    self.txtEmail.text = [GlobleMethod getValueFromUserDefault:@"tempEmailToDisplay"];
}

# pragma mark - All Button Action

- (IBAction)Signin:(id)sender {
    if (_txtEmail.text.length == 0) {
        //[(ACFloatingTextField *)_txtEmail err : @"Please enter your email address."];
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your email address."];
    }
    else if ([GlobleMethod CheckSpace:_txtEmail.text] == NO){
        [(ACFloatingTextField *)_txtEmail showErrorWithText : @"Please enter your valid email address."];
    }
    else if (![GlobleMethod emailValidation:_txtEmail.text]){
        [(ACFloatingTextField *)_txtEmail showErrorWithText: @"Please enter your valid email address."];
    }
    else if (_txtPassword.text.length == 0) {
        [(ACFloatingTextField *)_txtPassword showErrorWithText : @"Please enter your password."];
    }
    else if ([GlobleMethod CheckSpace:_txtPassword.text] == NO){
        [(ACFloatingTextField *)_txtPassword showErrorWithText : @"Only blank space not allowed in Password"];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [ParseHelper signInAccountWithUserName:self.txtEmail.text password:self.txtPassword.text completion:^(PFObject *obje, NSError *error) {
            if (obje && !error) {
                [GlobleMethod setValueFromUserDefault:_txtEmail.text andkey:@"tempEmailToDisplay"];
                
                NSLog(@"Logine Detail  %@",obje);
//                Driver *driver =[[Driver alloc]init];
                NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
                temp1 = obje;
                NSLog(@"Logine object  %@ ",temp1);
//                [driver initwithLogineDetaile:temp1];
                
                Driver *objDriver = [[Driver alloc] initwithLogineDetaile:temp1];
                kUserDetails.objDriverM = objDriver;
                [kUserDetails saveUser];
                kUserDetails.objDriverM = [kUserDetails loadUser];
                
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([[temp1 valueForKey:@"is_active"] boolValue] == FALSE) {
                    RegisterProfileVC *RegisterProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterProfileVC"];
                    RegisterProfile.isCommingFromProfile = FALSE;
                    [self.navigationController pushViewController:RegisterProfile animated:YES];
                }else{
                    CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
                    [self.navigationController pushViewController:Home animated:YES];
                }
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [GlobleMethod showAlert:self andMessage:[NSString stringWithFormat:@"%@",error]];
            }
        }];
    }
}

- (IBAction)forgotPassword:(id)sender {
    self.viewPopupBg.hidden = NO;
}

- (IBAction)dismissPopup:(id)sender {
    if ([sender tag] == 1) {
        self.viewPopupBg.hidden = YES;
    }else if ([sender tag] == 2){
        self.viewPopupCode.hidden = YES;
    }else if ([sender tag] == 3){
        self.viewPopupPW.hidden = YES;
    }
}

- (IBAction)Reset:(id)sender {
    if (_txtPopupEmail.text.length == 0) {
        [GlobleMethod showAlert:self andMessage:@"Please enter your email address."];
    }
    else if ([GlobleMethod CheckSpace:_txtPopupEmail.text] == NO){
        [GlobleMethod showAlert:self andMessage:@"Please enter your valid email address."];
    }else if (![GlobleMethod emailValidation:_txtPopupEmail.text]){
        [GlobleMethod showAlert:self andMessage:@"Please enter your valid email address."];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        randomNumber = arc4random_uniform(100000);
        [PFCloud callFunctionInBackground:@"sendPasswordResetCodeMail" withParameters:@{@"email": _txtPopupEmail.text,@"code":[NSNumber numberWithInt:randomNumber],@"intentAction":@"otgDriver"}block:^(NSNumber *ratings, NSError *error) {
            if (!error) {
                // mail sent successfully
                self.viewPopupBg.hidden = YES;
                self.viewPopupCode.hidden = NO;
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            } else {
                NSLog(@"mail sending failed");
                [GlobleMethod showAlert:self andMessage:@"mail sending failed"];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }
}

- (IBAction)stayloggedAct:(UIButton*)sender {
    if ([sender isSelected]) {
//        [GlobleMethod setValueFromUserDefault:@"STAYLOGGED" andkey:@"STAYLOGGED"];
        [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"STAYLOGGED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        isStayLogged = [[[NSUserDefaults standardUserDefaults] valueForKey:@"STAYLOGGED"] boolValue];
        NSLog(isStayLogged ? @"TRUE" : @"FALSE");
        
        sender.selected = FALSE;
    }else{
//        [GlobleMethod setValueFromUserDefault:@"NOTSTAYLOGGED" andkey:@"STAYLOGGED"];
        
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"STAYLOGGED"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        isStayLogged = [[[NSUserDefaults standardUserDefaults] valueForKey:@"STAYLOGGED"] boolValue];
        NSLog(isStayLogged ? @"TRUE" : @"FALSE");
        
        sender.selected = TRUE ;
        [sender setTintColor:PrimaryDarkColor];
    }
}
- (IBAction)codeSubmit:(id)sender {
    if ([self.txtCode.text integerValue] == randomNumber ) {
        self.viewPopupCode.hidden = YES;
        self.viewPopupPW.hidden = NO;
    }
}

- (IBAction)ResetPassword:(id)sender {
    if ([self.txtResetPW.text isEqualToString:self.txtResetConfirmPW.text]) {
        [ParseHelper forgotPawword:self.txtResetConfirmPW.text email:self.txtPopupEmail.text completion:^(PFObject *obje, NSError *error) {
            if (obje && error == nil) {
                self.viewPopupPW.hidden = YES;
            }else{
                [GlobleMethod showAlert:self andMessage:[NSString stringWithFormat:@"%@", error]];
            }
        }];
    }
}

- (IBAction)passwordVisiableOnOff:(id)sender {
    if (isPWSsecure) {
        isPWSsecure = NO;
        [self.txtPassword setSecureTextEntry:YES];
        [self.btnPwsVisiableOnOff setImage:[UIImage imageNamed:@"ic_visibility_off_white"] forState:UIControlStateNormal];
    }else{
        isPWSsecure = YES;
        [self.txtPassword setSecureTextEntry:NO];
        [self.btnPwsVisiableOnOff setImage:[UIImage imageNamed:@"ic_visibility_white"] forState:UIControlStateNormal];
    }
}

#pragma mark -UItextField Delegate Methord

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtEmail) {
        [textField resignFirstResponder];
        [self.txtPassword becomeFirstResponder];
    } else if (textField == self.txtPassword) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - gogole signin delegates
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (error == nil) {
        NSMutableDictionary *dictResult = [[NSMutableDictionary alloc] init];
        [dictResult setValue:user.userID forKey:@"id"];
        [dictResult setValue:user.profile.email forKey:@"email"];
        [dictResult setValue:user.profile.name forKey:@"first_name"];
        [dictResult setValue:user.profile.givenName forKey:@"last_name"];
        if (user.profile.hasImage) {
            NSUInteger dimension = round(100 * [[UIScreen mainScreen] scale]);
            NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
            [dictResult setValue:[NSString stringWithFormat:@"%@",imageURL] forKey:@"url"];
        } else {
            [dictResult setValue:@"" forKey:@"url"];
        }
        [dictResult setValue:@"gmail" forKey:@"from"];
        [self checkAndSubmitDataToParse:dictResult];
    } else {
        NSLog(@"%@", error.localizedDescription);
    }
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
}

- (void)signInWillDispatch:(GIDSignIn *)signIn error:(NSError *)error {
    NSLog(@"%@",error.description);
}

// Present a view that prompts the user to sign in with Google
- (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController animated:YES completion:nil];
    //present view controller
}

// Dismiss the "Sign in with Google" view
- (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    //dismiss view controller
}
#pragma mark : facebook handler
- (void)facebookLoginFailed:(BOOL)isFBResponce{
    if(isFBResponce){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"pop_attention", nil) message:NSLocalizedString(@"request_error", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"pop_ok", nil) otherButtonTitles: nil];
        [alert show];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"pop_attention", nil) message:NSLocalizedString(@"loginfb_cancelled", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"pop_ok", nil) otherButtonTitles: nil];
        [alert show];
    }
}
# pragma mark - All Button Action
-(IBAction)btnGmailCLick:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    GIDSignIn *signin = [GIDSignIn sharedInstance];
    signin.shouldFetchBasicProfile = true;
    signin.delegate = self;
    signin.uiDelegate = self;
    [signin signIn];
}
- (IBAction)btnFbClick:(id)sender {
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
        // TODO: publish content.
    } else {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            //TODO: process error or result.
            if (error) {
                NSLog(@"Process error");
                [self facebookLoginFailed:YES];
            } else if (result.isCancelled) {
                [self facebookLoginFailed:NO];
            } else {
                if ([FBSDKAccessToken currentAccessToken]) {
                    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    //NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
                    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                    [parameters setValue:@"id,name,email,first_name,last_name,picture.type(large)" forKey:@"fields"];
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
                     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             NSLog(@"%@",result);
                             NSMutableDictionary *dictResult = [[NSMutableDictionary alloc] initWithDictionary:result];
                             NSString *strURL = dictResult[@"picture"][@"data"][@"url"];
                             if (strURL.length == 0) {
                                 strURL = @"";
                             }
                             [dictResult setValue:strURL forKey: @"url"];
                             [dictResult setValue:@"facebook" forKey:@"from"];
                             [self checkAndSubmitDataToParse:dictResult];
                         } else {
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             NSLog(@"%@",error);
                         }
                     }];
                } else {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self facebookLoginFailed:YES];
                }
            }
        }];
    }
}

-(void)checkAndSubmitDataToParse:(NSMutableDictionary *)dictResult {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ParseHelper checkSocialAvilable:dictResult[@"id"] completion:^(PFObject *obje, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (!obje && error) {
            NSString *strEmail =  dictResult[@"email"];
            if ([strEmail length] == 0) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"On The Go"                                                                                                       message: @"Enter your details"                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"Email";
                    textField.textColor = [UIColor blackColor];
                    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    //textField.borderStyle = UITextBorderStyleRoundedRect;
                }];
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"Phone number";
                    textField.textColor = [UIColor blackColor];
                    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    //textField.borderStyle = UITextBorderStyleRoundedRect;
                }];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSArray * textfields = alertController.textFields;
                    UITextField *txtEmail = textfields[0];
                    UITextField *txtPhone = textfields[1];
                    [dictResult setValue:txtEmail.text forKey:@"email"];
                    [dictResult setValue:txtPhone.text forKey:@"phone"];
                    if ((txtEmail.text.length == 0) || (txtPhone.text.length == 0)) {
                        [self presentViewController:alertController animated:YES completion:nil];
                    } else {
                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        [ParseHelper registerForSocialQuery:dictResult completion:^(PFObject *obje, NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if (obje && !error) {
                                [self gotoNext:obje];
                                NSLog(@"%@",obje);
                            } else {
                            }
                        }];
                    }
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            } else  {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"On The Go"                                                                                                       message: @"Enter your details"                                                                                                preferredStyle:UIAlertControllerStyleAlert];
                
                [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                    textField.placeholder = @"Phone number";
                    textField.textColor = [UIColor blackColor];
                    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                    //textField.borderStyle = UITextBorderStyleRoundedRect;
                }];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSArray * textfields = alertController.textFields;
                    UITextField *txtPhone = textfields[0];
                    [dictResult setValue:txtPhone.text forKey:@"phone"];
                    if  (txtPhone.text.length == 0) {
                        [self presentViewController:alertController animated:YES completion:nil];
                    } else {
                        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        [ParseHelper registerForSocialQuery:dictResult completion:^(PFObject *obje, NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if (obje && !error) {
                                [self gotoNext:obje];
                            } else {
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                            }
                        }];
                    }
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"Logine Detail  %@",obje);
            [self gotoNext:obje];
        }
    }];
}

-(void)gotoNext:(PFObject *)obje {
    NSLog(@"Logine Detail  %@",obje);
    Driver *driver =[[Driver alloc]init];
    NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
    temp1 = obje;
    NSLog(@"Logine object  %@ ",temp1);
    [driver initwithLogineDetaile:temp1];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([[temp1 valueForKey:@"is_active"] boolValue] == FALSE) {
        RegisterProfileVC *RegisterProfile =[self.storyboard instantiateViewControllerWithIdentifier:@"RegisterProfileVC"];
        RegisterProfile.isCommingFromProfile = FALSE;
        [self.navigationController pushViewController:RegisterProfile animated:YES];
    }else{
        CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
        [self.navigationController pushViewController:Home animated:YES];
    }
}
@end
