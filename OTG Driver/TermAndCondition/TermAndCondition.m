//
//  TermAndCondition.m
//  Ride OTG
//
//  Created by vijay on 15/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "TermAndCondition.h"
#import "Constant.h"
#import "GlobleMethod.h"

@interface TermAndCondition ()

@end

@implementation TermAndCondition

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self Setlayout];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark void Methord

- (void)Setlayout {
    self.lblTitle.text = self.title;
    appDelegate  = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self loadWebside];
}

-(void)loadWebside{
    NSString *urlString;
    if ([self.title isEqualToString:@"Terms and Conditions"]) {
        urlString = @"https://rideotg.back4app.io/tnc";
    }else{
        urlString = @"https://rideotg.back4app.io/pp";
    }

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.Webview loadRequest:urlRequest];
    [self.Webview sizeToFit];
}

#pragma mark - All Button Action

- (IBAction)agree:(id)sender {
    if ([self.title isEqualToString:@"Terms and Conditions"]) {
        appDelegate.isTerm = YES;
    }else if ([self.title isEqualToString:@"Privacy Policy"]){
        appDelegate.isPolicy = YES;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIWebview Delegate Methord

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"finish");
    [self.Webview stringByEvaluatingJavaScriptFromString: @"document.body.style.fontFamily = 'PT Sans Narrow'"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}

@end
