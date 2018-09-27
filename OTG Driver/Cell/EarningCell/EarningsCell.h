//
//  EarningsCell.h
//  OTG Driver
//
//  Created by Amit Prajapati on 16/05/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarningsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblPickupAddress;

@end
