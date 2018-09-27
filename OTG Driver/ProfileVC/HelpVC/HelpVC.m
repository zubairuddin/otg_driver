//
//  HelpVC.m
//  Ride OTG
//
//  Created by Vijay on 21/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "HelpVC.h"
#import "LegalCell.h"
#import "FAQVC.h"
#import "ProblemRideVC.h"

@interface HelpVC ()

@end

@implementation HelpVC

- (void)viewDidLoad {
    arrTitel = [[NSMutableArray alloc]initWithObjects:@"Problem with a Ride", @"FAQ", nil];
}

- (void)LayoutSet{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeLeft];
}
-(void)viewWillAppear:(BOOL)animated{
    [self tableviewReload];
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrTitel.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"LegalCell";
    LegalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.lbltitle.text = [NSString stringWithFormat:@"%@",[arrTitel objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableviewReload{
    
    if (self.objTable.delegate == nil) {
        self.objTable.delegate = self;
        self.objTable.dataSource = self;
    }
    [self.objTable reloadData];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ProblemRideVC *obje =[self.storyboard instantiateViewControllerWithIdentifier:@"ProblemRideVC"];
        [self.navigationController pushViewController:obje animated:YES];
    }else if (indexPath.row == 1) {
        FAQVC *term =[self.storyboard instantiateViewControllerWithIdentifier:@"FAQVC"];
        [self.navigationController pushViewController:term animated:YES];
    }
}

#pragma mark - All Button Action

- (IBAction)onClickMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
