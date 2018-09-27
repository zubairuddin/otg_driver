//
//  LegalVC.h
//  OTG Driver
//
//  Created by Amit Prajapati on 05/04/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegalVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>{
}
@property (weak, nonatomic) IBOutlet UITableView *objTable;
@property NSMutableArray *ArrayMenu;
@end
