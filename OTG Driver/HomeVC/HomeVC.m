//
//  HomeVC.m
//  OTG Driver
//
//  Created by Ankur on 01/09/17.
//  Copyright © 2017 Vijay. All rights reserved.


#import "HomeVC.h"
#import "Cab.h"
#import "SimpleLatLng.h"
#import "KIProgressViewManager.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "ORBVisualTimer.h"
#import "PrivecRide.h"
#import "AFHTTPSessionManager.h"
#import "Routes.h"
#import "CabType.h"
#import "BankAccountDetailsVC.h"
#import "Driver.h"
#import "Constant.h"
#import "UserDetailsModal.h"

@interface HomeVC () <ORBVisualTimerDelegate,rateDelegate,UIGestureRecognizerDelegate> {
    bool isFromDestination;
    ORBVisualTimerBar *barTimer;
    bool timerInActive, isRideReject;
    NSString* strToPostalCode;
    int indexRoute;
    bool firstTime, rideCanceled;
    BOOL isEnabledSendBox;
    NSDictionary *objDriver;
}
@property (weak, nonatomic) IBOutlet UILabel *lblLoginRoom;
@property (weak, nonatomic) IBOutlet UILabel *lblSendBox;
@property (retain, nonatomic) NSMutableArray *arrayCabTypes;

@end


@implementation HomeVC
@synthesize imgCabType;

- (void)viewDidLoad {
    if(IS_IPHONE_X){
        self.viewOnOffBottonConstant.constant = -36.0;
        self.btnTopConstant.constant = 40.0;
        self.viewEmrTopConstant.constant = 40.0;
        self.viewTimerTopConstant.constant = 40.0;
    }else{
        self.btnTopConstant.constant = 20.0;
        self.viewEmrTopConstant.constant = 20.0;
        self.viewTimerTopConstant.constant = 20.0;
    }
    
    firstTime = TRUE;
    rideCanceled = false;
    isRideReject = false;
    
    [super viewDidLoad];
    
    objDriver = [[NSDictionary alloc] init];
    
    isEnabledSendBox = [kUserDetails.objDriverM.enableSandboxPaymentBraitree boolValue];
    
    self.lblSendBox.hidden = isEnabledSendBox ? NO : YES;
    
    self.arrayCabTypes      = [[NSMutableArray alloc]init];
    self.arrayRoutes        = [[NSMutableArray alloc]init];
    self.objSilderView.hidden = true;
    self.objSilderMainView.backgroundColor = PrimaryAccetColor;
    self.objSilderMainView.layer.cornerRadius = 25;
    self.btnSlider.frame = CGRectMake(5, 5, 60, 40);
    self.btnSlider.layer.cornerRadius = 20;
    [self.btnSlider setImage:[UIImage imageNamed:@"ic_hourglass_empty"] forState:UIControlStateNormal];
    self.btnSlider.tag = arrivedToPick;
    [self.btnSlider addTarget:self action:@selector(btnSliderChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.view.tag = arrivedToPick;
    [self.btnSlider addGestureRecognizer:swipeRight];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(LayoutSet)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeRideRequest)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkIfBankDetailsEntered)
                                                 name:@"checkBankDetails"
                                               object:nil];
    
    
    //    BOOL isRideExist = [GlobleMethod getValueFromUserDefault:@"IS_RIDE_EXIST"];
    //    if (isRideExist)
    [self checkIFRideExist];
    [self getAllCabType];
    [self setCarTypeImag];
    [self LayoutSet];
    [self googleMapviewSetup];
    [self.view layoutIfNeeded];
    [GlobleMethod CornarRediationset:self.imageDp Color:[UIColor blackColor] Rediation:25];
    
    self.objRideTitleBackView.backgroundColor = PrimaryAccetColor;
    self.btnRideAccept.backgroundColor = PrimaryDarkColor;
    self.btnRideCancel.backgroundColor = PrimaryDarkColor;
        
    NSDictionary *dict = [[NSMutableDictionary alloc] init];
    dict = (NSMutableDictionary*)kUserDetails.objDriverM;
    NSLog(@"%@", dict);
    
    NSLog(@"is_varified string:--> %@",kUserDetails.objDriverM.isVarified);
    NSLog(@"is_varified bool  :--> %d",[kUserDetails.objDriverM.isVarified boolValue]);
   
    
//    if ([kUserDetails.objDriverM.isVarified boolValue]) {
    BOOL isVerified = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isVerified"] boolValue];
    if(isVerified){
        self.ViewVerified.hidden = YES;
        self.ViewOnOff.hidden = NO;
    }else{
        self.ViewVerified.hidden = NO;
        self.ViewOnOff.hidden = YES;
    }
    
    [self audioLoad];
    [GlobleMethod CornarRediationset:self.btnEmer Color:[UIColor clearColor] Rediation:22];
    [GlobleMethod CornarRediationset:self.btnEmer2 Color:[UIColor clearColor] Rediation:22];
    
    self.lblLoginRoom.text = [GlobleMethod getValueFromUserDefault:@"MODE"];
    NSLog(@"%@", [GlobleMethod getValueFromUserDefault:@"MODE"]);
}

- (void)viewWillAppear:(BOOL)animated{
    if (!firstTime){
        self.viewOnOffBottonConstant.constant = 0.0;
        [self setCarTypeImag];
    }
    [self LayoutSet];
    isEnabledSendBox = [kUserDetails.objDriverM.enableSandboxPaymentBraitree boolValue];
    self.lblSendBox.hidden = isEnabledSendBox ? NO : YES;
}

-(void)viewDidAppear:(BOOL)animated{
    //    [self.view layoutIfNeeded];
}

- (void)didSwipe:(UISwipeGestureRecognizer*)swipe{
    // First we must calculate the new position relative to the current position.
    CGRect rect = CGRectMake(self.btnSlider.frame.origin.x, self.btnSlider.frame.origin.y, self.btnSlider.frame.size.width, self.btnSlider.frame.size.height);
    rect.origin.x = rect.origin.x + (self.objSilderMainView.frame.size.width - self.btnSlider.frame.size.width);
    
    switch ([swipe.view tag]) {
        case arrivedToPick:
            [self switchonPickupArrived];
            self.btnSlider.tag = startRide;
            break;
        case startRide:
            [self switchonrideStartes];
            self.btnSlider.tag = reachedToDestination;
            break;
        case reachedToDestination:
            [self switchonrideArriveToDestination];
            self.btnSlider.tag = arrivedToPick;
            break;
        default:
            break;
    }
    
    // Start the animation
    
    [UIView animateWithDuration:0.5f delay:0.0f options:nil animations:^{
        // Changing the position
        self.btnSlider.frame = rect;
        self.lblSliderTitle.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0f];
    } completion:^(BOOL finished) {
        // When it's done we change the button's image ;)
        self.btnSlider.frame = CGRectMake(5, 5, self.btnSlider.frame.size.width , self.btnSlider.frame.size.height);
        self.lblSliderTitle.textColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
        switch ([swipe.view tag]) {
            case arrivedToPick:
                //                [self switchonPickupArrived];
                [self.btnSlider setImage:[UIImage imageNamed:@"ic_hourglass_empty"] forState:UIControlStateNormal];
                self.lblSliderTitle.text = @"Arrived to Pick-Up";
                break;
            case startRide:
                //                [self switchonrideStartes];
                [self.btnSlider setImage:[UIImage imageNamed:@"ic_local_taxi"] forState:UIControlStateNormal];
                self.lblSliderTitle.text = @"Slide to Start Ride";
                break;
            case reachedToDestination:
                //                [self switchonrideArriveToDestination];
                [self.btnSlider setImage:[UIImage imageNamed:@"ic_payment"] forState:UIControlStateNormal];
                self.lblSliderTitle.text = @"Slide When Drop-Off Is Complete";
                break;
            default:
                break;
        }
    }];
}

- (IBAction)btnSliderChanged:(id)sender{
}

// Change the position of the view on click with an animation
// _hidden is a private variable which is initalized to NO in the constructor.
- (void)onClickAction:(UIButton *)button
{
    
}

-(void)LayoutSet{
    [self.view layoutIfNeeded];
    
    if(firstTime){
        [self.switchOnOff setOn:FALSE];
    }
    
    firstTime = FALSE;
    NSString *strTemp = [[NSUserDefaults standardUserDefaults] valueForKey:kisDriverRemoved];
    if ([strTemp  isEqual: @"1"]){
        [self.switchOnOff setOn:FALSE];
    }else if ([strTemp  isEqual: @"2"]){
        if ([self.switchOnOff isOn]){
            [self firdatabaseSetup:TRUE];
        }
    }
}

-(void)removeRideRequest{
    self.viewPopUp.hidden = TRUE;
    [_audioPlayerAlert stop];
    timerInActive = TRUE;
    [[[self.cabReference child:self.cabId] child:@"rideRequest"] removeValue];
    [self firdatabaseSetup:TRUE];
}

-(void)audioLoad{
    // alert Audio load
    NSString *path = [NSString stringWithFormat:@"%@/alert.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayerAlert = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    //meepmeep Audio load
    NSString *pathMeep = [NSString stringWithFormat:@"%@/meepmeep.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrlMeep = [NSURL fileURLWithPath:pathMeep];
    _audioPlayerMeepMeep = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrlMeep error:nil];
}

-(void)pickupArrivedloadView {
    self.ViewOnOff.hidden = YES;
    self.objSilderView.hidden = false;
    self.viewPickup=[[[NSBundle mainBundle] loadNibNamed:@"PickupArrivedView" owner:self options:nil] objectAtIndex:0];
    self.viewPickup.frame = CGRectMake(0, self.objSilderView.frame.origin.y - 82, [UIScreen mainScreen].bounds.size.width, self.viewPickup.frame.size.height);
    [GlobleMethod CornarRediationset:self.viewPickup.imgRider Color:[UIColor blackColor] Rediation:25];
    [self.view addSubview:self.viewPickup];
    self.viewPickup.hidden = NO;
    
    self.viewPickup.lblRiderName.text = strRiderName;
    [self.viewPickup.imgRider sd_setImageWithURL:[NSURL URLWithString:strRiderDp] placeholderImage:[UIImage imageNamed:@"dp_dummy"]];
    [self.viewPickup.activityIndicator startAnimating];
    self.viewPickup.activityIndicator.hidden = false;
    self.viewPickup.btnCall.hidden = true;
    
    
    [self.viewPickup.btnCancel addTarget:self action:@selector(rideCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewPickup.btnRiderImage addTarget:self action:@selector(openFullImage:) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)openFullImage:(UIButton*)sender{
    [EXPhotoViewer showImageFrom:self.viewPickup.imgRider];
}

-(void)loadRatingView{
    self.viewRating = [[[NSBundle mainBundle] loadNibNamed:@"RatingView" owner:self options:nil] objectAtIndex:0];
    self.viewRating.frame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.viewRating.delegateRate = self;
    self.viewRating.viewRate.starSize           = 30.0;
    self.viewRating.viewRate.padding            = 7.0;
    self.viewRating.viewRate.step               = 0.5;
    self.viewRating.viewRate.starFillColor      = PrimaryAccetColor;
    self.viewRating.viewRate.starBorderColor    = PrimaryAccetColor;
    self.viewRating.viewRate.canRate            = true;
    [GlobleMethod CornarRediationset:self.viewRating.imageDp Color:[UIColor blackColor] Rediation:30];
    
    NSMutableDictionary *dictData   = [[NSMutableDictionary alloc] init];
    dictData[@"pickupLocation"]     = strPickUpLocation;
    dictData[@"dropLocation"]       = strDropLocation;
    dictData[@"driverName"]         = strRiderName;
    dictData[@"DP"]                 = strRiderDp;
    dictData[@"rate"]               = @"0.0";
    dictData[@"rideID"]             = strParse_obj_Firebase;
    dictData[@"driverID"]           = self.dicAcceptRide[@"rider_obj_id"];
    
    [self.viewRating updateData:dictData];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewRating.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
    [self.view addSubview:self.viewRating];
}

#pragma mark - dismissView
-(void)dismissViewWithIndex:(NSString *)index withRating:(float)rating {
    [UIView animateWithDuration:0.2 animations:^{
        self.viewRating.alpha = 0.0;
    } completion:^(BOOL finished) {
        //        rideID = @"";
        //        [self currentLocation:nil];
        [self.viewRating removeFromSuperview];
        //        isRideStart = false;
    }];
}

//#pragma mark - dismissView
//-(void)dismissView {
//    [UIView animateWithDuration:0.2 animations:^{
//        self.viewRating.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [self.viewRating removeFromSuperview];
//    }];
//}


- (void)googleMapviewSetup {
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = 1;
    locationManager.distanceFilter = 1;
    locationManager.delegate = self;
    
    [locationManager startUpdatingLocation];
    [locationManager startUpdatingHeading];
    
    self.location = [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [self.location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSLog(@"dLatitude : %@", latitude);
    NSLog(@"dLongitude : %@",longitude);
    
    if(coordinate.latitude != 0.000000 || coordinate.longitude != 0.000000){
        currentlat = coordinate.latitude;
        currentlog = coordinate.longitude;
        Previouslat = currentlat;
        Previouslog = currentlog;
        if ([self.switchOnOff isOn]){
            [self firdatabaseSetup:YES];
        }
    }
    
    self.location = gmsMapView.myLocation;
    gmsMapView.delegate = self;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:coordinate zoom:17];
    
    gmsMapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    [_viewMap addSubview:gmsMapView];
    gmsMapView.myLocationEnabled = YES;
    //        gmsMapView.settings.myLocationButton = YES;
    //    });
}

-(void)firdatabaseSetup:(BOOL)isAvailable {
    
    if (self.location) {
        
        appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        self.cabReference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
        if ([GlobleMethod getValueFromUserDefault:@"CABID"]) {
            self.cabId = [GlobleMethod getValueFromUserDefault:@"CABID"];
        }else{
            self.cabId = [self.cabReference childByAutoId].key;
            [GlobleMethod setValueFromUserDefault:self.cabId andkey:@"CABID"];
        }
        
        NSMutableDictionary *dicPreviousLatLng = [self setpreviousPositionlocationlatlog];
        NSMutableDictionary *dicCurrentLatLng = [self setcurrenlocationlatlog];
        //        NSMutableDictionary *dicRideRequest = [self setRideRequest];
        NSMutableDictionary *dic=  [Cab GetRideRequest:isAvailable];
        
        [dic setObject: dicCurrentLatLng forKey:@"currentPosition"];
        [dic setObject:dicPreviousLatLng forKey:@"previousPosition"];
        [dic setObject:self.cabId forKey:@"firebaseId"];
        
        if(isRideReject){
            [dic setValue:self.dicAcceptRide[@"rider_obj_id"] forKey:@"cancelledRideRequestId"];
        }
        
        Previouslat = currentlat;
        Previouslog = currentlog;
        [[self.cabReference child:self.cabId] setValue:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if (!error) {
                NSLog(@"post successfully");
                [self rideRequestObservadd];
                isUpadateLoc = YES;
                [self setCarTypeImag];
            }
        }];
        
    }else{
        NSLog(@"NOT avalable Location");
    }
}

-(void)getAllCabType {
    [ParseHelper getCarTypeCompletion:^(NSArray *obje, NSError *error) {
        NSMutableArray *arrayAllCabType = [obje mutableCopy];
        NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"order" ascending:YES];
        NSArray *sortedNumbers = [arrayAllCabType sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        for (NSDictionary *dic in sortedNumbers) {
            CabType *objCab =[[CabType alloc]init];
            [objCab initwithAllCabsType:dic];
            [self.arrayCabTypes addObject:objCab];
        }
        appDelegate.arryAllCab = self.arrayCabTypes;
    }];
}


-(void)setCarTypeImag{
    PFQuery *query = [PFQuery queryWithClassName:@"CabType"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (objects && error == nil) {
            NSLog(@"objects  %@",objects);
            NSMutableArray *arrobject =[objects mutableCopy];
            
            [arrobject enumerateObjectsUsingBlock:^(PFObject *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@", [obj objectForKey:@"pic"]);
                NSString *cabType = [NSString stringWithFormat:@"%@",[obj valueForKey:@"code"]];
                NSString *driverCabType = [NSString stringWithFormat:@"%@",kUserDetails.objDriverM.carType];
                
                if (cabType == driverCabType) {
                    //[obj objectForKey:@"pic"];
                    PFFile *im = (PFFile*)[obj objectForKey:@"carPic"];
                    NSURL *url = [NSURL URLWithString:im.url];
                    [self.imgCabType sd_setImageWithURL: url];
                }
            }];
        }else{
            NSLog(@"objects  %@",objects);
        }
    }];
}
#pragma mark Check Ride Exists or Not

-(void)checkIFRideExist{
    
    //    self.cabReference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    //    NSString *strids = [GlobleMethod getValueFromUserDefault:@"CABID"];
    //    self.rideRequestReference = [self.cabReference child:strids];
    
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    
    [[self.rideRefeference queryOrderedByChild:@"driver_obj_id"] queryEqualToValue:kUserDetails.objDriverM.objectid];
    
    FIRDatabaseQuery *query = [[self.rideRefeference queryOrderedByChild:@"driver_obj_id"] queryEqualToValue:kUserDetails.objDriverM.objectid];
    
    [query observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSMutableDictionary *dicRideDetail = snapshot.value;
        id val = nil;
        
        if (snapshot.value != (id)[NSNull null]){
            NSArray *values = [dicRideDetail allValues];
            NSArray *keys = [dicRideDetail allKeys];
            
            if ([values count] != 0)
                val = [values objectAtIndex:0];
            
            self.rideRequestId = [keys objectAtIndex:0];;
            
            if (IS_NOT_NULL(val, @"status")) {
                if ([[val valueForKey:@"status"]
                     isEqualToString:DRIVER_ARRIVED_TO_PICKUP]) {
                    [self fillRiderDetail:val];
                    [self pickupArrivedloadView];
                    self.objSilderView.hidden = false;
                    NSLog(@"Ride Arrived TO Pickup....");
                    [self switchonPickupArrived];
                    self.btnSlider.tag = startRide;
                }else if ([[val valueForKey:@"status"]
                           isEqualToString:DRIVER_ARRIVED_TO_PICKUP]) {
                    [self fillRiderDetail:val];
                    [self pickupArrivedloadView];
                    self.objSilderView.hidden = false;
                    NSLog(@"Ride Arrived TO Pickup....");
                    [self switchonPickupArrived];
                    self.btnSlider.tag = startRide;
                }else if ([[val valueForKey:@"status"] isEqualToString:RIDE_STARTED]) {
                    [self fillRiderDetail:val];
                    [self pickupArrivedloadView];
                    self.objSilderView.hidden = false;
                    NSLog(@"Ride Started....");
                    [self switchonrideStartes];
                    self.btnSlider.tag = reachedToDestination;
                }
            }
        }
    }];
}

-(void)fillRiderDetail:(NSMutableDictionary*)dicRideDetail{
    if ([dicRideDetail valueForKey:@"rider_name"]) {
        self.viewPickup.lblRiderName.text = [dicRideDetail valueForKey:@"rider_name"];
        strRiderName = [dicRideDetail valueForKey:@"rider_name"];
    }
    if ([self.dicAcceptRide valueForKey:@"rider_dp_url"]) {
        [self.viewPickup.imgRider sd_setImageWithURL:[self.dicAcceptRide valueForKey:@"rider_dp_url"] placeholderImage:nil];
        strRiderDp = [self.dicAcceptRide valueForKey:@"rider_dp_url"];
    }
    
    if ([dicRideDetail valueForKey:@"masked_number"]) {
        [self.viewPickup.activityIndicator stopAnimating];
        self.viewPickup.activityIndicator.hidden = true;
        self.viewPickup.btnCall.hidden = false;
        [self.viewPickup.btnCall.layer setValue:[dicRideDetail valueForKey:@"masked_number"] forKey:@"RIDER_CONTACT"];
        [self.viewPickup.btnCall addTarget:self action:@selector(callDrive:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([dicRideDetail valueForKey:@"pickup_title"]) {
        strPickUpLocation = [dicRideDetail valueForKey:@"pickup_title"];
        self.lblDestination.text = strPickUpLocation;
    }
    if ([dicRideDetail valueForKey:@"drop_title"]) {
        strDropLocation = [dicRideDetail valueForKey:@"drop_title"];
    }
    
    if ([dicRideDetail valueForKey:@"pickup_lat"]) {
        Pickup_lat = [[dicRideDetail valueForKey:@"pickup_lat"] doubleValue];
    }
    if ([dicRideDetail valueForKey:@"pickup_long"]) {
        pickup_long = [[dicRideDetail valueForKey:@"pickup_long"] doubleValue];
    }
    if ([dicRideDetail valueForKey:@"drop_lat"]) {
        strOpenMapDLat = [dicRideDetail valueForKey:@"drop_lat"];
    }
    if ([dicRideDetail valueForKey:@"drop_long"]) {
        strOpeMapDLong = [dicRideDetail valueForKey:@"drop_long"];
    }
}

#pragma mark Ride Request Observe

-(void)rideRequestObservadd {
    timerInActive = TRUE;
    
    
    self.cabReference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    NSString *strids = [GlobleMethod getValueFromUserDefault:@"CABID"];
    self.rideRequestReference = [self.cabReference child:strids];
    
    [self.rideRequestReference observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSString  *key= snapshot.key;
        
        if ([key isEqualToString:@"rideRequest"]) {
            _audioPlayerAlert.numberOfLoops = -1;
            [_audioPlayerAlert play];
            rideCanceled = false;
            self.dicAcceptRide = snapshot.value;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.viewPopUp.hidden = NO;
                [self.view bringSubviewToFront:self.viewPopUp];
                isRideReject = FALSE;
                NSLog(@"****** viewPopUp  Show  *****");
                
                //                //MARK : Progress for Ride Riquest Timer  by AMIT
                CGRect containerBounds = [self.viewProgress bounds];
                
                CGRect barFrame = CGRectMake(0, 0,
                                             containerBounds.size.width,
                                             containerBounds.size.height);
                
                barTimer = (ORBVisualTimerBar *)[ORBVisualTimer timerWithStyle:ORBVisualTimerStyleBar frame:barFrame timeRemaining:(10)];
                
                barTimer.center = CGPointMake(containerBounds.size.width / 2,
                                              containerBounds.size.height);
                
                barTimer.barAnimationStyle = ORBVisualTimerBarAnimationStyleStraight;
                
                barTimer.backgroundViewColor = [UIColor colorWithWhite:0.0f alpha:0.40f];
                barTimer.backgroundViewCornerRadius = 0.0f;
                barTimer.timerShapeInactiveColor = [UIColor lightGrayColor];
                barTimer.timerShapeActiveColor = PrimaryAccetColor;
                barTimer.timerLabelColor = [UIColor whiteColor];
                barTimer.showTimerLabel = NO;
                barTimer.autohideWhenFired = YES;
                barTimer.barCapStyle = kCALineCapSquare;
                barTimer.barThickness = 5.0f;
                barTimer.barPadding = 0.0f;
                barTimer.delegate = self;
                barTimer.tag = 0;
                
                if (barTimer != nil){
                    [barTimer addObserver:self forKeyPath:@"timeRemaining"
                                  options:(NSKeyValueObservingOptionOld) context:nil];
                    timerInActive = FALSE;
                    [self.viewProgress addSubview:barTimer];
                    [barTimer start];
                }
            });
            
            if ([self.dicAcceptRide valueForKey:@"rider_dp_url"]) {
                NSString *strdp = GET_VALUE_STR(self.dicAcceptRide, @"rider_dp_url");
                [self.imageDp sd_setImageWithURL:[NSURL URLWithString:strdp] placeholderImage:nil];
            }
            if ([self.dicAcceptRide valueForKey:@"rider_rating"]) {
                int intRatings = GET_VALUE_INT(self.dicAcceptRide, @"rider_rating");
                self.objRateView.rating = intRatings;// Set Rider Ratings
            }
            
            if ([self.dicAcceptRide valueForKey:@"rider_name"]) {
                self.lblRiderName.text = [self.dicAcceptRide valueForKey:@"rider_name"];
            }
            
            if (IS_NOT_NULL(self.dicAcceptRide, @"pickup_title")) {
                NSString *strPickup = GET_VALUE_STR(self.dicAcceptRide, @"pickup_title");
                self.lblPickUp.text = strPickup;
            }
            if (IS_NOT_NULL(self.dicAcceptRide, @"drop_title")) {
                NSString *strDropTitle = GET_VALUE_STR(self.dicAcceptRide, @"drop_title");
                self.lblDrop.text = strDropTitle;
            }
        }
    }];
}

//MARK : Timer Method Fired
#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    ORBVisualTimerBar *bar = (ORBVisualTimerBar *)object;
    
    if (!timerInActive) {
        CGFloat timeRemaining = [[change valueForKey:NSKeyValueChangeOldKey] doubleValue];
        NSLog(@"Time remaining: %.1f", timeRemaining);
        if (timeRemaining <= 3) {
            UIColor *barLabelColor = bar.timerLabelColor;
            bar.timerLabelColor = [UIColor redColor];
            
            UIColor *barColor = bar.timerShapeActiveColor;
            bar.timerShapeActiveColor = [UIColor redColor];
            
            CGFloat barThickness = bar.barThickness;
            bar.barThickness += 2.0f;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * USEC_PER_SEC)), dispatch_get_main_queue(), ^{
                bar.timerLabelColor = barLabelColor;
                bar.timerShapeActiveColor = barColor;
                bar.barThickness = barThickness;
                
                if (timeRemaining <= 1) {
                    bar.timerShapeInactiveColor = [UIColor redColor];
                    bar.barThickness = 5.0f;
                    [self removeRideRequest];
                }
            });
        }
    }
}

#pragma mark - ORBVisualTimerDelegate

- (void)visualTimerFired:(ORBVisualTimer *)timerView {
    NSLog(@"FIRED!");
}

-(void)cabLocationUpadateinFirebase{
    
    if (isUpadateLoc) {
        NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
        NSMutableDictionary *dicPreviousLatLng = [self setpreviousPositionlocationlatlog];
        NSMutableDictionary *dicCurrentLatLng = [self setcurrenlocationlatlog];
        
        [dic setObject: dicCurrentLatLng forKey:@"currentPosition"];
        [dic setObject:dicPreviousLatLng forKey:@"previousPosition"];
        
        self.cabReference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
        self.cabId = [GlobleMethod getValueFromUserDefault:@"CABID"];
        
        [[self.cabReference child:self.cabId] onDisconnectUpdateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            NSLog(@"currentlocation ");
            [self.cabReference removeAllObservers];
        }];
    }
}

#pragma mark - Mapview Delegate Methord

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    self.location = [locations lastObject];
    
    self.location = [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [self.location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    
    NSLog(@" didUpdateLocations Latitude : %@", latitude);
    NSLog(@" didUpdateLocations Longitude : %@",longitude);
    
    if(coordinate.latitude != 0.000000 || coordinate.longitude != 0.000000){
        currentlat = coordinate.latitude;
        currentlog = coordinate.longitude;
        Previouslat = currentlat;
        Previouslog = currentlog;
        
        //        [self googleMapviewSetup];
        // [self firdatabaseSetup:YES];
        [self cabLocationUpadateinFirebase];
    }
}
- (void)locationManager:(CLLocationManager *)manager  didUpdateHeading:(CLHeading *)newHeading
{
    //    double heading = newHeading.trueHeading;
    //    double headingDegrees = (heading*M_PI/180);
    //    CLLocationDirection trueNorth = [newHeading trueHeading];
    //    [gmsMapView.myLocation animateToBearing:trueNorth];
}

#pragma mark - Button Action

- (IBAction)Location:(id)sender {
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    self.location = [locationManager location];
    // Configure the new event with information from the location
    CLLocationCoordinate2D coordinate = [self.location coordinate];
    NSString *latitude = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSLog(@"dLatitude : %@", latitude);
    NSLog(@"dLongitude : %@",longitude);
    
    if(coordinate.latitude != 0.000000 || coordinate.longitude != 0.000000){
        GMSCameraPosition *cameraPos =[GMSCameraPosition cameraWithTarget:coordinate zoom:12];
        [gmsMapView animateToCameraPosition:cameraPos];
        
        currentlat = coordinate.latitude;
        currentlog = coordinate.longitude;
        [self firdatabaseSetup:YES];
    }
}

-(void)openBankDetailAlert{
    [GlobleMethod showAlertWithOkCancel:self andMessage:@"In order to start to accepting rides, you need to enter few details of your bank account, So we can deposit your earnings." okButtonTitle:@"Enter Now" cancelButtonTitle:@"Cancel" completion:^(BOOL success) {
        if (success){
            NSLog(@"Open Bank Detail Page");
            
            BankAccountDetailsVC *bankDetailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"BankAccountDetailsVC"];
            [self presentViewController:bankDetailVC animated:YES completion:nil];
        }else{
            NSLog(@"Closed");
            [self.switchOnOff setOn:FALSE];
        }
    }];
}

- (IBAction)onlineoffline:(id)sender {
    if([sender isOn]){
        self.lbltitle.text= @"Turn off this when do not want to receive new ride requests";
        NSString *merchantIdToCheck = kUserDetails.objDriverM.merchantid;
        if([merchantIdToCheck isEqualToString:@""] || [merchantIdToCheck length] == 0 || merchantIdToCheck == NULL){
            [self openBankDetailAlert];
        }else{
            [self firdatabaseSetup:YES];
        }
    } else{
        self.lbltitle.text= @"Slide this switch when you are ready to accept new ride requests";
        [self removeDriver];
    }
}

-(void) getDriverInfo:(isSuccess) completion{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [ParseHelper getUserData:^(NSArray *obje, NSError *error) {
        objDriver = (NSMutableDictionary*)obje;

        Driver *driver =[[Driver alloc]init];
        NSMutableDictionary *temp1 =[[NSMutableDictionary alloc]init];
        temp1 = (NSMutableDictionary*)obje;
        NSLog(@"Logine object  %@ ",temp1);
        [driver initwithLogineDetaile:temp1];
        
        kUserDetails.objDriverM = driver;
        [kUserDetails saveUser];
        
        isEnabledSendBox = [kUserDetails.objDriverM.enableSandboxPaymentBraitree boolValue];
        self.lblSendBox.hidden = isEnabledSendBox ? NO : YES;

        [MBProgressHUD hideHUDForView:self.view animated:NO];

        completion(YES);
    }];
}

-(void)checkIfBankDetailsEntered{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [appDelegate getDriverInfo:^(BOOL isSuccess) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(isSuccess){
            NSString *merchantId = kUserDetails.objDriverM.merchantid;
            if(![merchantId isEqualToString:@""] && [merchantId length] != 0 && merchantId != NULL){
                [self firdatabaseSetup:YES];
                [self.switchOnOff setOn:YES];
            }else{
                [self firdatabaseSetup:NO];
                [self.switchOnOff setOn:FALSE];
            }
        }
    }];
    
}

-(void)removeDriver{
    if ([GlobleMethod getValueFromUserDefault:@"CABID"]) {
        NSString *cabId = [GlobleMethod getValueFromUserDefault:@"CABID"];
        [[[appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]] child:cabId]removeValueWithCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if (!error) {
                NSLog(@"remove object");
            }
        }];
    }
}

- (IBAction)rejectRide:(id)sender {
    isRideReject = TRUE;
    [self removeRideRequest];
}

- (IBAction)rideCancel:(id)sender {
    self.viewEmer.hidden = YES;
    self.viewPickup.hidden = YES;
    self.viewPickup.lblRiderName.text = @"";
    self.viewPickup.imgRider.image = [UIImage imageNamed:@"dp_dummy"];
    [self.viewPickup removeFromSuperview];
    
    self.objSilderView.hidden = YES;
    self.viewPopUp.hidden = YES;
    self.viewTimer.hidden = YES;
    
    [self rideCanceld];
    [gmsMapView clear];
}

-(void)rideCanceld {
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    
    NSMutableDictionary *dic =  [[NSMutableDictionary alloc]init];
    [dic setValue:RIDE_CANCELED forKey:@"status"];
    
    if (!isRideReject){
        [[self.rideRefeference child:self.rideRequestId] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if (!error) {
                NSLog(@"ride Cancel successfully");
                [_audioPlayerAlert stop];
                self.viewPopUp.hidden = YES;
                self.viewPickup.hidden = YES;
                self.objSilderView.hidden = YES;
                
                self.viewPickup.hidden = YES;
                self.viewPickup.lblRiderName.text = @"";
                self.viewPickup.imgRider.image = [UIImage imageNamed:@"dp_dummy"];
                [self.viewPickup removeFromSuperview];
                
                self.viewEmer.hidden = YES;
                self.viewTimer.hidden = YES;
                
                self.ViewOnOff.hidden = NO;
            }
        }];
    }
}

- (IBAction)rideAccept:(id)sender {
    strRiderDp = @"";
    strPickUpLocation = @"";
    strDropLocation = @"";
    strRiderName = @"";
    strParse_obj_Firebase = @"";
    strOpenMapDLat= @"";
    strOpeMapDLong = @"";
    
    [_audioPlayerAlert stop];
    [_audioPlayerMeepMeep play];
    
    //Timer Stop
    timerInActive = TRUE;
    barTimer = nil;
    [barTimer stopTimerView];
    [barTimer stopAndHide];
    [barTimer removeObserver:self
                  forKeyPath:@"timeRemaining"
                     context:nil];
    [barTimer removeFromSuperview];
    
    // [[KIProgressViewManager manager] hideProgressView];
    self.viewPopUp.hidden = YES;
    [self meepMeepAudioPlay];
    NSLog(@"self.dicAcceptRide   %@",self.dicAcceptRide);
    
    
    
    [self pickupArrivedloadView];
    
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    NSString  *rideRequestId1 = [self.rideRefeference childByAutoId].key;
    self.rideRequestId = rideRequestId1;
    
    //====Added Because Android expecting RIDE_STATUS while accepted=====//
    [self.dicAcceptRide setValue:RIDE_BOOKED forKey:@"status"];
    //==================================================================//
    
    //Task: Add rideOTP in the dictAcceptRide dictionary
    //Generate a random 5 digit number
    int randomNumber = arc4random_uniform(90000) + 10000;
    NSLog(@"Generated random number is %d ", randomNumber);
    [self.dicAcceptRide setValue:[NSNumber numberWithInt:randomNumber] forKey:@"rideOTP"];
    
    NSLog(@"Accept Ride dictionary is %@", self.dicAcceptRide);
    //

    [[self.rideRefeference child:rideRequestId1] setValue:self.dicAcceptRide withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (!error) {
            [self.rideRefeference removeAllObservers];
        }
    }];
    
    self.cabReference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"cabs",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    NSString *strids = [GlobleMethod getValueFromUserDefault:@"CABID"];
    NSMutableDictionary *dic=  [Cab GetObjForRide:FALSE];
    
    NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
    
    [dic setValue:[NSNumber numberWithLong:timeInSeconds] forKey:@"ride_creation_date_time"];
    [dic setValue:kUserDetails.objDriverM.carURL forKey:@"cab_dp"];
    [dic setValue:kUserDetails.objDriverM.merchantid forKey:@"braintreeMerchantId"];
    [dic setValue:kUserDetails.objDriverM.contact forKey:@"driver_contact"];
    [dic setValue:rideRequestId1 forKey:@"ride_firebase_id"];
    [dic setValue:kUserDetails.objDriverM.carModel forKey:@"driver_car_model"];
    [dic setValue:[NSNumber numberWithDouble:currentlat] forKey:@"driver_lat"];
    [dic setValue:[NSNumber numberWithDouble:currentlog] forKey:@"driver_long"];
    [dic setValue:[self.dicAcceptRide valueForKey:@"cabType"] forKey:@"cabType"];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Driver"];
    [query getObjectInBackgroundWithId:kUserDetails.objDriverM.objectid block:^(PFObject *object, NSError *error) {
        if (object) {
            NSMutableDictionary *temp =[[NSMutableDictionary alloc]init];
            temp = object;
            
            if (IS_NOT_NULL(temp, @"ratings_value")) {
                float ratingValue = [temp[@"ratings_value"] floatValue];
                float ratingCount = [temp[@"ratings_count"] floatValue];
                float ratings = ratingValue/ratingCount;
                [dic setValue:[NSNumber numberWithFloat:ratings] forKey:@"driver_rating"];
            }
            
            // Update Rides object in Firebase
            [[self.rideRefeference child:rideRequestId1] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                [self.rideRefeference removeAllObservers];
                NSLog(@"Update ridequest successfull in Ride ");
                self.viewEmer.hidden = NO;
                self.btnGoogleMapApp.tag = 1;
            }];
        }
    }];
    
    
    [[[self.cabReference child:strids] child:@"rideRequest"] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        [self.cabReference removeAllObservers];
        NSLog(@"Update ridequest successfull in Cabs");
    }];
    
    [[[self.cabReference child:self.cabId] child:@"rideRequest"] removeValue];
    
    // get Rides object in Firebase
    [[self.rideRefeference child:rideRequestId1] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        [self.rideRefeference removeAllObservers];
        [[self.rideRequestReference child:rideRequestId1] removeAllObservers];
        
        NSMutableDictionary *dicRideDetail = snapshot.value;
        if (snapshot.value != (id)[NSNull null]){
            //            &&
            //            ([[dicRideDetail valueForKey:@"status"] isEqualToString:@"RIDE_BOOKED"] ||
            //            [[dicRideDetail valueForKey:@"status"] isEqualToString:@"RIDE_STARTED"] ||
            //            [[dicRideDetail valueForKey:@"status"] isEqualToString:@"RIDE_COMPLETED"] ||
            //            [[dicRideDetail valueForKey:@"status"] isEqualToString:@"RIDE_CANCELED"])) {
            
            if ([dicRideDetail valueForKey:@"rider_name"]) {
                self.viewPickup.lblRiderName.text = [dicRideDetail valueForKey:@"rider_name"];
                strRiderName = [dicRideDetail valueForKey:@"rider_name"];
            }
            if ([self.dicAcceptRide valueForKey:@"rider_dp_url"]) {
                [self.viewPickup.imgRider sd_setImageWithURL:[self.dicAcceptRide valueForKey:@"rider_dp_url"] placeholderImage:nil];
                strRiderDp = [self.dicAcceptRide valueForKey:@"rider_dp_url"];
            }
            
            if ([dicRideDetail valueForKey:@"masked_number"]) {
                [self.viewPickup.activityIndicator stopAnimating];
                self.viewPickup.activityIndicator.hidden = true;
                self.viewPickup.btnCall.hidden = false;
                [self.viewPickup.btnCall.layer setValue:[dicRideDetail valueForKey:@"masked_number"] forKey:@"RIDER_CONTACT"];
                [self.viewPickup.btnCall addTarget:self action:@selector(callDrive:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            if ([dicRideDetail valueForKey:@"pickup_title"]) {
                strPickUpLocation = [dicRideDetail valueForKey:@"pickup_title"];
                self.lblDestination.text = strPickUpLocation;
            }
            if ([dicRideDetail valueForKey:@"drop_title"]) {
                strDropLocation = [dicRideDetail valueForKey:@"drop_title"];
            }
            
            if ([dicRideDetail valueForKey:@"pickup_lat"]) {
                Pickup_lat = [[dicRideDetail valueForKey:@"pickup_lat"] doubleValue];
            }
            if ([dicRideDetail valueForKey:@"pickup_long"]) {
                pickup_long = [[dicRideDetail valueForKey:@"pickup_long"] doubleValue];
            }
            if ([dicRideDetail valueForKey:@"drop_lat"]) {
                strOpenMapDLat = [dicRideDetail valueForKey:@"drop_lat"];
            }
            if ([dicRideDetail valueForKey:@"drop_long"]) {
                strOpeMapDLong = [dicRideDetail valueForKey:@"drop_long"];
            }
            
            
        }
        //  Creat ride in parse
        if ([strParse_obj_Firebase isEqualToString:@""] && dicRideDetail != (NSDictionary*)[NSNull null]){
            
            if (!rideCanceled) {
                [ParseHelper creatRide:dicRideDetail completion:^(PFObject *obje, NSError *error) {
                    if (obje && error == nil) {
                        NSLog(@" get Ride objectId %@ ",obje.objectId);
                        strParse_obj_Firebase = obje.objectId;
                        
                        //                    [[[self.rideRefeference child:rideRequestId1] child:@"parse_obj_firebase"]
                        [[[self.rideRefeference child:rideRequestId1] child:@"prase_object_id"]setValue:strParse_obj_Firebase];
                        
                        //Draw a Path Between Pickup to Destination Address
                        dispatch_async(dispatch_get_main_queue(),^{
                            if (!rideCanceled)[self drawPathForNewRideArrived:dicRideDetail];
                        });
                    }
                }];
            }
        }
    }];
    
    // ride cancell observation
    [[self.rideRefeference child:rideRequestId1] observeEventType:FIRDataEventTypeChildChanged withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        NSLog(@"%@", snapshot.value);
        if (snapshot.value != (id)[NSNull null]){
            if ([snapshot.value isKindOfClass: [NSString class]] && [snapshot.value isEqualToString:@"RIDE_CANCELED"]) {//Check crash while destination changed from rider app
                
                [self.rideRefeference removeAllObservers];
                rideCanceled = true;
                [gmsMapView clear];
                
                timerInActive = TRUE;
                barTimer = nil;
                [barTimer stopTimerView];
                [barTimer stopAndHide];
                [barTimer removeObserver:self
                              forKeyPath:@"timeRemaining"
                                 context:nil];
                [barTimer removeFromSuperview];
                
                //MARK: Clear All object values
                strRiderDp =@"";
                strPickUpLocation = @"";
                strDropLocation = @"";
                strRiderName = @"";
                strParse_obj_Firebase = @"";
                strOpenMapDLat= @"";
                strOpeMapDLong = @"";
                
                self.viewPopUp.hidden = YES;
                self.viewPickup.hidden = YES;
                self.objSilderView.hidden = YES;
                
                self.viewPickup.hidden = YES;
                self.viewPickup.lblRiderName.text = @"";
                self.viewPickup.imgRider.image = [UIImage imageNamed:@"dp_dummy"];
                [self.viewPickup removeFromSuperview];
                
                self.viewEmer.hidden = YES;
                self.viewTimer.hidden = YES;
                
                self.ViewOnOff.hidden = NO;
            }
        }
    }];
    
    NSLog(@"dic  %@",dic);
}

-(void)drawPathForNewRideArrived:(NSMutableDictionary*)dictRideInfo{
    
    NSMutableDictionary * dicToCoordinates = [NSMutableDictionary new];
    [dicToCoordinates setObject:[NSNumber numberWithDouble:[dictRideInfo[@"drop_lat"] doubleValue]] forKey:@"lat"];
    [dicToCoordinates setObject:[NSNumber numberWithDouble:[dictRideInfo[@"drop_long"] doubleValue]] forKey:@"longi"];
    
    NSMutableDictionary * fromCoordinates = [NSMutableDictionary new];
    [fromCoordinates setObject:[NSNumber numberWithDouble:[dictRideInfo[@"pickup_lat"] doubleValue]] forKey:@"lat"];
    [fromCoordinates setObject:[NSNumber numberWithDouble:[dictRideInfo[@"pickup_long"] doubleValue]] forKey:@"longi"];
    
    strToPostalCode = dictRideInfo[@"drop_code"];
    //    NSString *strimgRideType = [self getImageTypes:(dictRideInfo[@"types"])];
    
    [dicToCoordinates setObject:@"insideCity" forKey:@"rideType"];
    //    [dicToCoordinates setObject:dictRideInfo[@"description"] forKey:@"dropTitle"];
    [dicToCoordinates setObject:strToPostalCode forKey:@"postalCode"];
    NSString *strCity = dictRideInfo[@"locality"];
    if (strCity == nil){
        strCity = @"";
    }
    [dicToCoordinates setObject:strCity forKey:@"locality"];
    //    [dicToCoordinates setObject:dictRideInfo[@"locationTypes"] forKey:@"locationTypes"];
    
    [self drawRoute:[fromCoordinates[@"lat"] doubleValue] andOriginLong:[fromCoordinates[@"longi"] doubleValue] andDestinationLat:[[dicToCoordinates valueForKey:@"lat"] doubleValue] andDestinationLong:[[dicToCoordinates valueForKey:@"longi"] doubleValue]];
    
}

//-(NSString *)getImageTypes:(NSMutableArray *)arrTypes {
//    NSString *strimgRideType = @"";
//    if ([arrTypes containsObject:@"airport"]) {
//        strimgRideType = @"flight";
//    } else if ([strToPostalCode isEqualToString:picLocation.strPostalCode]) {
//        strimgRideType = @"insideCity";
//    } else {
//        strimgRideType = @"OutCity";
//    }
//    return strimgRideType;
//}

- (void)drawRoute:(double)originLat andOriginLong:(double)originLong andDestinationLat:(double)destinationLat andDestinationLong:(double)destinationLong {
    [gmsMapView clear];
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    [self fireBaseSetCar];
    gmsMapView.myLocationEnabled=NO;
    UIImageView *imgMarker = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    imgMarker.image = [UIImage imageNamed:@"marker_common"];
    imgMarker.tintColor = PrimaryColor;
    GMSMarker *fromMarker;
    if (originLat != 0 && originLong != 0) {
        fromMarker = [[GMSMarker alloc]init];
        fromMarker.position=CLLocationCoordinate2DMake(originLat,originLong);
        fromMarker.iconView = imgMarker;
        fromMarker.groundAnchor=CGPointMake(0.5,0.5);
        fromMarker.map=gmsMapView;
    }
    GMSMarker *toMarker;
    if (destinationLat != 0 && destinationLong != 0) {
        toMarker = [[GMSMarker alloc]init];
        toMarker.position=CLLocationCoordinate2DMake(destinationLat,destinationLong);
        toMarker.iconView = imgMarker;
        toMarker.groundAnchor=CGPointMake(0.5,0.5);
        toMarker.map=gmsMapView;
        toMarker.userData = @{@"type":@"drop"};
    }
    
    CLLocation *origin = [[CLLocation alloc] initWithLatitude:originLat longitude:originLong];
    CLLocation *destination = [[CLLocation alloc] initWithLatitude:destinationLat longitude:destinationLong];
    if (fromMarker != nil && toMarker != nil) {
        [self getpoints:origin destination:destination];
    } else if (fromMarker != nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            GMSCameraPosition *cameraPos =[GMSCameraPosition cameraWithTarget:origin.coordinate zoom:16];
            [gmsMapView animateToCameraPosition:cameraPos];
        });
    }
    if (origin != nil) {
        [self getAddressFromLocation:origin complationBlock:^(NSString * address) {
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(address) {
                fromMarker.userData = @{@"type":@"picker",@"address":address};
            } else{
                fromMarker.userData = @{@"type":@"picker",@"address":@""};
            }
            if (fromMarker != nil && toMarker != nil) {
                GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:fromMarker.position coordinate:toMarker.position];
                [gmsMapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withEdgeInsets:UIEdgeInsetsMake(130, 15, 350, 15)]];
            }
        }];
    }
}

-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@ %@", placemark.name, placemark.postalCode, placemark.locality];
             completionBlock(address);
         }
     }];
}

- (void)getpoints:(CLLocation *)origin destination:(CLLocation *)destination{
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       //                       [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                   });
    /*NSString *urlString = [NSString stringWithFormat:
     @"%@?origin=%f,%f&destination=%f,%f&alternatives=true&sensor=true",
     @"https://maps.googleapis.com/maps/api/directions/json",
     origin.coordinate.latitude,
     origin.coordinate.longitude,
     destination.coordinate.latitude,
     destination.coordinate.longitude
     ];*/
    
    NSString *urlString = [NSString stringWithFormat:
                           @"%@?origin=%f,%f&destination=%f,%f&alternatives=true&mode=driving&sensor=true&key=%@",
                           @"https://maps.googleapis.com/maps/api/directions/json",
                           origin.coordinate.latitude,
                           origin.coordinate.longitude,
                           destination.coordinate.latitude,
                           destination.coordinate.longitude,
                           GOOGLE_PLACES_KEY
                           ];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary * dictParam = [NSMutableDictionary new];
    [dictParam setObject:@"" forKey:@""];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        NSLog(@"Responce:%@",responseObject);
        [self.arrayRoutes removeAllObjects];
        if ([[responseObject objectForKey:@"status"] isEqualToString:@"OK"]) {
            NSDictionary *dicRoutes = [[NSMutableDictionary alloc]init];
            dicRoutes = responseObject;
            NSMutableArray *arrayRoute = [[NSMutableArray alloc]init];
            arrayRoute = dicRoutes[@"routes"];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.arrayRoutes = [[NSMutableArray alloc] init];
                for (NSDictionary *dicRoute in arrayRoute) {
                    Routes *route =[[Routes alloc]init];
                    [route initwithAllRouteType:dicRoute];
                    [self.arrayRoutes addObject:route];
                }
                Routes *route = [self.arrayRoutes objectAtIndex:0];
                NSString *strTimeDate = [NSString stringWithFormat:@"%@ | %@",route.strDistant,route.strTime];
                
                indexRoute = 0;
                [self drawPaths];
                [_viewMap addSubview:gmsMapView];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           //                           [MBProgressHUD hideHUDForView:self.view animated:YES];
                       });
        NSLog(@"error: %@", error.localizedDescription);
    }];
}

-(void)drawPaths {
    Routes *route = [self.arrayRoutes objectAtIndex:indexRoute];
    if (polyline != nil) {
        [polyline setMap:nil];
    }
    path =[GMSPath pathFromEncodedPath:route.strPoint];
    
    polyline = [GMSPolyline polylineWithPath:path];
    
    polyline.strokeColor = [UIColor blackColor];
    polyline.strokeWidth = 4.0f;
    polyline.map = gmsMapView;
    
    //    float finalMiles = 0.0;
    //
    //    if ([route.strDistant containsString:@"mi"]) {
    //        finalMiles = [route.strDistant floatValue];
    //    } else {
    //        finalMiles = ([route.strDistant floatValue]/1.609344);
    //    }
}

-(IBAction)callDrive:(UIButton*)number{
    
    NSString *phonenumberstr= [NSString stringWithFormat:@"tel:%@",[self.viewPickup.btnCall.layer valueForKey:@"RIDER_CONTACT"]];
    //    NSURL *phoneNumberURL = [NSURL URLWithString:phonenumberstr];
    //    [[UIApplication sharedApplication] openURL: phoneNumberURL];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *phoneNumberURL = [NSURL URLWithString:phonenumberstr];
    [application openURL:phoneNumberURL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

-(void)meepMeepAudioPlay{
    NSString *path = [NSString stringWithFormat:@"%@/alert.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [audioPlayer play];
}

-(void)submitRating{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    [dic setValue:[NSNumber numberWithInt:rating] forKey:@"rating_overall_driver"];
    //    [dic setValue:strParse_obj_Firebase forKey:@"parse_obj_Firebase"];
    [dic setValue:strParse_obj_Firebase forKey:@"prase_object_id"];
    NSLog(@"strParse_obj_Firebase  %@",strParse_obj_Firebase);
    [ParseHelper ratingSubmint:dic completion:^(NSArray *obje, NSError *error) {
        if (obje && error == nil) {
            //            self.viewRating.hidden = YES;
            [self.viewRating removeFromSuperview];
        }else{
            [GlobleMethod showAlert:self andMessage:ErrorMessage];
        }
    }];
}
- (IBAction)openGoogleMap:(id)sender {
    
    if ([sender tag] == 1) {
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%f,%f&zoom=14&views=traffic",currentlat,currentlog,Pickup_lat,pickup_long]]];
        } else {
            NSLog(@"Can't use comgooglemaps://");
        }
    }else{
        if ([[UIApplication sharedApplication] canOpenURL:
             [NSURL URLWithString:@"comgooglemaps://"]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%@,%@&zoom=14&views=traffic",Pickup_lat,pickup_long,strOpenMapDLat,strOpeMapDLong]]];
        } else {
            NSLog(@"Can't use comgooglemaps://");
        }
    }
}

- (IBAction)callEmer:(id)sender {
    [self callEmergecy];
}

- (IBAction)callEmerinTimerview:(id)sender {
    [self callEmergecy];
}

-(void)callEmergecy{
    NSString *phonenumberstr= [NSString stringWithFormat:@"tel:911"];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *phoneNumberURL = [NSURL URLWithString:phonenumberstr];
    [application openURL:phoneNumberURL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}

#pragma mark CMSSwitchView Delegate Methord

- (void)switchonPickupArrived
{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    NSTimeInterval timeInSeconds = [[NSDate date] timeIntervalSince1970];
    
    [dic setValue:DRIVER_ARRIVED_TO_PICKUP forKey:@"status"];
    [dic setValue:[NSNumber numberWithLong:(timeInSeconds*1000)] forKey:@"driver_waiting_pickup_since"];
    
    [[self.rideRefeference child:self.rideRequestId] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        [self.rideRefeference removeAllObservers];
        self.viewTimer.hidden = NO;
        self.viewEmer.hidden = YES;
        counterTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCount) userInfo:nil repeats:YES];
        NSLog(@"ridequest Status  DRIVER_ARRIVED_TO_PICKUP Update  successfull in Rides ");
    }];
}
/*-(nonnull BFTask<id> *)callFunctionInBackground:(nonnull NSString *)function
 withParameters:
 (nullable NSDictionary *)parameters {
 
 }*/
- (void)viewDidUnload
{
    //    [self.viewPickup setLongSwitch:nil];
    //    [self.viewRideStarte setLongSwitch:nil];
    //    [self.viewDestination setLongSwitch:nil];
    
    [super viewDidUnload];
}

- (void)switchonrideStartes{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    [dic setValue:RIDE_STARTED forKey:@"status"];
    //
    //    NSString *strids = [GlobleMethod getValueFromUserDefault:@"CABID"];
    //    [[[self.cabReference child:strids] child:@"rideRequest"] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
    //        [self.cabReference removeAllObservers ];
    //        NSLog(@"Update ridequest successfull in Cabs");
    [[self.rideRefeference child:self.rideRequestId] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        [self.rideRefeference removeAllObservers];
        //dispatch_async(dispatch_get_main_queue(), ^{
        self.viewTimer.hidden = YES;
        [counterTimer invalidate];
        counterTimer = nil;
        self.viewEmer.hidden = NO;
        self.btnGoogleMapApp.tag = 2;
        self.lblDestination.text = strDropLocation;
        NSLog(@"ridequest Status  RIDE_STARTED Update  successfull in Rides ");
    }];
    //    }];
    
}

- (void)switchonrideArriveToDestination{
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    [dic setValue:ARRIVED_TO_DESTINATION forKey:@"status"];
    [[self.rideRefeference child:self.rideRequestId] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        [self.rideRefeference removeAllObservers];
        self.viewEmer.hidden = YES;
        self.viewPickup.hidden = YES;
        self.objSilderView.hidden = YES;
        self.ViewOnOff.hidden = NO;
        
        NSLog(@"ridequest Status  ARRIVED_TO_DESTINATION Update  successfull in Rides ");
        [self loadRatingView];
        [gmsMapView clear];
    }];
}

- (void)switchValueChanged:(id)sender andNewValue:(BOOL)value {
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]init];
    self.rideRefeference = [appDelegate.ref child:[NSString stringWithFormat:@"%@%@",@"rides",[GlobleMethod getValueFromUserDefault:@"MODE"]]];
    if ([sender tag] == 1) {
        [dic setValue:DRIVER_ARRIVED_TO_PICKUP forKey:@"status"];
        [[self.rideRefeference child:self.rideRequestId] updateChildValues:dic withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            [self.rideRefeference removeAllObservers];
            self.viewPickup.hidden = YES;
            NSLog(@"ridequest Status  DRIVER_ARRIVED_TO_PICKUP Update  successfull in Rides ");
        }];
    }else if ([sender tag] == 2) {
    }
}

#pragma mark - HCSStarRatingView dalegate Methord

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
    rating = sender.value;
}

#pragma mark - Timer Methord

- (void)timerCount {
    CountNumber = CountNumber + 1;
    NSInteger seconds = CountNumber % 60;
    NSInteger minutes = (CountNumber / 60) % 60;
    NSInteger hours = (CountNumber / 3600);
    self.lblTimer.text =  [NSString stringWithFormat:@"Down Time:%li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
}

#pragma mark Current Location Dicationary

-(NSMutableDictionary *)setcurrenlocationlatlog{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSLog(@" ****** current lat %f",currentlat);
    NSLog(@" ****** current log %f",currentlog);
    //    [dic setValue: [NSString stringWithFormat:@"%f",currentlat] forKey:@"lattitude"];
    //    [dic setValue: [NSString stringWithFormat:@"%f",currentlog] forKey:@"longitude"];
    [dic setValue:[NSNumber numberWithDouble:currentlat] forKey:@"latitude"];
    [dic setValue:[NSNumber numberWithDouble:currentlog] forKey:@"longitude"];
    return dic;
}

-(NSMutableDictionary *)setpreviousPositionlocationlatlog {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    NSLog(@" ****** previous lat %f",Previouslat);
    NSLog(@" ****** previous log %f",Previouslog);
    //    [dic setValue: [NSString stringWithFormat:@"%f",Previouslat] forKey:@"lattitude"];
    //    [dic setValue: [NSString stringWithFormat:@"%f",Previouslog] forKey:@"longitude"];
    [dic setValue:[NSNumber numberWithDouble:Previouslat] forKey:@"latitude"];
    [dic setValue:[NSNumber numberWithDouble:Previouslog] forKey:@"longitude"];
    return dic;
}

@end

