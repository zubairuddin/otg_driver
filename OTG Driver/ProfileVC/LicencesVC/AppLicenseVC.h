//
//  AppLicenseVC.h
//  Ride OTG
//
//  Created by Vijay on 20/12/17.
//  Copyright © 2017 Vijay. All rights reserved.

#import <UIKit/UIKit.h>

@interface AppLicenseVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
}

@property NSMutableArray *arraAllLicense;
@property (weak, nonatomic) IBOutlet UITableView *objTable;

@end
