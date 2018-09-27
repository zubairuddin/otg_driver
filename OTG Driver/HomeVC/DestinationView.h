//
//  DestinationView.h
//  OTG Driver
//
//  Created by Vijay on 01/01/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRoundSwitch.h"

@interface DestinationView : UIView

@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIImageView *imgRider;
@property (weak, nonatomic) IBOutlet UILabel *lblRiderName;
@property (nonatomic, retain) IBOutlet DCRoundSwitch *longSwitch1;

@end
