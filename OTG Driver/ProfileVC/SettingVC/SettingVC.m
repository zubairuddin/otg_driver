//
//  SettingVC.m
//  OTG Driver
//
//  Created by Ankur on 02/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "SettingVC.h"
#import "GlobleMethod.h"
#import "Driver.h"
#import "LoginVC.h"
#import "ProfileVC.h"
#import "GlobleMethod.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

}
- (void)viewWillAppear:(BOOL)animated{
    [ self.tabBarController.tabBar setHidden:YES];
}
#pragma mark - UIBUTTON Action

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)LogoutAction:(id)sender {

    appDelegate.isLogout = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
