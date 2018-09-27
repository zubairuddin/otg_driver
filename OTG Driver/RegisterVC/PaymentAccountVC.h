//
//  PaymentAccountVC.h
//  OTG Driver
//
//  Created by Ankur on 25/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentAccountVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtBackAccount;
@property (weak, nonatomic) IBOutlet UITextField *txtRoutionNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtPhonenumber;
@property (weak, nonatomic) IBOutlet UITextField *txtAddress;
@property (weak, nonatomic) IBOutlet UITextField *txtCity;
@property (weak, nonatomic) IBOutlet UITextField *txtState;
@property (weak, nonatomic) IBOutlet UITextField *txtPostalCode;
@property NSString *strBirthDate;
@end
