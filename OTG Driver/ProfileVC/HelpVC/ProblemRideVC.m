//
//  ProblemRideVC.m
//  Ride OTG
//
//  Created by Vijay on 23/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "PrivecRide.h"
#import "GlobleMethod.h"
#import "ProblemRideVC.h"
#import "PrivecRideCell.h"
#import "ProblemRideCell.h"

@interface ProblemRideVC () <UIGestureRecognizerDelegate> {
    IBOutlet UILabel *lblMsg;
}

@end

@implementation ProblemRideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayoutSet];
    lblMsg.hidden = true;
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [ParseHelper getPrivetionRideData:^(NSArray *obje, NSError *error) {
        NSLog(@"object %@",obje);
        for (NSDictionary *dic in obje) {
            NSLog(@"dic  %@",dic);
            PrivecRide *objRide =[[PrivecRide alloc]init];
            [objRide initwithRide:dic];
            [self.ArrayRide addObject:objRide];
        }
        if ((self.ArrayRide.count) == 0) {
            lblMsg.hidden = false;
        } else {
            lblMsg.hidden = true;
        }
        [_objTable reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:true];
    }];
}

-(void)viewWillAppear:(BOOL)animated{

}

#pragma mark - Other Voide Method

- (void)LayoutSet{
    self.objTable.estimatedRowHeight = 200;
    self.objTable.rowHeight = UITableViewAutomaticDimension;
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeLeft];
    self.ArrayRide = [[NSMutableArray alloc]init];
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ArrayRide.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrivecRide *objRide =[self.ArrayRide objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"PrivecRideCell";
    PrivecRideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [GlobleMethod CornarRediationset:cell.imgDP Color:[UIColor blackColor] Rediation:30];
    [GlobleMethod viewshadowandCornarRediation:cell.viewBackground Rediation:3];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGesture:)];
    tapGesture1.numberOfTapsRequired = 1;
    [tapGesture1 setDelegate:self];
    [cell.imgDP addGestureRecognizer:tapGesture1];
    cell.lblDate.text           = objRide.strDate;
    [cell.imgDP sd_setImageWithURL:[NSURL URLWithString:objRide.strDP]];
    cell.lblName.text           = objRide.strName;
    if (objRide.strPrice != nil) {
        cell.lblPrice.text          = [GlobleMethod stringWithPointValue:[objRide.strPrice floatValue]];
    } else {
        cell.lblPrice.text          = @"Ride Cancelled";
    }
    cell.lblAddressTo.text      = objRide.strDrop;
    cell.lblAddressFrom.text    = objRide.strpickup;
    return cell;
}
-(void)tapGesture:(UITapGestureRecognizer *)sender{
    [EXPhotoViewer showImageFrom:(UIImageView *)sender.view];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PrivecRide *objRide = self.ArrayRide[indexPath.row];;
    NSString *URLEMail = [NSString stringWithFormat:@"mailto:ankurgecr@gmail.com?subject=Ride OTG | Issue with trip id %@ - ios", objRide.strRiderObjID];
    NSString *url = [URLEMail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication]  openURL:[NSURL URLWithString: url]];
    /*ProblemPrideDetailVC *objRide =[self.storyboard instantiateViewControllerWithIdentifier:@"ProblemPrideDetailVC"];
    objRide.dictData = self.ArrayRide[indexPath.row];
    [self.navigationController pushViewController:objRide animated:YES];*/
}

#pragma mark - All Button Action

- (IBAction)onClickMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
