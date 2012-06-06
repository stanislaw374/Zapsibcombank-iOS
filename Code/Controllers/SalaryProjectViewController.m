//
//  SalaryProjectViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SalaryProjectViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SalaryProjectViewController()
{
    CGPoint _arrowLocations[4];
    CGPoint _labelLocations[4];
    BOOL _isPlusClicked;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *swings;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows2;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *plus;
- (IBAction)onPlusClick;
@end

@implementation SalaryProjectViewController
@synthesize morePluses;
@synthesize scrollView;
@synthesize arrows;
@synthesize swings;
@synthesize arrows2;
@synthesize labels;
@synthesize plus;

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
    self.scrollView.contentSize = CGSizeMake(1024, 2113);
    
    // Анимация стрелок
    for (UIImageView *arrow in self.arrows) {
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin.y -= 20;
            arrow.frame = frame;
        } completion:nil];
    }
    
    // Анимация весов
    const double degree = 2.0;
    self.swings.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.0);
    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
        self.swings.transform = CGAffineTransformRotate(self.swings.transform, - 2 * degree * M_PI / 180.0);
    } completion:nil];
    
    // Анимация увеличивающегося и уменьшающегося плюса!
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut |UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.plus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    } completion:nil];
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows2.count; i++) {
        UIImageView *arrow = [self.arrows2 objectAtIndex:i];
        _arrowLocations[i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels.count; i++) {
        UILabel *label = [self.labels objectAtIndex:i];
        _labelLocations[i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setArrows:nil];
    [self setSwings:nil];
    [self setArrows2:nil];
    [self setLabels:nil];
    [self setPlus:nil];
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

- (IBAction)onPlusClick {  
    if (_isPlusClicked) return;
    _isPlusClicked = YES;
    [self.plus.layer removeAllAnimations];
    self.plus.transform = CGAffineTransformMakeScale(1, 1);
    
    // Узнать больше плюсов улетает
    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
        CGRect frame = morePluses.frame;
        frame.origin.x -= 2000;
        morePluses.frame = frame;
    }completion:nil];

    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows2.count; i++) {
        UIImageView *arrow = [self.arrows2 objectAtIndex:i];
        UILabel *label = [self.labels objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations[i];
                label.frame = frame;
            } completion:nil];
        }];
    }
}

@end
