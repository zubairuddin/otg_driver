//
//  BankAccountDetailsVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 03/06/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "BankAccountDetailsVC.h"
#import "BankDetailCell.h"
#import "Constant.h"
#import "GlobleMethod.h"
#import "AppDelegate.h"
#import "BankDetailCell2.h"
#import "Driver.h"
#import "UserDetailsModal.h"

typedef NS_ENUM(NSUInteger) {
    BankACNumber = 0,
    RoutingNumber
    /* More styles to come */
} BankDetails;

typedef NS_ENUM(NSUInteger) {
    Email = 0 ,
    Phone,
    Address,
    PostalCode,
    City,
    State
    /* More styles to come */
} PersonalDetails;




@interface BankAccountDetailsVC ()<UITextFieldDelegate>{
    AppDelegate *appDelegate;
}
@property (nonatomic , readwrite) PersonalDetails personalDetaisl;
@property (nonatomic , readwrite) BankDetails bankDetaisl;

@end

@implementation BankAccountDetailsVC

- (void)viewDidLoad {
    dictBankDetails = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    NSString *dateOfBirth         = kUserDetails.objDriverM.Dob;//[GlobleMethod getValueFromUserDefault:@"DOB"];
    
    [dictBankDetails setValue:kUserDetails.objDriverM.name forKey:@"firstName"];
    [dictBankDetails setValue:kUserDetails.objDriverM.lastName forKey:@"lastName"];
    [dictBankDetails setValue:kUserDetails.objDriverM.email forKey:@"email"];
    [dictBankDetails setValue:dateOfBirth forKey:@"dateOfBirth"];
    [dictBankDetails setValue:@"" forKey:@"streetAddress"];
    [dictBankDetails setValue:@"" forKey:@"locality"];
    [dictBankDetails setValue:@"" forKey:@"region"];
    [dictBankDetails setValue:@"" forKey:@"postalCode"];
    [dictBankDetails setValue:@"" forKey:@"funding_email"];
    [dictBankDetails setValue:@"" forKey:@"funding_mobilePhone"];
    [dictBankDetails setValue:@"" forKey:@"funding_accountNumber"];
    [dictBankDetails setValue:@"" forKey:@"funding_routingNumber"];
    
    if([kUserDetails.objDriverM.enableSandboxPaymentBraitree boolValue]){
        [dictBankDetails setValue:@"1" forKey:@"isSandboxEnabled"];
    }else{
        [dictBankDetails setValue:@"0" forKey:@"isSandboxEnabled"];
    }
    
    arrTitel = [[NSMutableArray alloc]initWithObjects:@"Bank Account", @"Contact Details", nil];
    arrSection0PlaceHolder = [[NSMutableArray alloc]initWithObjects:@"Bank account number", @"Routing number", nil];
    arrSection1PlaceHolder = [[NSMutableArray alloc]initWithObjects:@"Email address (Associated with Bank)",
                              @"Phone number (Associated with Bank)",
                              @"Address (Associated with Bank)",
                              @"Postal Code", @"City", @"State", nil];
}

- (void)LayoutSet{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeLeft];
}
-(void)viewWillAppear:(BOOL)animated{
    [self tableviewReload];
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SUBMIT BUTTON
- (IBAction)btnSubmit:(id)sender {
    
    NSLog(@"%@", dictBankDetails);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFCloud callFunctionInBackground:@"RegisterDriver" withParameters:dictBankDetails block:^(NSString* merchantInfo, NSError *error) {
        
        if(error != nil){
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            [GlobleMethod showAlert:self andMessage:[error localizedDescription]];
        }else{
            NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[merchantInfo dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            NSString *success = [results valueForKey:@"success"];
            if ([success boolValue] == false){
                [MBProgressHUD hideHUDForView:self.view animated:NO];
                [GlobleMethod showAlert:self andMessage:[results valueForKey:@"message"]];
            }else{
                NSString *merchantID = [[results valueForKey:@"merchantAccount"] valueForKey:@"id"];
                
                //            NSString *status = [[results valueForKey:@"merchantAccount"] valueForKey:@"status"];
                
                [ParseHelper saveBraintreeMerchentid:merchantID isBraintreeEnabled:[kUserDetails.objDriverM.enableSandboxPaymentBraitree boolValue] completion:^(PFObject *obje, NSError *error) {
                    
                    if(error != nil){
                        [MBProgressHUD hideHUDForView:self.view animated:NO];
                        [GlobleMethod showAlert:self andMessage:[error localizedDescription]];
                    }else{
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        dict = obje;
                        NSLog(@"%@", dict);
                        [[NSNotificationCenter defaultCenter]
                         postNotificationName:@"checkBankDetails"
                         object:self];
                        [MBProgressHUD hideHUDForView:self.view animated:NO];
                        [self dismissViewControllerAnimated:TRUE completion:nil];
                    }
                }];
            }
        }
        
    }];
}

#pragma mark - UITableView Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 2;
    }else{
        return 4;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"BankDetailCell";
    BankDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.txtTitle.delegate = self;
    
    if(indexPath.section == 0){
        cell.txtTitle.placeholder = arrSection0PlaceHolder[indexPath.row];
        [cell.txtTitle setTintColor:PrimaryColor];
        cell.txtTitle.delegate = self;
        
        if(indexPath.row == 0){
            cell.txtTitle.text = [dictBankDetails valueForKey:@"funding_accountNumber"];
            cell.txtTitle.tag =  0;
            cell.txtTitle.superview.tag = 0;
        }else{
            cell.txtTitle.text = [dictBankDetails valueForKey:@"funding_routingNumber"];
            cell.txtTitle.tag =  1;
            cell.txtTitle.superview.tag = 0;
        }
        return cell;
    }else{
        cell.txtTitle.placeholder = arrSection1PlaceHolder[indexPath.row];
        [cell.txtTitle setTintColor:PrimaryColor];
        cell.txtTitle.delegate = self;
        
        switch (indexPath.row) {
                case Email:{
                    cell.txtTitle.text = [dictBankDetails valueForKey:@"funding_email"];
                    cell.txtTitle.tag =  Email;
                    cell.txtTitle.superview.tag = 1;
                    break;
                }
                case Phone:{
                    cell.txtTitle.text = [dictBankDetails valueForKey:@"funding_mobilePhone"];
                    cell.txtTitle.tag =  Phone;
                    cell.txtTitle.superview.tag = 1;
                    break;
                }
                case Address:{
                    cell.txtTitle.text = [dictBankDetails valueForKey:@"streetAddress"];
                    cell.txtTitle.tag =  Address;
                    cell.txtTitle.superview.tag = 1;
                    break;
                }
                case PostalCode:{
                    static NSString *cellIdentifier = @"BankDetailCell2";
                    BankDetailCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                    
                    cell.txtPostalCode.placeholder = arrSection1PlaceHolder[3];
                    
                    cell.txtCity.placeholder = arrSection1PlaceHolder[4];
                    cell.txtState.placeholder = arrSection1PlaceHolder[5];
                    
                    cell.txtPostalCode.delegate = self;
                    cell.txtCity.delegate = self;
                    cell.txtState.delegate = self;
                    
                    cell.txtPostalCode.text = [dictBankDetails valueForKey:@"postalCode"];
                    cell.txtCity.text = [dictBankDetails valueForKey:@"locality"];
                    cell.txtState.text = [dictBankDetails valueForKey:@"region"];
                    
                    cell.txtPostalCode.tag  = PostalCode;
                    cell.txtCity.tag        = City;
                    cell.txtState.tag       = State;
                    
                    cell.txtPostalCode.superview.tag    = 1;
                    cell.txtCity.superview.tag          = 1;
                    cell.txtState.superview.tag         = 1;
                    
                    [cell.txtPostalCode setTintColor:PrimaryColor];
                    [cell.txtCity setTintColor:PrimaryColor];
                    [cell.txtState setTintColor:PrimaryColor];
                    
                    return cell;
                }
        }
        return cell;
    }
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return arrTitel[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)tableviewReload{
    
    if (self.objTable.delegate == nil) {
        self.objTable.delegate = self;
        self.objTable.dataSource = self;
    }
    [self.objTable reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - All Button Action

- (IBAction)onClickMenu:(id)sender {
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"checkBankDetails"
     object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.superview.tag == 0){
        if(textField.tag == 0){
            [dictBankDetails setValue:textField.text forKey:@"funding_accountNumber"];
        }else{
            [dictBankDetails setValue:textField.text forKey:@"funding_routingNumber"];
        }
    }else{
        switch ([textField tag]) {
                case Email:
                [dictBankDetails setValue:textField.text forKey:@"funding_email"];
                break;
                case Phone:
                [dictBankDetails setValue:textField.text forKey:@"funding_mobilePhone"];
                break;
                case Address:
                [dictBankDetails setValue:textField.text forKey:@"streetAddress"];
                break;
                case PostalCode:
                [dictBankDetails setValue:textField.text forKey:@"postalCode"];
                break;
                case City:
                [dictBankDetails setValue:textField.text forKey:@"locality"];
                break;
                case State:
                [dictBankDetails setValue:textField.text forKey:@"region"];
                break;
            default:
                break;
        }
    }
}
@end
