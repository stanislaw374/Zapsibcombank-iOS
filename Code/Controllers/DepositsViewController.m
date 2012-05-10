//
//  CashManagementViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 08.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DepositsViewController.h"
#import <QuartzCore/QuartzCore.h> 
@interface DepositsViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblOvernightDeposit;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblStandardDeposit;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblConstructorDeposit;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblPartnerDeposit;

- (IBAction)showOvernightDeposit;
- (IBAction)showStandardDeposit;
- (IBAction)showConstructorDeposit;
- (IBAction)showPartnerDeposit;
@end

@implementation DepositsViewController
@synthesize imgRed;
@synthesize imgViolet;
@synthesize imgGreen;
@synthesize txtRed;
@synthesize txtViolet;
@synthesize txtGreen;
@synthesize bluePlus;
@synthesize blueGear1;
@synthesize blueGear2;
@synthesize blueGear3;
@synthesize scrollView;
@synthesize lblOvernightDeposit;
@synthesize lblStandardDeposit;
@synthesize lblConstructorDeposit;
@synthesize lblPartnerDeposit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self animateFirstArrows];
    // Do any additional setup after loading the view from its nib.    
    self.scrollView.contentSize = CGSizeMake(1024, 4854);
}
-(void) viewDidAppear:(BOOL)animated{
    [self animateFirstArrows];
}

-(void)animateFirstArrows{
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.bluePlus.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }completion:nil];

}
- (void)viewDidUnload
{
    [self setLblOvernightDeposit:nil];
    [self setLblStandardDeposit:nil];
    [self setLblConstructorDeposit:nil];
    [self setLblPartnerDeposit:nil];
    [self setScrollView:nil];
    [self setImgRed:nil];
    [self setImgViolet:nil];
    [self setImgGreen:nil];
    [self setTxtRed:nil];
    [self setTxtViolet:nil];
    [self setTxtGreen:nil];
    [self setBlueGear1:nil];
    [self setBlueGear2:nil];
    [self setBlueGear3:nil];
    [self setBluePlus:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showOvernightDeposit {
    
}

- (IBAction)showStandardDeposit {
}

- (IBAction)showConstructorDeposit {
}

- (IBAction)showPartnerDeposit {
}

- (IBAction)bluePlusClick:(id)sender {
    if ([sender tag] == 1){
        [sender setTag:3];
        [[self.bluePlus layer] removeAllAnimations];
        self.bluePlus.transform = CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:1.0f
                         animations:^{
                             CGRect frame = imgRed.frame;
                             frame.origin.x += 540;
                             imgRed.frame = frame;
                             
                             frame = txtRed.frame;
                             frame.origin.x -= 458;
                             txtRed.frame = frame; 
                             
                         }completion:^(BOOL finished){
                             [UIView animateWithDuration:1.0f
                                              animations:^{
                                                  CGRect frame = imgViolet.frame;
                                                  frame.origin.x += 558;
                                                  imgViolet.frame = frame;
                                                  
                                                  frame = txtViolet.frame;
                                                  frame.origin.x -= 458;
                                                  txtViolet.frame = frame;                                              
                                              
                                              }completion:^(BOOL finished){
                                                  [UIView animateWithDuration:1.0f
                                                                   animations:^{
                                                                       CGRect frame = imgGreen.frame;
                                                                       frame.origin.x += 540;
                                                                       imgGreen.frame = frame;
                                                                       
                                                                       frame = txtGreen.frame;
                                                                       frame.origin.x -= 458;
                                                                       txtGreen.frame = frame;                                              
                                                                       
                                                                   }completion:nil];
                                              }];
                         }];
        
    }

}
@end
