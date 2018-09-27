//
//  EarningHistoryRootVC.m
//  OTG Driver
//
//  Created by Amit Prajapati on 15/05/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

#import "EarningHistoryRootVC.h"
#import "TodaysEarning.h"
#import "ThisWeekEarningVC.h"
#import "ThisMonthEarningVC.h"
#import "ThisYearsEarningVC.h"


@interface EarningHistoryRootVC (){
    TodaysEarning       *objTodaysEVC;
    ThisWeekEarningVC   *objThisWeekEVC;
    ThisMonthEarningVC  *objThisMonthEVC;
    ThisYearsEarningVC   *objThisYearEVC;

    NSMutableArray *viewsArray;
    NSMutableArray *titlesArray;
    NSMutableArray *controllersArray;
}
@end

@implementation EarningHistoryRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Earnings";
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = PrimaryDarkColor;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = PrimaryDarkColor;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    if(IS_IPHONE_X)
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 50,self.view.frame.size.width,64)];
    else
        [self.navigationController.navigationBar setFrame:CGRectMake(0, 30,self.view.frame.size.width,64)];
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"PT Sans Narrow" size:20]}];
    
    UIImage* image3 = [UIImage imageNamed:@"icon_back"];
    CGRect frameimg = CGRectMake(0, 0, 25, 15);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(onClickMenu:)
         forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.leftBarButtonItem = mailbutton;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStyleDone target:self action:@selector(didTapGoToLeft)];
    
    objTodaysEVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"TodaysEarning"];
    objThisWeekEVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ThisWeekEarningVC"];
    objThisMonthEVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ThisMonthEarningVC"];
    objThisYearEVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ThisYearsEarningVC"];
    
//    objTodaysEVC    = [[TodaysEarning alloc] initWithNibName:@"TodaysEarning" bundle:nil];
//    objThisWeekEVC  = [[ThisWeekEarningVC alloc] initWithNibName:@"ThisWeekEarningVC" bundle:nil];
//    objThisMonthEVC = [[ThisMonthEarningVC alloc] initWithNibName:@"ThisMonthEarningVC" bundle:nil];
//    objThisYearEVC  = [[ThisYearsEarningVC alloc] initWithNibName:@"ThisYearsEarningVC" bundle:nil];
    viewsArray       = [[NSMutableArray alloc] initWithCapacity:0];
    titlesArray      = [[NSMutableArray alloc] initWithCapacity:0];
    controllersArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *str = @"Today";
    [self addPage:str controller:objTodaysEVC];
    
    str = @"This Week";
    [self addPage:str controller:objThisWeekEVC];
    
    str = @"This Month";
    [self addPage:str controller:objThisMonthEVC];
    
    str = @"This Year";
    [self addPage:str controller:objThisYearEVC];
    
    self.segmentedPager.backgroundColor = [UIColor colorWithRed:((float) 249 / 255.0f)
                                                          green:((float) 249 / 255.0f)
                                                           blue:((float) 249 / 255.0f)
                                                          alpha:1.0f];
    
    self.segmentedPager.segmentedControl.backgroundColor = [UIColor colorWithRed:((float) 249 / 255.0f)
                                                                           green:((float) 249 / 255.0f)
                                                                            blue:((float) 249 / 255.0f)
                                                                           alpha:1.0f];
    
    self.segmentedPager.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor darkGrayColor]};
    self.segmentedPager.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedPager.segmentedControl.selectionIndicatorColor = [UIColor blackColor];
    self.segmentedPager.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedPager.segmentedControl.selectionIndicatorHeight = 3.0;
    self.segmentedPager.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedPager.segmentedControlPosition = MXSegmentedControlPositionTop;
    self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(12, 12, 0, 12);
//    self.segmentedPager.frame = CGRectMake(0, 64, self.view.frame.size.width, 50);
}

- (IBAction)onClickMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addPage:(NSString*)title controller:(UIViewController*)controller{
    [titlesArray addObject:title];
    [controllersArray addObject:controller];
    [viewsArray addObject:controller.view];
}

//Here you can get to know , which view user has selected.
-(void)segmentedPager:(MXSegmentedPager *)segmentedPager didSelectViewWithIndex:(NSInteger)index{
    NSLog(@"%ld page selected.", (long)index);
}

- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager titleForSectionAtIndex:(NSInteger)index {
    return titlesArray[index];
}

-(UIView *)segmentedPager:(MXSegmentedPager *)segmentedPager viewForPageAtIndex:(NSInteger)index{
    return (UIView*) viewsArray[index];
}

-(UIViewController *)segmentedPager:(MXSegmentedPager *)segmentedPager viewControllerForPageAtIndex:(NSInteger)index{
    return (UIViewController*) controllersArray[index];
}

-(NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager{
    return [controllersArray count];
}

//- (void)prepareForSegue:(MXPageSegue *)segue sender:(id)sender {
//    MXNumberViewController *numberViewController = segue.destinationViewController;
//    numberViewController.number = segue.pageIndex;
//}
//
//#pragma mark <MXSegmentedPagerControllerDataSource>
//
//- (NSInteger)numberOfPagesInSegmentedPager:(MXSegmentedPager *)segmentedPager {
//    return 10;
//}
//
//- (NSString *)segmentedPager:(MXSegmentedPager *)segmentedPager segueIdentifierForPageAtIndex:(NSInteger)index {
//    return @"number";
//}

@end
