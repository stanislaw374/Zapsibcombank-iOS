//
//  ConversionOperationsViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ConversionOperationsViewController.h"

@interface ConversionOperationsViewController ()
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *persons;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow3;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow4;
@end

@implementation ConversionOperationsViewController
@synthesize scrollView;
@synthesize persons;
@synthesize arrow1;
@synthesize arrow2;
@synthesize arrow3;
@synthesize arrow4;

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
    self.scrollView.contentSize = CGSizeMake(1024, 1545);
    
    // Прыгающие человечки
    int i = 0;
    for (UIImageView *person in self.persons) {
        [UIView animateWithDuration:0.5f delay:0.25f * i++ options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            CGRect frame = person.frame;
            frame.origin.y -= 20;
            person.frame = frame;
        } completion:nil];
    }
    
    // Двигающиеся стрелки
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        CGRect frame = self.arrow1.frame;
        frame.origin.x += 40;
        self.arrow1.frame = frame;
        
        frame = self.arrow2.frame;
        frame.origin.x += 40;
        self.arrow2.frame = frame;
        
        frame = self.arrow3.frame;
        frame.origin.y += 40;
        self.arrow3.frame = frame;
        
        frame = self.arrow4.frame;
        frame.origin.x -= 40;
        self.arrow4.frame = frame;
    } completion:nil];
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPersons:nil];
    [self setArrow1:nil];
    [self setArrow2:nil];
    [self setArrow3:nil];
    [self setArrow4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
