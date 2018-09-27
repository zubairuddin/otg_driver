//
//  PrivecRideVC.m
//  Ride OTG
//
//  Created by Ankur on 22/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "PrivecRide.h"
#import "PrivecRideVC.h"
#import "GlobleMethod.h"
#import "FareDetailsVC.h"
#import "PrivecRideCell.h"
#import <HCSStarRatingView/HCSStarRatingView.h>

@interface PrivecRideVC () <rateDelegate, UIGestureRecognizerDelegate> {
    IBOutlet UILabel *lblMsg;
    UIImage          *img;
    NSString         *strObjId;
}

@end

@implementation PrivecRideVC

#pragma mark - ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    lblMsg.hidden = true;
    [self LayoutSet];
    [self loadRatingView];
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [ParseHelper getPrivetionRideData:^(NSArray *obje, NSError *error) {
        for (PFObject *pfObj in obje) {
            PrivecRide *objRide =[[PrivecRide alloc]init];
            [objRide initwithRide:pfObj];
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

#pragma mark - Other Voide Method
- (void)LayoutSet {
    self.objTable.estimatedRowHeight = 200;
    self.objTable.rowHeight = UITableViewAutomaticDimension;
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeLeft];
    self.ArrayRide = [[NSMutableArray alloc]init];
    [_objTable reloadData];
}

-(void)loadRatingView {
    self.viewRating = [[[NSBundle mainBundle] loadNibNamed:@"RatingView" owner:self options:nil] objectAtIndex:0];
    self.viewRating.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.viewRating.delegateRate = self;
    self.viewRating.viewRate.starSize           = 30.0;
    self.viewRating.viewRate.padding            = 7.0;
    self.viewRating.viewRate.step               = 0.5;
    self.viewRating.viewRate.starFillColor      = PrimaryAccetColor;
    self.viewRating.viewRate.starBorderColor    = PrimaryAccetColor;
    self.viewRating.viewRate.canRate            = true;
    [GlobleMethod CornarRediationset:self.viewRating.imageDp Color:[UIColor blackColor] Rediation:30];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewRating.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
     self.viewRating.hidden = YES;
    [self.view addSubview:self.viewRating];
}
- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
   // [self.navigationController popViewControllerAnimated:YES];
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
        cell.consBtnHeight.constant = 50.0;
    } else {
        cell.lblPrice.text          = @"Ride Cancelled";
        cell.consBtnHeight.constant = 0.0;
    }
    if (objRide.strOverAll == nil) {
        cell.btnRate.hidden = false;
        cell.rateView.hidden = true;
    } else {
        cell.btnRate.hidden = true;
        cell.rateView.hidden = false;
        cell.rateView.starSize           = 15.0;
        cell.rateView.padding            = 3.0;
        cell.rateView.step               = 0.5;
        cell.rateView.starFillColor      = PrimaryAccetColor;
        cell.rateView.starBorderColor    = PrimaryAccetColor;
        cell.rateView.canRate            = false;
        cell.rateView.rating             = [objRide.strOverAll floatValue];
    }
    cell.lblAddressTo.text      = objRide.strDrop;
    cell.lblAddressFrom.text    = objRide.strpickup;
    cell.btnRate.tag = indexPath.row;
    [cell.btnRate addTarget:self action:@selector(rateAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnRate.layer setValue:[NSNumber numberWithInteger:indexPath.row] forKey:@"INDEX"];
    cell.btnFare.tag = indexPath.row;
    [cell.btnFare addTarget:self action:@selector(btnFareDetails:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tapGesture:(UITapGestureRecognizer *)sender{
    [EXPhotoViewer showImageFrom:(UIImageView *)sender.view];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FareDetailsVC *fareDetailVC = [segue destinationViewController];
    fareDetailVC.dictDetails = sender;
}

#pragma mark - All Button Action
- (IBAction)onClickMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)btnFareDetails:(UIButton *)sender {
    PrivecRide *objRide =[self.ArrayRide objectAtIndex:sender.tag];
    NSMutableDictionary *dictFareDetails = [[NSMutableDictionary alloc] initWithDictionary:objRide.dictPaymentDetails];
    [dictFareDetails setValue:[NSNumber numberWithInt:objRide.strCabType] forKey:@"cabType"];
    [self performSegueWithIdentifier:@"detailsIdentifier" sender:dictFareDetails];
}

- (IBAction)rateAction:(UIButton *)sender{
    NSInteger index =[sender tag];
    PrivecRide *objRide =[self.ArrayRide objectAtIndex:index];
    NSMutableDictionary *dictData   = [[NSMutableDictionary alloc] init];
    dictData[@"pickupLocation"]     = objRide.strpickup;
    dictData[@"dropLocation"]       = objRide.strDrop;
    dictData[@"driverName"]         = objRide.strName;
    dictData[@"DP"]                 = objRide.strDP;
    dictData[@"rate"]               = 0;
    dictData[@"rideID"]             = objRide.strTripID;
    dictData[@"driverID"]           = objRide.strRiderObjID;
    strObjId                        = objRide.strRiderObjID;
    
    self.viewRating.strIndex        = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    [self.viewRating updateData:dictData];
    self.viewRating.hidden          = NO;
    self.viewRating.alpha           = 0.0;
    [UIView animateWithDuration:0.2 animations:^{
        self.viewRating.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)submitRating{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:[NSNumber numberWithInt:rating] forKey:@"rating_overall_driver"];
//    [dic setValue:strObjId forKey:@"parse_obj_Firebase"];
    [dic setValue:strObjId forKey:@"prase_object_id"];
    
//    NSLog(@"strParse_obj_Firebase  %@",strParse_obj_Firebase);
    [ParseHelper ratingSubmint:dic completion:^(NSArray *obje, NSError *error) {
        if (obje && error == nil) {
            //            self.viewRating.hidden = YES;
            [self.viewRating removeFromSuperview];
        }else{
            [GlobleMethod showAlert:self andMessage:ErrorMessage];
        }
    }];
}

#pragma mark - dismissView
-(void)dismissView {
    [UIView animateWithDuration:0.2 animations:^{
        self.viewRating.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.viewRating removeFromSuperview];
    }];
}

- (void)RatingDismiss{
    self.viewRating.hidden = YES;
}

#pragma mark - HCSStarRatingView dalegate Methord
- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    rating = [NSNumber numberWithInt:sender.value];
}


#pragma mark - dismissView
-(void)dismissViewWithIndex:(NSString *)index withRating:(float)rating {
    PrivecRide *objRide = self.ArrayRide[[index intValue]];
    objRide.strOverAll  = [NSNumber numberWithFloat:rating];
    [self.ArrayRide replaceObjectAtIndex:[index intValue] withObject:objRide];
    [_objTable beginUpdates];
    [_objTable reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:[index intValue] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [_objTable endUpdates];
    [UIView animateWithDuration:0.2 animations:^{
        self.viewRating.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.viewRating.hidden = YES;
    }];
}

@end
