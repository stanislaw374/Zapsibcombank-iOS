//
//  DepositServiceViewController.m
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 22.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DepositServiceViewController.h"

@interface DepositServiceViewController ()

@end

@implementation DepositServiceViewController
@synthesize scrollView;

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
    
    [self.startImages addObject:[UIImage imageNamed:@"00_start_10-2.png"]];
    [self.startImages addObject:[UIImage imageNamed:@"00_start_10-1.png"]];
    [self scrollView].contentSize = CGSizeMake(1024, 1400);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
