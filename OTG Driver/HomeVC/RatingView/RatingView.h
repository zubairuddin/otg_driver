//
//  RatingView.h
//  Ride OTG
//
//  Created by Vijay on 26/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RateView.h"
#import "GlobleMethod.h"

@protocol rateDelegate <NSObject>
@optional
- (void)dismissViewWithIndex:(NSString*)index withRating:(float)rating ;
@end

@interface RatingView : UIView <UITextFieldDelegate, RateViewDelegate>

@property (weak, nonatomic) IBOutlet RateView       *viewRate;
@property (weak, nonatomic) IBOutlet UIView         *mainBG;

@property (weak, nonatomic) IBOutlet UIImageView    *imageDp;

@property (weak, nonatomic) IBOutlet UILabel        *lblnameDriver;
@property (weak, nonatomic) IBOutlet UILabel        *lblPickupLocation;
@property (weak, nonatomic) IBOutlet UILabel        *lblDropLocation;
@property (weak, nonatomic) IBOutlet UILabel        *lblBottomtxtView;
@property (weak, nonatomic) IBOutlet UILabel        *lblTipFor;

@property (weak, nonatomic) IBOutlet UITextField    *txtTips;

@property (weak, nonatomic) IBOutlet UITextView     *txtView;

@property (weak, nonatomic) IBOutlet UISwitch       *toggle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint  *consBGHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint  *consTxtvHeight;

@property (weak, nonatomic) IBOutlet UIButton       *btnSubmit;
@property (weak, nonatomic) IBOutlet UIButton       *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton       *btndismiss;
@property (weak, nonatomic) NSString                *strIndex;

@property (nonatomic, weak) id <rateDelegate> delegateRate;

-(void)updateData:(NSMutableDictionary *)dictData;

@end

