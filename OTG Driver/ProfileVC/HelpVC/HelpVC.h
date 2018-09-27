//
//  HelpVC.h
//  Ride OTG
//
//  Created by Vijay on 21/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *arrTitel;
}
@property (weak, nonatomic) IBOutlet UITableView *objTable;


@end
