//
//  RideStartesView.h
//  OTG Driver
//
//  Created by Vijay on 07/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRoundSwitch.h"

@interface RideStartesView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIImageView *imgRider;
@property (weak, nonatomic) IBOutlet UILabel *lblRiderName;
@property (nonatomic, retain) IBOutlet DCRoundSwitch *longSwitch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
