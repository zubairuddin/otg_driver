//
//  EarningVC.m
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "EarningVC.h"
#import "RideCell.h"
#import "GlobleMethod.h"
#import "HCSStarRatingView.h"
#import "Driver.h"
#import "PrivecRideVC.h"
#import "EarningHistoryRootVC.h"
#import "UserDetailsModal.h"

@interface EarningVC ()

@end

@implementation EarningVC
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self LayoutSet];
    [self tableviewReload];
    
}

#pragma mark - Other Voide Method

- (void)LayoutSet{
    arrayManu = [[NSMutableArray alloc] initWithObjects:@"Invites",@"Promotions",@"Free Ride", nil];
    arraySubManu = [[NSMutableArray alloc] initWithObjects:@"Invite your friends to join ROTG",@"Comming Soon",@"Comming Soon", nil];
    
//    NSMutableDictionary *temp1 = [GlobleMethod getDictionaryFromUserDefault:@"objDriver"];
//    Driver *driver =[[Driver alloc]init];
//    [driver initwithLogineDetaile:temp1];
    
    float dueAmt = [kUserDetails.objDriverM.due_amount floatValue];
    float totleEarnings = [kUserDetails.objDriverM.total_earning floatValue];
    NSString *trips = kUserDetails.objDriverM.recent_trips;
    
    self.lblDueAmount.text = [NSString stringWithFormat:@"$%.2f", dueAmt];
    self.lblTotalEarnings.text = [NSString stringWithFormat:@"$%.2f", totleEarnings];
    if (trips == NULL){
        self.lblTrips.text = @"0";
    }else{
        self.lblTrips.text = [NSString stringWithFormat:@"%@",trips];
    }
}
- (IBAction)pushToTripsVC:(id)sender {
    PrivecRideVC *objPrivecRideVC =[self.storyboard instantiateViewControllerWithIdentifier:@"PrivecRideVC"];
    [self.tabBarController.navigationController pushViewController:objPrivecRideVC animated:YES];
}
- (IBAction)pushToEarningsVC:(id)sender {
    EarningHistoryRootVC *objEarningsRootVC =[self.storyboard instantiateViewControllerWithIdentifier:@"EarningHistoryRootVC"];
    [self.tabBarController.navigationController pushViewController:objEarningsRootVC animated:YES];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrayManu.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"RideCell";
    RideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.lblManu.text = [arrayManu objectAtIndex:indexPath.row];
    cell.lblSubMane.text = [arraySubManu objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableviewReload{
    if (self.objTable.delegate == nil) {
        
        self.objTable.delegate = self;
        self.objTable.dataSource = self;
    }
    [self.objTable reloadData];
    
}

@end
