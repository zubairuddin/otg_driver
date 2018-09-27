//
//  PrivecRideVC.h
//  Ride OTG
//
//  Created by Ankur on 22/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobleMethod.h"
#import "RatingView.h"

@interface PrivecRideVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSNumber *rating;
}
@property (weak, nonatomic) IBOutlet UIButton       *btnMenu;

@property (retain, nonatomic) IBOutlet UITableView  *objTable;
@property NSMutableArray *ArrayRide;
@property (weak, nonatomic) RatingView *viewRating;

@end
