//
//  CashServicesViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CashServicesViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CashServicesViewController() 
{
    CGPoint _arrowLocations[3];
    CGPoint _labelLocations[3];
    BOOL _isPlusClicked;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *persons;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *plus;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
- (IBAction)onPlusClick;
@end

@implementation CashServicesViewController
@synthesize scrollView;
@synthesize persons;
@synthesize plus;
@synthesize arrows;
@synthesize labels;

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
    self.scrollView.contentSize = CGSizeMake(1024, 1717);
    
    // Анимация человечков
    for (int i = 0; i < self.persons.count; i++) {
        UIImageView *person = [self.persons objectAtIndex:i];
        [UIView animateWithDuration:0.5f delay:0.25f * i options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            CGRect frame = person.frame;
            frame.origin.y -= 20;
            person.frame = frame;
        } completion:nil];
    }
    
    // Анимация увеличивающегося и уменьшающегося сердца
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
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
    [self setPersons:nil];
    [self setPlus:nil];
    [self setArrows:nil];
    [self setLabels:nil];
    [self setPlus:nil];
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
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows.count; i++) {
        UIImageView *arrow = [self.arrows objectAtIndex:i];
        UILabel *label = [self.labels objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:0 animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:0 animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations[i];
                label.frame = frame;
            } completion:nil];
        }];
    }
}

@end
