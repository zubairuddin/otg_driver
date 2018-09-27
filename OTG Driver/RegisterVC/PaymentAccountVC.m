//
//  PaymentAccountVC.m
//  OTG Driver
//
//  Created by Ankur on 25/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "PaymentAccountVC.h"
#import "BrainTreeHealper.h"
#import "GlobleMethod.h"
#import "CustomTabbarController.h"
#import "UserDetailsModal.h"

@interface PaymentAccountVC ()

@end

@implementation PaymentAccountVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)submit:(id)sender {
    
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:self.txtBackAccount.text forKey:@"submerchant_funding_accountNumber"];
    [dic setValue:self.txtRoutionNumber.text forKey:@"submerchant_funding_routingNumber"];
    [dic setValue:self.txtEmailAddress.text forKey:@"submerchant_funding_email"];
    [dic setValue:self.txtPhonenumber.text forKey:@"submerchant_funding_mobilePhone"];
    [dic setValue:self.txtAddress.text forKey:@"submerchant_streetAddress"];
    [dic setValue:self.txtCity.text forKey:@"submerchant_locality"];
    [dic setValue:self.txtState.text forKey:@"submerchant_region"];
    [dic setValue:kUserDetails.objDriverM.name forKey:@"submerchant_firstName"];
    [dic setValue:kUserDetails.objDriverM.lastName forKey:@"submerchant_lastName"];
    [dic setValue:kUserDetails.objDriverM.email forKey:@"submerchant_email"];
    [dic setValue:kUserDetails.objDriverM.contact forKey:@"submerchant_phone"];
    [dic setValue:_strBirthDate forKey:@"submerchant_dateOfBirth"];
    [dic setValue:self.txtPostalCode.text forKey:@"submerchant_postalCode"];
    
    NSLog(@"dic  %@",dic);
    
    CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
    [self.navigationController pushViewController:Home animated:YES];
    
//    [BrainTreeHealper DriverRegisterForBrainTree:dic completion:^(NSDictionary *obje, NSError *error) {
//        NSLog(@"error  %@",error);
//        NSLog(@"obje %@",obje);
//        
//        if ([obje objectForKey:@"submerchant_id"]) {
//            NSString *strMerchantid = [obje objectForKey:@"submerchant_id"];
//            [ParseHelper saveBraintreeMerchentid:strMerchantid completion:^(PFObject *obje, NSError *error) {
//                if (obje &&  error == nil) {
//                    CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
//                    [self.navigationController pushViewController:Home animated:YES];
//                }
//            }];
//        }
//    }];
}
- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UItextField Delegate Methord

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.txtBackAccount) {
        [textField resignFirstResponder];
        [self.txtRoutionNumber becomeFirstResponder];
    } else if (textField == self.txtRoutionNumber) {
        [textField resignFirstResponder];
        [self.txtEmailAddress becomeFirstResponder];
    }else if (textField == self.txtEmailAddress) {
        [textField resignFirstResponder];
        [self.txtPhonenumber becomeFirstResponder];
    }else if (textField == self.txtPhonenumber) {
        [textField resignFirstResponder];
        [self.txtAddress becomeFirstResponder];
    }else if (textField == self.txtAddress) {
        [textField resignFirstResponder];
        [self.txtCity becomeFirstResponder];
    }else if (textField == self.txtCity) {
        [textField resignFirstResponder];
        [self.txtState becomeFirstResponder];
    }else if (textField == self.txtState) {
        [textField resignFirstResponder];
        [self.txtPostalCode becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}


@end
