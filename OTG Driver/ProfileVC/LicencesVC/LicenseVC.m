//
//  LicenseVC.m
//  Ride OTG
//
//  Created by Vijay on 20/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "LicenseVC.h"
#import "GlobleMethod.h"
#import "License.h"

@interface LicenseVC ()

@end

@implementation LicenseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arraAllLicense =[[NSMutableArray alloc]init];
    [ParseHelper getLicenseData:^(NSArray *obje, NSError *error) {
        
        if (obje && error == nil) {
            NSMutableArray *result =[NSMutableArray new];
            result =obje;
            [self allLicense:result];
        }else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [GlobleMethod showAlert:self.view andMessage:error];
        }
        
    }];
    
}

-(void)allLicense:(NSMutableArray *)result{
    
    self.arraAllLicense =[[NSMutableArray alloc]init];
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
}
@end
