//
//  LiabilitiesVC.m
//  OTG Driver
//
//  Created by Ankur on 02/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "LiabilitiesVC.h"
#import "GlobleMethod.h"
#import "ParseHelper.h"
#import "Driver.h"
#import "UserDetailsModal.h"

@interface LiabilitiesVC ()

@end

@implementation LiabilitiesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![kUserDetails.objDriverM.liability isEqualToString:@""]) {
        [self.imgliabities sd_setImageWithURL:[NSURL URLWithString:kUserDetails.objDriverM.liability] placeholderImage:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [ self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - UIBUTTON Action

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updateinfomation:(id)sender {
    
     if (self.imgliabities.image == nil){
        [GlobleMethod showAlert:self andMessage:@"Please selecte Liabilities picture"];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [ParseHelper EditLiability:self.imgliabities completion:^(PFObject *obje, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (obje && error == nil) {
                Driver *driver =[[Driver alloc]init];
                NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
                temp1 = obje;
                [driver initwithLogineDetaile:temp1];
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"Information update sucessfull " preferredStyle:UIAlertControllerStyleAlert];
                
                [actionSheet addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                }]];
                [self presentViewController:actionSheet animated:YES completion:nil];
                
            }else{
                [GlobleMethod showAlert:self andMessage:error];
            }
        }];
    }
}

- (IBAction)imageupload:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    actionSheet.title = nil;
    actionSheet.message = nil;
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Camera button tapped.
        UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Select from Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        // Select from Library button tapped.
        UIImagePickerController * picker = [[UIImagePickerController alloc] init] ;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:^{}];
        
    }]];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - Selecting Image from Camera and Library

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.imgliabities.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
      // Picking Image from Camera/ Library
    [picker dismissViewControllerAnimated:YES completion:^{}];
}


@end
