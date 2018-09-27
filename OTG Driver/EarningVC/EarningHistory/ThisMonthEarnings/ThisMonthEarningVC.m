//
//  ThisMonthEarningVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 15/05/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "ThisMonthEarningVC.h"
#import "EarningsCell.h"
#import "GlobleMethod.h"
#import "UserDetailsModal.h"

@interface ThisMonthEarningVC ()
{
    NSMutableArray *arrTodaysHistory;
    NSMutableDictionary*dictObjData;
}
@end

@implementation ThisMonthEarningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dictObjData = [[NSMutableDictionary alloc] initWithCapacity:0];
    arrTodaysHistory = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self getMonthlyEarningHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getMonthlyEarningHistory{
    
    PFObject *currentDriverObject = [PFObject objectWithoutDataWithClassName:@"Driver" objectId:kUserDetails.objDriverM.objectid];
    
    PFQuery *query =[PFQuery queryWithClassName:@"Ride"];
    [query includeKey:@"rider"];
    [query whereKey:@"driver" equalTo:currentDriverObject];
    [query whereKey:@"createdAt" greaterThan:[GlobleMethod getFirstDateOfMonthFromCurrnetDate]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            __block NSInteger previousWeek = 0;
            [objects enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                double amount = 0.0;

                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:obj.createdAt];

                NSInteger week = [dateComponent weekOfMonth];

                NSLog(@"%ld",(long)[dateComponent weekOfMonth]);

                if (previousWeek != week){
                    dictObjData = [[NSMutableDictionary alloc] init];
                    [dictObjData setValue:[NSNumber numberWithInteger:(week)] forKey:@"id"];
                    [dictObjData setValue:[NSString stringWithFormat:@"Week %ld", (long)week] forKey:@"week"];
                    amount = [self getAmountFromParseObject:obj];
                    [dictObjData setValue:[NSNumber numberWithDouble:amount] forKey:@"amount"];
                }else{
                    NSString *amt = [dictObjData valueForKey:@"amount"];
                    amount = [amt doubleValue];
                    amount += [self getAmountFromParseObject:obj];
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

-(double)getAmountFromParseObject:(PFObject *)object{
    double amount = 0.0;
    NSString *tempTip = @"0.0";
    
    if(object[@"payment_detail"]){
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:[[object valueForKey:@"payment_detail"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        tempTip = [results valueForKey:@"tipAmount"];
        double tip = [tempTip doubleValue];
        
        NSString *tempTotalAmt   = [results valueForKey:@"totalAmount"];
        double totalAmount = [tempTotalAmt doubleValue];
        
        amount = [self calculateDriverCharges:tip totalAmount:totalAmount];
        NSString *strFinalAmount = [NSString stringWithFormat:@"%.2f", amount];
        amount = [strFinalAmount doubleValue];
    }
    return amount;
}

-(double)calculateDriverCharges:(double)driverTip totalAmount:(double)totalAmt{
    double totalAmount = totalAmt * 0.85f;
    return totalAmount + driverTip;
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [arrTodaysHistory count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"EarningsCell";
    EarningsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.lblDate.text = [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"week"];
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
