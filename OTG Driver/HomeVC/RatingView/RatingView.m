//
//  RatingView.m
//  Ride OTG
//
//  Created by Vijay on 26/12/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView {
    NSMutableDictionary *dictFinalData;
}

#pragma mark - Init Method
-(void)drawRect:(CGRect)rect {
    _lblBottomtxtView.hidden = true;
    _viewRate.delegate = self;
    [GlobleMethod CornarRediationset:_imageDp Color:[UIColor blackColor] Rediation:30];
    [_txtView setContentOffset:CGPointZero animated:NO];
}

-(void)updateData:(NSMutableDictionary *)dictData {
    dictFinalData = [[NSMutableDictionary alloc] initWithDictionary:dictData];
    _lblPickupLocation.text     = dictData[@"pickupLocation"];
    _lblDropLocation.text       = dictData[@"dropLocation"];
    _lblTipFor.text             = [NSString stringWithFormat:@"Add a tip for %@", dictData[@"driverName"]];
    _lblnameDriver.text         = dictData[@"driverName"];
    [_imageDp sd_setImageWithURL:[NSURL URLWithString:dictData[@"DP"]]];
    if (IS_NOT_NULL(dictData, @"rate")) {
        _viewRate.rating = [dictData[@"rate"] floatValue];
    } else {
        _viewRate.rating = 0.0;
    }
}

#pragma mark - textFieldDelegate Event
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

#pragma mark - textViewDelegate Event
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"Tell us about your exprience"]){
        textView.text = @"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}

#pragma mark - Switch Chnage event
- (IBAction)changeSwitch:(id)sender{
    if([sender isOn]) {
        _consTxtvHeight.constant    = 67;
        _lblBottomtxtView.hidden    = false;
        _consBGHeight.constant      = _consBGHeight.constant + _consTxtvHeight.constant;
    } else {
        _consBGHeight.constant      = _consBGHeight.constant - _consTxtvHeight.constant;
        _lblBottomtxtView.hidden    = true;
        _consTxtvHeight.constant    = 0;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}


#pragma mark - button click
- (IBAction)btnDismissClick:(UIButton *)sender {
    if([self.delegateRate respondsToSelector:@selector(dismissView)]) {
        [self.delegateRate dismissViewWithIndex:_strIndex withRating:[dictFinalData[@"rate"] floatValue]];
    }
}

- (IBAction)btnSubmitClick:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    [ParseHelper getSubmitRatinginPrivetionRideData:[NSNumber numberWithFloat: [dictFinalData[@"rate"] floatValue]] rideID:dictFinalData[@"rideID"] drivreID:dictFinalData[@"driverID"] comment:_txtView.text completionBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [MBProgressHUD hideHUDForView:self animated:YES];
        if([self.delegateRate respondsToSelector:@selector(dismissViewWithIndex:withRating:)]) {
            [self.delegateRate dismissViewWithIndex:_strIndex withRating:[dictFinalData[@"rate"] floatValue]];
        }
        if (error != nil) {
//            [GlobleMethod showAlert:a andMessage:[NSString stringWithFormat:@"%@",error.localizedDescription]];
        }
    }];
}

-(void)rateView:(RateView *)rateView didUpdateRating:(float)rating {
    dictFinalData[@"rate"] = [NSNumber numberWithFloat:rating];
}


@end

