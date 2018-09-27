//
//  RegisterProfileVC.h
//  OTG Driver
//
//  Created by Ankur on 25/10/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterProfileVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSString *strButtonTag;
    NSMutableArray *arrayOfGender;
    NSString *strGender;
    NSDate *dob, *licenseDate, *carRegDate, *wayBillDate;
}
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

@property (weak, nonatomic) IBOutlet UIImageView *imageDp;
@property (weak, nonatomic) IBOutlet UIImageView *imageCar;
@property (weak, nonatomic) IBOutlet UIImageView *imageLicense;
@property (weak, nonatomic) IBOutlet UIImageView *imageCarRegistation;
@property (weak, nonatomic) IBOutlet UIImageView *imageLiabilty;
@property (weak, nonatomic) IBOutlet UITextField *txtSSN;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtContact;
@property (weak, nonatomic) IBOutlet UITextField *txtBOD;
@property (weak, nonatomic) IBOutlet UIButton *btnGender;
@property (weak, nonatomic) IBOutlet UITextField *txtCorModel;
@property (weak, nonatomic) IBOutlet UITextField *txtCarRegistrationNum;
@property (weak, nonatomic) IBOutlet UIButton *btnLicense;
@property (weak, nonatomic) IBOutlet UIButton *btnCarRegistration;
@property (weak, nonatomic) IBOutlet UIButton *btnLiability;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *txtLlicenseDate;
@property (weak, nonatomic) IBOutlet UITextField *txtCarRegDate;
@property (weak, nonatomic) IBOutlet UITextField *txtLiabilityDate;

@property (weak, nonatomic) IBOutlet UIView *viewGender;
@property (weak, nonatomic) IBOutlet UIPickerView *PickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *PickerviewDate;
@property (weak, nonatomic) IBOutlet UIView *viewDOB;
@property BOOL IsDodument;
@property BOOL isCommingFromProfile;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDateDone;

@end
