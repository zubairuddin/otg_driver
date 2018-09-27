//
//  CountryCell.h
//  OTG Driver
//
//  Created by Amit Prajapati on 19/03/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgCountryLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryName;
@property (weak, nonatomic) IBOutlet UILabel *lblCountryCode;
@end
