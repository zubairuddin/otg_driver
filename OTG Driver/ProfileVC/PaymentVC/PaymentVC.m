//
//  PaymentVC.m
//  OTG Driver
//
//  Created by Ankur on 02/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "PaymentVC.h"
#import "GlobleMethod.h"

@interface PaymentVC ()

@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [ self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - UIBUTTON Action

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
