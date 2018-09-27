//
//  SplashVideo.m
//  Ride OTG
//
//  Created by Hiren varu on 20/08/17.
//  Copyright © 2017 Vijay. All rights reserved.
//

#import "SplashVideo.h"
#import "CustomTabbarController.h"
#import "Driver.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "UserDetailsModal.h"

@interface SplashVideo (){
//    AppDelegate *appDelegate;
//    Driver *objDriver;
}
@end

@implementation SplashVideo

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
   
    [appDeleget getDriverInfo:^(BOOL isSuccess) {
        if (kUserDetails.objDriverM.email != nil && ![kUserDetails.objDriverM.email isEqualToString:@""]) {
            [self LaunchSceenVideo];
        }else{
            [self LaunchSceenVideo];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispse of any resources that can be recreated.
}

- (void)LaunchSceenVideo{
    
    // grab a local URL to our video
    NSURL *videoURL = [[NSBundle mainBundle]URLForResource:@"splash" withExtension:@"mp4"];

    // create an AVPlayer
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];

    // create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    controller.showsPlaybackControls = false;
    controller.view.frame = self.view.frame;
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.view addSubview:controller.view];

    [player play];
    
    
    if (![kUserDetails.objDriverM.objectid isEqualToString:@""]) {
        PFQuery *query = [PFQuery queryWithClassName:@"Driver"];
        [query getObjectInBackgroundWithId:kUserDetails.objDriverM.objectid block:^(PFObject *object, NSError *error) {
            if (object) {
                NSMutableDictionary *temp =[[NSMutableDictionary alloc]init];
                temp = object;
                
                if (IS_NOT_NULL(temp, @"is_verified")) {
                    self.isVarified = [[temp valueForKey: @"is_verified"] boolValue];
                    kUserDetails.objDriverM.isVarified = self.isVarified == true ? @"0" : @"1";
//                    [GlobleMethod setObjectFromUserDefault:[NSNumber numberWithInt:self.isVarified] andkey:@"VARIFIED"];
//                    NSLog(@"active  %@",[GlobleMethod getNumberUserDefauld:@"VARIFIED"]);
                }
            }
        }];
    }
    
    // Adding Observer for your video file,
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(videoDidFinish:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
//    [self videoDidFinish:nil];
}

- (void)videoDidFinish:(id)notification {
    
//    AVPlayerItem *p = [notification object];
    //do something with player if you want
    
    //Remove Observer
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //your initial view can proceed from here
    [[UIApplication sharedApplication] setStatusBarHidden:false];
    UIView *statusBar=[[UIApplication sharedApplication] valueForKey:@"statusBar"];
    statusBar.backgroundColor = PrimaryDarkColor;
    BOOL isStayLogged = [[[NSUserDefaults standardUserDefaults] valueForKey:@"STAYLOGGED"] boolValue];
    //[GlobleMethod getValueFromUserDefault:@"STAYLOGGED"];
    
    if (isStayLogged && (kUserDetails.objDriverM.email != nil && ![kUserDetails.objDriverM.email isEqualToString:@""])) {
            CustomTabbarController *Home =[self.storyboard instantiateViewControllerWithIdentifier:@"CustomTabbarController"];
            [self.navigationController pushViewController:Home animated:YES];
    }else{
        [self performSegueWithIdentifier:@"HomeScreen" sender:self];
    }
}
@end
