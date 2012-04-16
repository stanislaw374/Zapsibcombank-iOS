//
//  InfoView.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 11.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutView.h"

@interface AboutView ()

@end

@implementation AboutView

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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)showWebsite {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://createdigital.me"]];
}

- (IBAction)close {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

@end
