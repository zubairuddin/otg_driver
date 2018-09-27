//
//  CountryVC.h
//  OTG Driver
//
//  Created by Amit Prajapati on 19/03/18.
//  Copyright © 2018 Vijay. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol CountryDelegate<NSObject>

@required
- (void)selectedCountry :(NSString*)countryCode imageName:(NSString*)imgCountryLogo;

@end

@interface CountryVC : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblCountryList;
@property (nonatomic, weak) id <CountryDelegate> delegate;

@end
