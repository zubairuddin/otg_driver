//
//  EarningVC.h
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarningVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrayManu ,*arraySubManu ,*ArrayRide;
    NSInteger *index;
}

@property (weak, nonatomic) IBOutlet UITableView *objTable;
@property (weak, nonatomic) IBOutlet UIView *viewPopup;
@property (weak, nonatomic) IBOutlet UIImageView *imageDp;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressTO;
@property (weak, nonatomic) IBOutlet UILabel *lblAddressFrom;

@property (weak, nonatomic) IBOutlet UILabel *lblDueAmount;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalEarnings;
@property (weak, nonatomic) IBOutlet UILabel *lblTrips;
@end
