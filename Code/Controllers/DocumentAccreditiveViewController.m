//
//  DocumentAccreditiveViewController.m
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 21.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocumentAccreditiveViewController.h"

@interface DocumentAccreditiveViewController ()

@end

@implementation DocumentAccreditiveViewController
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
   
    [self.startImages addObject:[UIImage imageNamed:@"00_start_09-2.png"]];
    [self.startImages addObject:[UIImage imageNamed:@"00_start_09-1.png"]];
    // Do any additional setup after loading the view from its nib.
    [self scrollView].contentSize = CGSizeMake(1024, 1600);
     [super viewDidLoad];
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
