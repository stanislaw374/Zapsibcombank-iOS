//
//  AcquiringViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AcquiringViewController.h"

@interface AcquiringViewController ()
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *persons;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *points;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation AcquiringViewController
@synthesize persons;
@synthesize points;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Добавление стартовых страниц
        [self.startImages addObject:[UIImage imageNamed:@"03_01_page3.png"]];
        [self.startImages addObject:[UIImage imageNamed:@"03_01_page2.png"]];
        [self.startImages addObject:[UIImage imageNamed:@"03_01_page1.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.contentSize = CGSizeMake(1024, 1147);
    
    // Анимация подпрыгивающих человечков
    int i = 0;
    for (UIImageView *person in self.persons) {
        [UIView animateWithDuration:0.5f delay:0.25f * i++ options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
            CGRect frame = person.frame;
            frame.origin.y -= 15;
            person.frame = frame;
        } completion:nil];
    }
    
    // Анимация точек
    for (UIImageView *point in self.points) {
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            point.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        } completion:nil];
    }
}

- (void)viewDidUnload
{
    [self setPersons:nil];
    [self setPoints:nil];
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
