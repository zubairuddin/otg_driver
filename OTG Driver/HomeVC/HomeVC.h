//
//  HomeVC.h
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobleMethod.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "PickupArrivedView.h"
#import "RideStartesView.h"
#import "RatingView.h"
//#import "ArriveView.h"
#import <CMSwitchView.h>
#import "RateView.h"
#import "ORBVisualTimer.h"

//#import <CoreLocation/CoreLocation.h>
@import Firebase;
typedef void(^addressCompletion)(NSString *);

typedef enum {
    arrivedToPick = 0,
    startRide,
    reachedToDestination
}RideState;

@interface HomeVC : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate,AVAudioPlayerDelegate,CMSwitchViewDelegate>{
    
    GMSMapView * gmsMapView;
    GMSPolyline *polyline;
    GMSPath *path;
    
    AppDelegate *appDelegate;
    CLLocationManager *locationManager;
    float currentlat;
    float currentlog;
    float Previouslat;
    float Previouslog;
    double Pickup_lat;
    double pickup_long;
    
    int rating;
    NSInteger CountNumber;
    NSTimer *counterTimer;
    BOOL isUpadateLoc;
    
    NSString *strdeleteRideId, *strRiderName ,*strPickUpLocation ,*strDropLocation, *strRiderDp ,*strParse_obj_Firebase,*strOpenMapPlat,*strOpenMapPLong,*strOpenMapDLat,*strOpeMapDLong, *strDriverRatings;
    AVAudioPlayer *_audioPlayerAlert;
    AVAudioPlayer *_audioPlayerMeepMeep;
}

@property (nonatomic , readwrite) RideState rideState;
@property (weak, nonatomic) IBOutlet UIView *viewMap;
@property (weak, nonatomic) IBOutlet UIView *ViewOnOff;
@property (weak, nonatomic) IBOutlet UIView *ViewVerified;
@property (weak, nonatomic) IBOutlet UIImageView *imgCabType;
@property (weak, nonatomic) IBOutlet UIButton *btnRideOnOff;
@property (weak, nonatomic) IBOutlet UISwitch *switchOnOff;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) FIRDatabaseReference * cabReference;
@property (strong, nonatomic) FIRDatabaseReference * cabTypeReference;
@property (strong, nonatomic) FIRDatabaseReference * rideRequestReference;
@property (strong, nonatomic) FIRDatabaseReference * rideRefeference;

@property (retain, nonatomic) NSString *cabId;
@property (retain, nonatomic) NSString *rideRequestId;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *location;


// POPup Ride Request

@property (weak, nonatomic) IBOutlet UIView *viewPopUp;
@property (weak, nonatomic) IBOutlet UILabel *lblPickUp;
@property (weak, nonatomic) IBOutlet UILabel *lblDrop;
@property (weak, nonatomic) IBOutlet UIImageView *imageRideIcone;
@property (weak, nonatomic) IBOutlet UIView *viewProgress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewInnerProgressTrailing;
@property (weak, nonatomic) IBOutlet UIView *viewInnerProgress;
@property (weak, nonatomic) IBOutlet UIImageView *imgRideRequest;
@property (weak, nonatomic) IBOutlet UIView *objRideTitleBackView;
@property (weak, nonatomic) IBOutlet UIButton *btnRideAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnRideCancel;
@property (weak, nonatomic) IBOutlet RateView *objRateView;

@property (weak, nonatomic) IBOutlet UIImageView *imageDp;
@property (weak, nonatomic) IBOutlet UILabel *lblRiderName;

@property NSMutableDictionary *dicAcceptRide;

// popup  PickupArrivedView

@property (weak, nonatomic) PickupArrivedView   *viewPickup;
@property (weak, nonatomic) RatingView          *viewRating;


@property (weak, nonatomic) IBOutlet UIView *viewEmer;
@property (weak, nonatomic) IBOutlet UIButton *btnEmer;
@property (weak, nonatomic) IBOutlet UILabel *lblDestination;
@property (weak, nonatomic) IBOutlet UIView *viewTimer;
@property (weak, nonatomic) IBOutlet UILabel *lblTimer;
@property (weak, nonatomic) IBOutlet UIButton *btnEmer2;
@property (weak, nonatomic) IBOutlet UIButton *btnGoogleMapApp;
@property (retain, nonatomic) NSMutableArray *arrayRoutes;



//New Slider View
@property (weak, nonatomic) IBOutlet UIView *objSilderView;
@property (weak, nonatomic) IBOutlet UIView *objSilderMainView;
@property (weak, nonatomic) IBOutlet UIButton *btnSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblSliderTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewOnOffBottonConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnTopConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewEmrTopConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTimerTopConstant;

-(void)removeRideRequest;
typedef void(^isSuccess)(BOOL);
@end
