//
//  FAQVC.m
//  RideFAQ OTG
//
//  Created by Vijay on 21/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "FAQVC.h"
#import "FAQ.h"
#import "FAQCell.h"
#import "GlobleMethod.h"

@interface FAQVC ()

@end

@implementation FAQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arraAllFAQ =[[NSMutableArray alloc]init];
    self.objTable.estimatedRowHeight = 200;
    self.objTable.rowHeight = UITableViewAutomaticDimension;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ParseHelper getFAQData:^(NSArray *obje, NSError *error) {
        if (obje && error == nil) {
            
            NSMutableArray *result =[NSMutableArray new];
            result =obje;
            [self allFAQ:result];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [GlobleMethod showAlert:self andMessage:error];
        }
        
    }];
    
}

-(void)allFAQ:(NSMutableArray *)result{
    NSLog(@"result    %@",result);
    for ( int i = 0; i< result.count; i++ ) {
        FAQ *lic =[[FAQ alloc]init];
        PFObject *pfobj = [result objectAtIndex:i];
        lic.strobjectID =pfobj.objectId;
        lic.strTitle = [[result objectAtIndex:i] valueForKey:@"question"];
        lic.strSubTitle = [[result objectAtIndex:i] valueForKey:@"answer"];
        [self.arraAllFAQ addObject:lic];
    }
    NSLog(@"self.arraAllFAQ  %ld",self.arraAllFAQ.count);
    [self tableviewReload];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark - UITableView Data Source
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arraAllFAQ.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"FAQCell";
    FAQCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    FAQ *lic = [self.arraAllFAQ objectAtIndex:indexPath.row];
    
    if (lic.strTitle) {
        cell.lbltitle.text = [NSString stringWithFormat:@"%@",lic.strTitle];
    }
    if (lic.strSubTitle) {
        cell.lblSubTitle.text = [NSString stringWithFormat:@"%@",lic.strSubTitle];
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
