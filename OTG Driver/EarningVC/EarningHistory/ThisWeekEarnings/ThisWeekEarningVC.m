//
//  ThisWeekEarningVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 15/05/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "ThisWeekEarningVC.h"
#import "EarningsCell.h"
#import "GlobleMethod.h"
#import "UserDetailsModal.h"

@interface ThisWeekEarningVC ()
{
    NSMutableArray *arrTodaysHistory;
    NSMutableDictionary*dictObjData;
}
@end

@implementation ThisWeekEarningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrTodaysHistory = [[NSMutableArray alloc] initWithCapacity:0];
    dictObjData = [[NSMutableDictionary alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self getThisWeeksEarningHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getThisWeeksEarningHistory{
    
    PFObject *currentDriverObject = [PFObject objectWithoutDataWithClassName:@"Driver" objectId:kUserDetails.objDriverM.objectid];
    
    PFQuery *query =[PFQuery queryWithClassName:@"Ride"];
    [query includeKey:@"rider"];
    [query whereKey:@"driver" equalTo:currentDriverObject];
    [query whereKey:@"createdAt" greaterThan:[GlobleMethod getFirstDayOfTheCurrentWeekFromCurrentDate]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            __block NSInteger previousWeek = 0;
            [objects enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                double amount = 0.0;
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:obj.createdAt];
                NSInteger week = [dateComponent weekday];
                
                NSLog(@"%ld",(long)[dateComponent weekday]);
                
                if (previousWeek != week){
                    dictObjData = [[NSMutableDictionary alloc] init];
                    [dictObjData setValue:[NSNumber numberWithInteger:(week)] forKey:@"id"];
                    [dictObjData setValue:[NSString stringWithFormat:@"Day %ld", (long)week] forKey:@"week"];
                    amount = [GlobleMethod getAmountFromParseObject:obj];
                    [dictObjData setValue:[NSNumber numberWithDouble:amount] forKey:@"amount"];
                }else{
                    NSString *amt = [dictObjData valueForKey:@"amount"];
                    amount = [amt doubleValue];
                    amount += [GlobleMethod getAmountFromParseObject:obj];
                    [dictObjData setValue:[NSNumber numberWithDouble:amount] forKey:@"amount"];
                }
                if (previousWeek != week){
                    [arrTodaysHistory addObject:dictObjData];
                    previousWeek = week;
                }
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
    NSUInteger weekDaY = [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"week"];
    switch (weekDaY) {
        case 0:
             cell.lblDate.text = @"Sunday";
            break;
        case 1:
            cell.lblDate.text = @"Monday";
            break;
        case 2:
            cell.lblDate.text = @"Tuesday";
            break;
        case 3:
            cell.lblDate.text = @"Wednesday";
            break;
        case 4:
            cell.lblDate.text = @"Thursday";
            break;
        case 5:
            cell.lblDate.text = @"Friday";
            break;
        case 6:
            cell.lblDate.text = @"Saturday";
            break;
        default:
            break;
    }
   
    cell.lblAmount.text = [NSString stringWithFormat:@"$%@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"amount"]];
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
