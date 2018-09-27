//
//  AboutViewController.m
//  Ride OTG
//
//  Created by admin on 24/03/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "AboutViewController.h"

#import "GlobleMethod.h"

@interface AboutViewController () {
    IBOutlet UIButton   *btnCall;
    IBOutlet UIButton   *btnSite;
    IBOutlet UIButton   *btnSupport;
    
    IBOutlet UIView     *viewBG;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GlobleMethod setCornerRadious:viewBG Rediation:5.0];
}

#pragma mark - Button clicks
- (IBAction)bckBtn:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btnCallClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"tel://+12015091221"]];
}
-(IBAction)btnSiteClick:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.rideotg.com"]];
}
-(IBAction)btnSupportClick:(UIButton *)sender {
    NSString *URLEMail = [NSString stringWithFormat:@"mailto:support@rideotg.com?subject=Ride OTG"];
    NSString *url = [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication]  openURL:[NSURL URLWithString: url]];
}
@end
