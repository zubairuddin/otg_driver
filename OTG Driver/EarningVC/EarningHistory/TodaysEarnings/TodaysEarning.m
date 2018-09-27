//
//  TodaysEarning.m
//  OTG Driver
//
//  Created by Amit Prajapati on 15/05/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "TodaysEarning.h"
#import "EarningsCell.h"
#import "UserDetailsModal.h"

@interface TodaysEarning (){
    NSMutableArray *arrTodaysHistory;
    NSMutableDictionary*dictObjData;
}

@end

@implementation TodaysEarning

- (void)viewDidLoad {
    [super viewDidLoad];
    arrTodaysHistory = [[NSMutableArray alloc] initWithCapacity:0];
    dictObjData = [[NSMutableDictionary alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self getTodaysEarningHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getTodaysEarningHistory{
    
    
    NSDate *today = [NSDate date];
    PFObject *currentDriverObject = [PFObject objectWithoutDataWithClassName:@"Ride" objectId:kUserDetails.objDriverM.objectid];
    
    PFQuery *query =[PFQuery queryWithClassName:@"Ride"];
    [query includeKey:@"rider"];
    [query whereKey:@"driver" equalTo:currentDriverObject];
    [query whereKey:@"cretedAt" greaterThan:today];
    [query orderByDescending:@"cretedAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            [objects enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                double amount = 0.0;
                dictObjData = [[NSMutableDictionary alloc] init];
                
                NSDictionary *resultsDrop = [NSJSONSerialization JSONObjectWithData:[[obj valueForKey:@"drop"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                
                NSDictionary *resultsPickup = [NSJSONSerialization JSONObjectWithData:[[obj valueForKey:@"drop"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                
                [dictObjData setValue:[resultsDrop valueForKey:@"address"] forKey:@"drop"];
                [dictObjData setValue:[resultsPickup valueForKey:@"address"] forKey:@"pickup"];
                amount = [GlobleMethod getAmountFromParseObject:obj];
                [dictObjData setValue:[NSNumber numberWithDouble:amount] forKey:@"amount"];

                [arrTodaysHistory addObject:dictObjData];
                
                self.objTblView.tableFooterView = nil;
                [self.objTblView reloadData];
            }];
            if([objects count] == 0){
                self.objTblView.tableFooterView = [GlobleMethod E_noDataFound];
                [self.objTblView reloadData];
            }
            NSLog(@"%@", arrTodaysHistory);
        } else {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrTodaysHistory count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"EarningsCell";
    EarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.lblAmount.text = [NSString stringWithFormat:@"$%@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"amount"]];
    cell.lblPickupAddress.text = [NSString stringWithFormat:@"$%@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"pickup"]];
    cell.lblDate.text = [NSString stringWithFormat:@"$%@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"drop"]];
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
