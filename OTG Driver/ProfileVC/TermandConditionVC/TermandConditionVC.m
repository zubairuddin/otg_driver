//
//  TermandConditionVC.m
//  OTG Driver
//
//  Created by Ankur on 02/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "TermandConditionVC.h"
#import "GlobleMethod.h"

@interface TermandConditionVC ()

@end

@implementation TermandConditionVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{
    [ self.tabBarController.tabBar setHidden:YES];
}
#pragma mark - UIBUTTON Action

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
