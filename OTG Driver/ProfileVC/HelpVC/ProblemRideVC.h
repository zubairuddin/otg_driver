//
//  ProblemRideVC.h
//  Ride OTG
//
//  Created by Vijay on 23/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemRideVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
}
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

@property (weak, nonatomic) IBOutlet UITableView *objTable;
@property NSMutableArray *ArrayRide;

@end
