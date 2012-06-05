//
//  LongBusinessCreditViewController.m
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 17.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LongBusinessCreditViewController.h"

@interface LongBusinessCreditViewController ()

@end

@implementation LongBusinessCreditViewController
@synthesize toTopButton;
@synthesize scrollView;
@synthesize angleArrow;
@synthesize persons;

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
    scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(1024,6500);
    
    // Анимация человечков
    for (int i = 0; i < self.persons.count; i++) {
        UIImageView *person = [self.persons objectAtIndex:i];
        [UIView animateWithDuration:0.5f delay:0.25f * i options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            CGRect frame = person.frame;
            frame.origin.y -= 20;
            person.frame = frame;
        } completion:nil];
    }
    
    [self animateAngleArrow];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setAngleArrow:nil];
    [self setPersons:nil];
    [self setToTopButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) scrollTo:(float)height {
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 1.0f];
    self.scrollView.contentOffset = CGPointMake(0, height);
    [UIView commitAnimations];
}

- (IBAction)btnAutoClick:(id)sender {
    [self scrollTo:1750];
}

- (IBAction)btnDeviceClick:(id)sender {
    [self scrollTo:2650];
}

- (IBAction)btnBusinessClick:(id)sender {
    [self scrollTo:3640];
}

- (IBAction)btnBuildClick:(id)sender {
    [self scrollTo:4550];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.y >= 60)
    {
        toTopButton.hidden = NO;
    } else {
        toTopButton.hidden = YES;
    }
}
- (IBAction)btnReconstructionClick:(id)sender {
    [self scrollTo:5450];
}
- (IBAction)backToTop:(id)sender {
    [self scrollTo:0];
}

-(void) animateAngleArrow {
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction  animations:^{
        CGRect frame = self.angleArrow.frame;
        frame.origin.y -= 10;
        frame.origin.x += 20;
        self.angleArrow.frame = frame;
    }completion:nil];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
