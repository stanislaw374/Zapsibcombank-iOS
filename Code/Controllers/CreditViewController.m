//
//  CreditViewController.m
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 16.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreditViewController.h"
#import "CreditExpressViewController.h"
#import "ShortCreditViewController.h"
#import "MicroCreditViewController.h"
#import "SevenDaysCreditViewController.h"
#import "LongBusinessCreditViewController.h"
#import "CompetitionsCreditViewController.h"

@interface CreditViewController ()

@end

@implementation CreditViewController


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
    [self.startImages addObject:[self.view viewWithTag:2]];
    [self.startImages addObject:[UIImage imageNamed:@"00_start_8_photo.png"]];
    self.scrollVIew.contentSize = CGSizeMake(1024, 1080);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setScrollVIew:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)draftClick:(id)sender {
    
    
}

- (IBAction)expressDraftClick:(id)sender {
}

- (IBAction)microCreditClick:(id)sender {
}

- (IBAction)shortCreditClick:(id)sender {
}

- (IBAction)longCreditClick:(id)sender {
}

- (IBAction)businessAutoClick:(id)sender {
}

- (IBAction)deviceClick:(id)sender {
}

- (IBAction)longClick:(id)sender {
}

- (IBAction)buildClick:(id)sender {
}

- (IBAction)recClick:(id)sender {
}

- (IBAction)sevenclick:(id)sender {
}

- (IBAction)concursClick:(id)sender {
}

- (IBAction)gosClick:(id)sender {
}

- (IBAction)gos2Click:(id)sender {
}
@end
