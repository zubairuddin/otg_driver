//
//  FareDetailsVC.m
//  Ride OTG
//
//  Created by admin on 10/03/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "FareDetailsVC.h"

#import "CabType.h"
#import "AppDelegate.h"
#import "GlobleMethod.h"
#import "PayReciptCell.h"

@interface FareDetailsVC (){
    IBOutlet UITableView        *tblView;
    NSMutableArray              *arrayPaymentRecipt;
    IBOutlet NSLayoutConstraint *consTblHeight;
    
    IBOutlet UILabel            *lblTotal;
    IBOutlet UILabel            *lblCabNm;
    
    IBOutlet UIImageView        *imgCabImg;
    
    AppDelegate                 *appDelegate;
}
@end

@implementation FareDetailsVC

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate         =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    arrayPaymentRecipt = [[NSMutableArray alloc] init];
    [tblView registerNib:[UINib nibWithNibName:@"PayReciptCell" bundle:nil] forCellReuseIdentifier:@"PayReciptCell"];
    tblView.tableFooterView     = [[UIView alloc] initWithFrame:CGRectZero];
    NSMutableArray *tmpArray    = [[NSMutableArray alloc] initWithArray:[self.dictDetails objectForKey:@"charges"]];
    
    for (NSDictionary *dictPayment in tmpArray) {
//        [myCell.imageCab sd_setImageWithURL:[NSURL URLWithString:objCar1.strCarType] placeholderImage:nil];
        [self getRideFareInBackground:dictPayment[@"title"] subtitle:dictPayment[@"detail"] Price:[dictPayment[@"amount"] floatValue]];
    }
    
    for (CabType *cabType in appDelegate.arryAllCab) {
        if (cabType.strCarType == [_dictDetails[@"cabType"] intValue]) {
            [imgCabImg sd_setImageWithURL:[NSURL URLWithString:cabType.strCabImgUrl] placeholderImage:nil];
            lblCabNm.text = cabType.strTitle;
            break;
        }
    }
    
    lblTotal.text = [GlobleMethod stringWithPointValue:[_dictDetails[@"totalAmount"] floatValue]];
    consTblHeight.constant = arrayPaymentRecipt.count*52;
    [tblView reloadData];
}

-(void)getRideFareInBackground:(NSString *)title subtitle:(NSString *)subTitle Price:(float)price {
    NSMutableDictionary *dicPaymetnRecipt = [NSMutableDictionary new];
    [dicPaymetnRecipt setObject:title forKey:@"Title"];
    [dicPaymetnRecipt setObject:subTitle forKey:@"SubTitle"];
    [dicPaymetnRecipt setObject:[NSNumber numberWithFloat:price] forKey:@"Price"];
    [arrayPaymentRecipt addObject:dicPaymetnRecipt];
}

-(IBAction)btnBackClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tablViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayPaymentRecipt.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PayReciptCell *cell = (PayReciptCell *)[tableView dequeueReusableCellWithIdentifier:@"PayReciptCell"];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"PayReciptCell" owner:self options:nil];
    }
    NSMutableDictionary *dictData = [[NSMutableDictionary alloc] initWithDictionary:arrayPaymentRecipt[indexPath.row]];
    cell.lblTitle.text = [dictData valueForKey:@"Title"];
    cell.lblPrice.text = [GlobleMethod stringWithPointValue:[[dictData valueForKey:@"Price"] floatValue]];
    if ([dictData valueForKey:@"SubTitle"]) {
        cell.lblSubTitle.text = [dictData valueForKey:@"SubTitle"];
    }
    return cell;
}

@end
