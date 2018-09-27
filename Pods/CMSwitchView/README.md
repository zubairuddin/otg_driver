# CMSwichView
Customizable switch view

## CMSwitchView Properties:
```objc
/// If you want to have rounded dots and switch view or not, YES by default
@property (nonatomic, assign) BOOL rounded;
/// Width of the border, 1 by default
@property (nonatomic, assign) CGFloat borderWidth;
/// color of the border, white by default
@property (nonatomic, assign) UIColor* borderColor;
/// color of the background of the switch view, clearColor by default
@property (nonatomic, strong) UIColor* color;
/// color of the background of the switch view when switched, clearColor by default
@property (nonatomic, strong) UIColor* tintColor;
/// width and height of the dot, frameHeight-2 by default
@property (nonatomic, assign) CGFloat dotWeight;
/// color of the dot, white by default
@property (nonatomic, strong) UIColor* dotColor;
/// duration of the animation, 0.6 by default
@property (nonatomic, assign) NSTimerInterval animDuration;
/// delegate to be set
@property (nonatomic, weak) id<CMSwitchViewDelegate> delegate;
```

## CMSSwitchView Delegation : CMSSwitchViewDelegate
Called when the switch view is clicked or when you move the dot after the middle with the pan gesture, sending you the new value
```objc
- (void)switchValueChanged:(id)sender andNewValue:(BOOL)value;
```

## CMSSwitchView Usage Example:
```objc
    self.firstSwitch = [[CMSwitchView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-150, 100, 300, 50)];
    self.firstSwitch.dotColor = [UIColor blueColor];
    self.firstSwitch.color = [UIColor whiteColor];
    self.firstSwitch.tintColor = [UIColor clearColor];
    [self.view addSubview:self.firstSwitch];
    
    self.secondSwitch = [[CMSwitchView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.firstSwitch.frame.size.height+self.firstSwitch.frame.origin.y+100, 200, 60)];
    self.secondSwitch.dotColor = [UIColor whiteColor];
    self.secondSwitch.color = [UIColor clearColor];
    self.secondSwitch.tintColor = [UIColor clearColor];
    self.secondSwitch.dotWeight = 20.f;
    [self.view addSubview:self.secondSwitch];
    
    self.thirdSwitch = [[CMSwitchView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.secondSwitch.frame.size.height+self.secondSwitch.frame.origin.y+100, 100, 30)];
    self.thirdSwitch.animDuration = 2.f;
    self.thirdSwitch.isRounded = NO;
    [self.view addSubview:self.thirdSwitch];
```
![Gif](./Screenshots/switchviewdemo.gif)

## Installation
CMSwitchView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CMSwitchView"
```

## Author
Mycose, morissard@gmail.com

## License
CMSwitchView is available under the MIT license. See the LICENSE file for more info.

## TODO
- Support for images for the dots
