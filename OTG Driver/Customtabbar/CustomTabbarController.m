//
//  CustomTabbarController.m
//  tab
//
//  Created by Hiren varu on 31/08/17.
//  Copyright © 2017 Hiren varu. All rights reserved.


#import "CustomTabbarController.h"
#import "Constant.h"

@interface CustomTabbarController ()


@end

@implementation CustomTabbarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view layoutIfNeeded];
//    [self addTabbar];
    
    
}

//+ (void)HiddenTabbar:(BOOL)Hidden1{
//    CustomTabbarController *test;
////    test.tabBar.hidden = YES;
//}

- (void)addTabbar {
    
    viewTabbar = [[[NSBundle mainBundle] loadNibNamed:@"CustomTabbar" owner:self options:nil] objectAtIndex:0];
//    [viewTabbar setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 60, [[UIScreen mainScreen] bounds].size.width, 60)];
    [self.view addSubview:viewTabbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeTabbar) name:NCRemoveTabbar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(againAddTabbar) name:NCAddTabbar object:nil];
    
    [viewTabbar.btnFirst addTarget:self action:@selector(onClickFirst:) forControlEvents:UIControlEventTouchUpInside];
    [viewTabbar.btnSecond addTarget:self action:@selector(onClickSecond:) forControlEvents:UIControlEventTouchUpInside];
    [viewTabbar.btnThird addTarget:self action:@selector(onClickThird:) forControlEvents:UIControlEventTouchUpInside];
 }

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)onClickFirst:(UIButton *)sender {
    [self setSelectedIndex:0];
}

-(void)onClickSecond:(UIButton *)sender {
    [self setSelectedIndex:1];
}

-(void)onClickThird:(UIButton *)sender {
    [self setSelectedIndex:2];
}

- (void)removeTabbar {
    [viewTabbar removeFromSuperview];
    [ self.tabBarController.tabBar setHidden:YES];
    
}

- (void)againAddTabbar {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [ self.tabBarController.tabBar setHidden:NO];
    [self addTabbar];
}

@end
