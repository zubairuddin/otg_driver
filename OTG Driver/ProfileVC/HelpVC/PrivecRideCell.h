//
//  PrivecRideCell.h
//  Ride OTG
//
//  Created by Ankur on 22/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RateView.h"

@interface PrivecRideCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView    *imgDP;

@property (weak, nonatomic) IBOutlet UILabel        *lblName;
@property (weak, nonatomic) IBOutlet UILabel        *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel        *lblDate;
@property (weak, nonatomic) IBOutlet UILabel        *lblAddressTo;
@property (weak, nonatomic) IBOutlet UILabel        *lblAddressFrom;

@property (weak, nonatomic) IBOutlet UIButton       *btnRate;
@property (weak, nonatomic) IBOutlet UIButton       *btnFare;

@property (weak, nonatomic) IBOutlet UIView         *viewBackground;

@property (weak, nonatomic) IBOutlet RateView       *rateView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBtnHeight;

@end
