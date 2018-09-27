//
//  KIProgressViewManager.m
//  Progress
//
//  Created by kaiinui on 2014/09/15.
//  Copyright (c) 2014年 kaiinui. All rights reserved.
//

#import "KIProgressViewManager.h"

#import "KIProgressView.h"

@interface KIProgressViewManager ()

@property KIProgressView *progressView;

@end

@implementation KIProgressViewManager

# pragma mark - Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

# pragma mark - Singleton

+ (instancetype)manager {
    static KIProgressViewManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

# pragma mark - Public

- (void)showProgressOnView:(UIView *)view {
    self.progressView = [self initializeProgressViewWithFrame:view.frame];
    
    [view addSubview:self.progressView];
}

- (void)hideProgressView {
    [self.progressView removeFromSuperview];
}

# pragma mark - Initialization

- (void)initialize {
    self.style = KIProgressViewStyleProgressBar;
    self.position = KIProgressViewPositionTop;
    self.gradientStartColor = [UIColor colorWithRed:62.0f/255.0f green:178.0f/255.0f blue:233.0f/255.0f alpha:1.0];
    self.gradientEndColor = [UIColor colorWithRed:62.0f/255.0f green:178.0f/255.0f blue:233.0f/255.0f alpha:1.0];
    self.height = 5.0f;
}

# pragma mark - Helpers (KIProgressView)

- (KIProgressView *)initializeProgressViewWithFrame:(CGRect)aFrame {
    CGFloat width = aFrame.size.width;
    CGFloat height = aFrame.size.height;
    CGRect frame = CGRectMake(0, 0, width, self.height);
    if (self.position == KIProgressViewPositionBottom) {
        frame = CGRectMake(0, height - self.height, width, self.height);
    }
    KIProgressView *progressView = [[KIProgressView alloc] initWithFrame:frame];
    
    if (self.color) {
        progressView.backgroundColor = self.color;
        return progressView;
    }
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = progressView.bounds;
    gradient.startPoint = CGPointMake(0, width);
    gradient.endPoint = CGPointMake(0, 0);
    gradient.colors = [NSArray arrayWithObjects:(id)[self.gradientStartColor CGColor], (id)[self.gradientEndColor CGColor], nil];
    
    [progressView.layer insertSublayer:gradient atIndex:0];
    
    return progressView;
}

@end
