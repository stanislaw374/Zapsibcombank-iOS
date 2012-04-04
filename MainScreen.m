//
//  MainScreen.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScreen.h"
#import "News.h"
#import "DetailsScreen.h"
#import "MapScreen.h"

@interface MainScreen()
@end

@implementation MainScreen
@synthesize news = _news;
@synthesize lblCurrencyDate = _lblCurrencyDate;
@synthesize btnAddresses = _btnAddresses;

- (News *)news {
    if (!_news) {
        _news = [[News alloc] init];
    }
    return _news;
}

- (IBAction)onServiceButtonClick:(UIButton *)sender {
    DetailsScreen *detailsScreen = [[DetailsScreen alloc] init];
    [self.navigationController pushViewController:detailsScreen animated:YES];
    detailsScreen.service = sender.titleLabel.text;
}

- (IBAction)showAddresses {
    MapScreen *mapScreen = [[MapScreen alloc] init];
    [self.navigationController pushViewController:mapScreen animated:YES];
}

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
    [self.news update];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM.yyyy";
    self.lblCurrencyDate.text = [df stringFromDate:[NSDate date]];
    
    CGSize textSize = [[self.btnAddresses titleForState:UIControlStateNormal] sizeWithFont:[UIFont boldSystemFontOfSize:15]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidUnload
{
    [self setNews:nil];
    [self setLblCurrencyDate:nil];
    [self setBtnAddresses:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
