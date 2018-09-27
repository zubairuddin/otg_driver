//
//  TermAndCondition.h
//  Ride OTG
//
//  Created by vijay on 15/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TermAndCondition : UIViewController{
    AppDelegate *appDelegate;

}

@property (weak, nonatomic) IBOutlet UITextView *textViewTerm;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (retain, nonatomic) NSString *title;
@property (weak, nonatomic) IBOutlet UIWebView *Webview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ConstraintAgreeBtnHeight;

@end
