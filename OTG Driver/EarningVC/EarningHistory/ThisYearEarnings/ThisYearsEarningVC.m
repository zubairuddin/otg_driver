//
//  ThisYearsEarningVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 15/05/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "ThisYearsEarningVC.h"
#import "EarningsCell.h"
#import "GlobleMethod.h"
#import "UserDetailsModal.h"

@interface ThisYearsEarningVC (){
    NSMutableArray *arrTodaysHistory;
    NSMutableDictionary*dictObjData;
}
@end

@implementation ThisYearsEarningVC

- (void)viewDidLoad {
    [super viewDidLoad];
    arrTodaysHistory = [[NSMutableArray alloc] initWithCapacity:0];
    dictObjData = [[NSMutableDictionary alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self getCurrentYearHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 

-(void)getCurrentYearHistory{
    
    
    PFObject *currentDriverObject = [PFObject objectWithoutDataWithClassName:@"Driver" objectId:kUserDetails.objDriverM.objectid];
    
    PFQuery *query =[PFQuery queryWithClassName:@"Ride"];
    [query includeKey:@"rider"];
    [query whereKey:@"driver" equalTo:currentDriverObject];
    [query whereKey:@"createdAt" greaterThan:[GlobleMethod getFirstMontheOfYearFromCurrnetDate]];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (!error) {
            __block NSInteger previousMonth = 0;
            [objects enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                double amount = 0.0;
                
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:obj.createdAt];
                NSInteger month = [dateComponent month];
                
                NSLog(@"%ld",(long)[dateComponent month]);
                
                if (previousMonth != month){
                    dictObjData = [[NSMutableDictionary alloc] init];
                    [dictObjData setValue:[NSNumber numberWithInteger:(month)] forKey:@"id"];
                    [dictObjData setValue:[NSString stringWithFormat:@"%ld", (long)month] forKey:@"month"];
                    [dictObjData setValue:[NSNumber numberWithInteger:[dateComponent year]] forKey:@"year"];
                    amount = [self getAmountFromParseObject:obj];
                    [dictObjData setValue:[NSNumber numberWithDouble:amount] forKey:@"amount"];
                    
                }else{
                    NSString *amt = [dictObjData valueForKey:@"amount"];
                    amount = [amt doubleValue];
                    amount += [self getAmountFromParseObject:obj];
                    [dictObjData setValue:[NSNumber numberWithDouble:amount] forKey:@"amount"];
                }
                if (previousMonth != month){
                    [arrTodaysHistory addObject:dictObjData];
                    previousMonth = month;
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
    NSString *month = [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"month"];
    
    switch ([month integerValue]) {
        case 1:
            cell.lblDate.text = [NSString stringWithFormat:@"January %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 2:
            cell.lblDate.text = [NSString stringWithFormat:@"Febuary %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 3:
            cell.lblDate.text = [NSString stringWithFormat:@"March %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 4:
            cell.lblDate.text = [NSString stringWithFormat:@"April %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 5:
            cell.lblDate.text = [NSString stringWithFormat:@"May %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 6:
            cell.lblDate.text = [NSString stringWithFormat:@"Jun %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 7:
            cell.lblDate.text = [NSString stringWithFormat:@"July %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 8:
            cell.lblDate.text = [NSString stringWithFormat:@"August %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 9:
            cell.lblDate.text = [NSString stringWithFormat:@"September %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 10:
            cell.lblDate.text = [NSString stringWithFormat:@"October %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 11:
            cell.lblDate.text = [NSString stringWithFormat:@"November %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
            break;
        case 12:
            cell.lblDate.text = [NSString stringWithFormat:@"December %@", [[arrTodaysHistory objectAtIndex:indexPath.row] valueForKey:@"year"]];
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
