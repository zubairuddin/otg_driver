//
//  ProblemRideCell.h
//  Ride OTG
//
//  Created by Vijay on 23/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemRideCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgDP;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressTo;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressFrom;
@property (weak, nonatomic) IBOutlet UIButton *btnRate;
@property (weak, nonatomic) IBOutlet UILabel *btnFare;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;

@end
