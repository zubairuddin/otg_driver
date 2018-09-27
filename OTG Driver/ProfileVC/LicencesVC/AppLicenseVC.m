//
//  AppLicenseVC.m
//  Ride OTG
//
//  Created by Vijay on 20/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "AppLicenseVC.h"
#import "GlobleMethod.h"
#import "License.h"
#import "LicensCell.h"
@interface AppLicenseVC ()

@end

@implementation AppLicenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arraAllLicense =[[NSMutableArray alloc]init];
    self.objTable.estimatedRowHeight = 200;
    self.objTable.rowHeight = UITableViewAutomaticDimension;
    
    [ParseHelper getLicenseData:^(NSArray *obje, NSError *error) {

        if (obje && error == nil) {
            NSMutableArray *result =[NSMutableArray new];
            result =obje;
            [self allLicense:result];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [GlobleMethod showAlert:self andMessage:error];
        }

    }];

}

-(void)allLicense:(NSMutableArray *)result{
    
    NSLog(@"result    %@",result);
    
    for ( int i = 0; i< result.count; i++ ) {
        License *lic =[[License alloc]init];
        PFObject *pfobj = [result objectAtIndex:i];
        lic.strobjectID =pfobj.objectId;
        lic.strTitle = [[result objectAtIndex:i] valueForKey:@"title"];
        lic.strSubTitle = [[result objectAtIndex:i] valueForKey:@"subtitle"];
        lic.strDescripation = [[result objectAtIndex:i] valueForKey:@"content"];
        [self.arraAllLicense addObject:lic];
    }
    NSLog(@"self.arraAllLicense  %ld",self.arraAllLicense.count);
     [self tableviewReload];
}


#pragma mark - UITableView Data Source
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arraAllLicense.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LicensCell";
    LicensCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    License *lic = [self.arraAllLicense objectAtIndex:indexPath.row];
    
    if (lic.strTitle) {
        cell.lbltitle.text = [NSString stringWithFormat:@"%@",lic.strTitle];
    }
    if (lic.strSubTitle) {
        cell.lblSubTitle.text = [NSString stringWithFormat:@"%@",lic.strSubTitle];
    }
    if (lic.strDescripation) {
        cell.lblDesCripation.text = [NSString stringWithFormat:@"%@",lic.strDescripation];
    }
    
    return cell;
}

-(void)tableviewReload{

    if (self.objTable.delegate == nil) {
        self.objTable.delegate = self;
        self.objTable.dataSource = self;
    }
    [self.objTable reloadData];

}

#pragma mark - All Button Action

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
