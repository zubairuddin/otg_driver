//
//  LegalVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 05/04/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "LegalVC.h"
#import "ProfileCell.h"
#import "ProfileVC.h"
#import "HelpVC.h"
#import "AppLicenseVC.h"
#import "TermAndCondition.h"

@interface LegalVC ()

@end

@implementation LegalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayoutSet];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark Othe Method

-(void)LayoutSet{
    self.ArrayMenu =[[NSMutableArray alloc] initWithObjects:@"Terms and Conditions",@"Privacy Policy",@"Licenses", nil];
    [self tableviewReload];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ArrayMenu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ProfileCell";
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.lblTitle.text =[self.ArrayMenu objectAtIndex:indexPath.row];
    cell.imageMenu.tintColor = [UIColor blackColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        TermAndCondition *objTerm =[self.storyboard instantiateViewControllerWithIdentifier:@"TermAndCondition"];
        objTerm.title = @"Terms and Conditions";
        [self.navigationController presentViewController:objTerm animated:YES completion:nil];
    }else if (indexPath.row == 1) {
        TermAndCondition *objTerm =[self.storyboard instantiateViewControllerWithIdentifier:@"TermAndCondition"];
        objTerm.title = @"Privacy Policy";
        [self.navigationController presentViewController:objTerm animated:YES completion:nil];
    }else if (indexPath.row == 2) {
        AppLicenseVC *Licences =[self.storyboard instantiateViewControllerWithIdentifier:@"AppLicenseVC"];
        [self.navigationController presentViewController:Licences animated:YES completion:nil];
    }
}

-(void)tableviewReload {
    if (self.objTable.delegate == nil) {
        self.objTable.delegate = self;
        self.objTable.dataSource = self;
    }
    [self.objTable reloadData];
    
}


- (IBAction)Back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
