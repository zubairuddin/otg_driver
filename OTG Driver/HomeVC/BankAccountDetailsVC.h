//
//  BankAccountDetailsVC.h
//  OTG Driver
//
//  Created by Amit Prajapati on 03/06/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankAccountDetailsVC : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *arrTitel;
    NSMutableArray *arrSection0PlaceHolder;
    NSMutableArray *arrSection1PlaceHolder;
    NSMutableDictionary *dictBankDetails;
}
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *objTable;
@end
