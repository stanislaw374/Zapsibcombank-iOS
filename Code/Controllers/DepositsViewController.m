//
//  CashManagementViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 08.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DepositsViewController.h"

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
    // Do any additional setup after loading the view from its nib.    
    self.scrollView.contentSize = CGSizeMake(1024, 4854);
}

- (void)viewDidUnload
{
    [self setLblOvernightDeposit:nil];
    [self setLblStandardDeposit:nil];
    [self setLblConstructorDeposit:nil];
    [self setLblPartnerDeposit:nil];
    [self setScrollView:nil];
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

@end
