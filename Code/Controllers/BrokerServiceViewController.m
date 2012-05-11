//
//  BrokerServiceViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 11.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrokerServiceViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BrokerServiceViewController ()
{
    CGPoint _arrowLocations[3];
    CGPoint _textLocations[3];
    BOOL _isPlusClicked;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *plus;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *texts;
- (IBAction)onPlusClick;
@end

@implementation BrokerServiceViewController
@synthesize scrollView;
@synthesize plus;
@synthesize arrows;
@synthesize texts;

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scrollView.contentSize = CGSizeMake(1024, 1986);
    
    // Анимация увеличивающегося и уменьшающегося плюса
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut |UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.plus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    } completion:nil];
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows.count; i++) {
        UIImageView *arrow = [self.arrows objectAtIndex:i];
        _arrowLocations[i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.texts.count; i++) {
        UIImageView *text = [self.texts objectAtIndex:i];
        _textLocations[i] = text.frame.origin;
        CGRect frame = text.frame;
        frame.origin.x = 1024;
        text.frame = frame;
    }
}

- (void)viewDidUnload
{
    [self setPlus:nil];
    [self setArrows:nil];
    [self setTexts:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)onPlusClick {  
    if (_isPlusClicked) return;
    _isPlusClicked = YES;
    
    [self.plus.layer removeAllAnimations];
    self.plus.transform = CGAffineTransformMakeScale(1, 1);
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows.count; i++) {
        UIImageView *arrow = [self.arrows objectAtIndex:i];
        UIImageView *text = [self.texts objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = text.frame;
                frame.origin = _textLocations[i];
                text.frame = frame;
            } completion:nil];
        }];
    }
}
@end
