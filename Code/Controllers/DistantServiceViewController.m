//
//  DistantServiceViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 09.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DistantServiceViewController.h"
#import <QuartzCore/QuartzCore.h> 
@interface DistantServiceViewController()
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DistantServiceViewController
@synthesize speedImage;
@synthesize usabilityImage;
@synthesize accessImage;
@synthesize speedText;
@synthesize txtUsability_1;
@synthesize txtUsability_2;
@synthesize txtUsability_3;
@synthesize txtAccess_1;
@synthesize txtAccess_3;
@synthesize txtAccess_2;
@synthesize btnPlus;
@synthesize btnFrame;
@synthesize txtFrame;
@synthesize hideView;
@synthesize morePluses;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Добавление стартовых страниц
        [self.startImages addObject:[UIImage imageNamed:@"01_05_page2.png"]];
        [self.startImages addObject:[UIImage imageNamed:@"01_05_page1.png"]];
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
    //[self animatePlus];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.contentSize = CGSizeMake(1024, 1606);
    [self animatePlus];
    [self animateFrameButton];
}

-(void) viewDidAppear:(BOOL)animated{
    
}

-(void)animatePlus{
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.btnPlus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    }completion:nil];
}

-(void) animateFrameButton{
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.btnFrame.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    }completion:nil];
}
- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setSpeedImage:nil];
    [self setUsabilityImage:nil];
    [self setAccessImage:nil];
    [self setSpeedText:nil];
    [self setTxtUsability_1:nil];
    [self setTxtUsability_2:nil];
    [self setTxtUsability_3:nil];
    [self setTxtAccess_1:nil];
    [self setTxtAccess_2:nil];
    [self setTxtAccess_3:nil];
    [self setBtnPlus:nil];
    [self setBtnFrame:nil];
    [self setTxtFrame:nil];
    [self setHideView:nil];
    [self setMorePluses:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)animateLabels:(id)sender {
    // Узнать больше плюсов улетает
    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
        CGRect frame = morePluses.frame;
        frame.origin.x -= 2000;
        morePluses.frame = frame;
    }completion:nil];

    
    // [self animatePlus];
    if ([sender tag] == 1){
        [sender setTag:3];
        [[self.btnPlus layer] removeAllAnimations];
        self.btnPlus.transform = CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:1.0f
                         animations:^{
                             CGRect frame = speedImage.frame;
                             frame.origin.x += 420;
                             speedImage.frame = frame;
                             
                             frame = usabilityImage.frame;
                             frame.origin.x += 615;
                             usabilityImage.frame = frame; 
                             frame = accessImage.frame;
                             frame.origin.x += 420;
                             accessImage.frame = frame;
                             
                         }completion:^(BOOL finished){
                             [UIView animateWithDuration:1.0f
                                              animations:^{
                                                  CGRect frame = speedText.frame;
                                                  frame.origin.x -= 917;
                                                  speedText.frame = frame;
                                                  
                                                  frame = txtAccess_1.frame;
                                                  frame.origin.x -= 917;
                                                  txtAccess_1.frame = frame; 
                                                  frame = txtAccess_2.frame;
                                                  frame.origin.x -= 917;
                                                  txtAccess_2.frame = frame;
                                                  frame = txtAccess_3.frame;
                                                  frame.origin.x -= 917;
                                                  txtAccess_3.frame = frame;
                                                  
                                                  frame = txtUsability_1.frame;
                                                  frame.origin.x -= 718;
                                                  txtUsability_1.frame = frame;
                                                  frame = txtUsability_2.frame;
                                                  frame.origin.x -= 718;
                                                  txtUsability_2.frame = frame;
                                                  frame = txtUsability_3.frame;
                                                  frame.origin.x -= 718;
                                                  txtUsability_3.frame = frame;
                                                  
                                              }completion:nil];
                         }];
        
    }
}

- (IBAction)animateFrame:(id)sender {
    if ([sender tag] == 2){
        [sender setTag:4];
        [[self.btnFrame layer] removeAllAnimations];
        self.btnFrame.transform = CGAffineTransformMakeScale(1, 1);
        self.scrollView.contentSize = CGSizeMake(1024, 2136);
        [UIView animateWithDuration:1.0f
                         animations:^{
                             CGRect frame = btnFrame.frame;
                             frame.origin.x += 892;
                             btnFrame.frame = frame;
                             
                             frame = txtFrame.frame;
                             frame.origin.x += 1242;
                             txtFrame.frame = frame; 
                             
                             frame = self.hideView.frame;
                             frame.size.height += 530;
                             hideView.frame = frame;
                             
                             
                         }completion:nil];
    }
}
@end
