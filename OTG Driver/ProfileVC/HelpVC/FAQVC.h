//
//  FAQVC.h
//  Ride OTG
//
//  Created by Vijay on 21/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQVC : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    
}

@property NSMutableArray *arraAllFAQ;
@property (weak, nonatomic) IBOutlet UITableView *objTable;


@end
