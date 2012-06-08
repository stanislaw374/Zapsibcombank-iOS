//
//  PackageOfServicesViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PackageOfServicesViewController.h"

@interface PackageOfServicesViewController()
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *tableScrollView;
@end

@implementation PackageOfServicesViewController
@synthesize scrollView;
@synthesize tableScrollView;

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
    [self.startImages addObject:[UIImage imageNamed:@"01_02_page2.png"]];
    [self.startImages addObject:[UIImage imageNamed:@"01_02_page1.png"]];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake(1024, 5000);
    self.tableScrollView.contentSize = CGSizeMake(1486, 712);
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setTableScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
