//
//  PickupArrivedView.h
//  OTG Driver
//
//  Created by Vijay on 06/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickupArrivedView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIImageView *imgRider;
@property (weak, nonatomic) IBOutlet UILabel *lblRiderName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *btnRiderImage;

//New Slider View
@property (weak, nonatomic) IBOutlet UIView *objSilderMainView;
@property (weak, nonatomic) IBOutlet UIButton *btnSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblSliderTitle;

@end
