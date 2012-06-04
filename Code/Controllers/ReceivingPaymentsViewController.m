//
//  ReceivingPaymentsViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReceivingPaymentsViewController.h"

@interface ReceivingPaymentsViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ReceivingPaymentsViewController
@synthesize persons;
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake(1024, 1223);
    int i = 0;
    for (UIImageView *person in self.persons) {
        [UIView animateWithDuration:0.5f delay:0.25f * i++ options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
            CGRect frame = person.frame;
            frame.origin.y -= 15;
            person.frame = frame;
        } completion:nil];
    }
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPersons:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
