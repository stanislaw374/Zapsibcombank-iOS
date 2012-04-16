//
//  LoadingScreen.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoadingScreen.h"
#import "OCProgress.h"
#import "MainScreen.h"
#import "SCAppUtils.h"
#import <QuartzCore/QuartzCore.h>

#define MAX_PROGRESS 184

@interface LoadingScreen()
- (void)onTimerFired:(NSTimer *)timer;
- (void)preloadData;
@end

@implementation LoadingScreen
@synthesize progressView;
@synthesize progressBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    UIColor *progressRemainingColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading_progress_bar_back.png"]];
//    UIColor *progressColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loading_progress_bar_pattern.png"]];
    
//    OCProgress *objProgresscontroller = [[OCProgress alloc] initWithFrame:self.progressView.frame];
//    objProgresscontroller.minValue = 0;
//    objProgresscontroller.maxValue = 3;
//    objProgresscontroller.lineColor = [UIColor clearColor];
//    objProgresscontroller.progressColor = progressColor;
//    objProgresscontroller.progressRemainingColor = progressRemainingColor;
//    objProgresscontroller.currentValue = 0;
//
//    [self.view addSubview:objProgresscontroller];
//    self.progressView = objProgresscontroller;
    
    [NSTimer scheduledTimerWithTimeInterval:0.001f target:self selector:@selector(onTimerFired:) userInfo:nil repeats:YES];
    
    self.progressBar.layer.cornerRadius = 5;
    self.progressBar.layer.masksToBounds = YES;
    
    
}

- (void)preloadData {
    
}

- (void)viewDidUnload
{
    [self setProgressView:nil];
    [self setProgressView:nil];
    [self setProgressBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (void)onTimerFired:(NSTimer *)timer {
    CGRect frame = self.progressBar.frame;
    frame.size.width++;
    self.progressBar.frame = frame;
    
    if (self.progressBar.frame.size.width == MAX_PROGRESS) {
        MainScreen *mainScreen = [[MainScreen alloc] init];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainScreen];
                navigationController.navigationBarHidden = YES;
                [SCAppUtils customizeNavigationController:navigationController];
                [self presentModalViewController:navigationController animated:NO];
    }
    
//    if (self.progressView.currentValue == self.progressView.maxValue) {
//        [timer invalidate];
//        
//        MainScreen *mainScreen = [[MainScreen alloc] init];
//        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mainScreen];
//        navigationController.navigationBarHidden = YES;
//        [SCAppUtils customizeNavigationController:navigationController];
//        [self presentModalViewController:navigationController animated:NO];
//    }
//    else {
//        self.progressView.currentValue++;
//    }
}

@end
