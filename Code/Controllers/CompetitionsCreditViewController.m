//
//  CompetitionsCreditViewController.m
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 17.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CompetitionsCreditViewController.h"

@interface CompetitionsCreditViewController ()

@end

@implementation CompetitionsCreditViewController
@synthesize toTopButton;
@synthesize scrollView;
@synthesize bigArrows;

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
    [self scrollView].contentSize = CGSizeMake(1024, 3395);
    self.scrollView.contentOffset = CGPointMake(0,0);
    // Анимация стрелок
    for (int i = 0; i < self.bigArrows.count; i++) {
        UIImageView *person = [self.bigArrows objectAtIndex:i];
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            CGRect frame = person.frame;
            frame.origin.x += 30;
            person.frame = frame;
        } completion:nil];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollView.contentOffset.y >= 60)
    {
        toTopButton.hidden = NO;
    } else {
        toTopButton.hidden = YES;
    }
}
- (IBAction)backToTop:(id)sender {
    [self scrollTo:0];
}



- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setBigArrows:nil];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)btnStep1:(id)sender {
    [self scrollTo:550];
     
}

- (IBAction)btnStep2:(id)sender {
    [self scrollTo:1500];
}

- (IBAction)btnStep3:(id)sender {
    [self scrollTo:2400];
}
@end
