//
//  VipDepositViewController.m
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VipDepositViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface VipDepositViewController ()
{
    CGPoint _arrowLocations[4][4];
    CGPoint _labelLocations[4][4];
    BOOL _isPlusClicked[4];
}

@end

@implementation VipDepositViewController
@synthesize pluses;
@synthesize arrows1;
@synthesize labels1;
@synthesize mech1;
@synthesize arrows2;
@synthesize labels2;
@synthesize mech2;
@synthesize arrows3;
@synthesize labels3;
@synthesize mech3;
@synthesize arrows4;
@synthesize labels4;
@synthesize mech4;
@synthesize morePluses1;
@synthesize morePluses2;
@synthesize morePluses3;
@synthesize morePluses4;
@synthesize toTopButton;

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Скроллинг до height
-(void) scrollTo:(float)height {
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 1.0f];
    self.scrollView.contentOffset = CGPointMake(0, height);
    [UIView commitAnimations];

}
 
-(void) animateMechs {
    const int duration = 10;
    
    for (UIImageView *gear in self.mech1) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    for (UIImageView *gear in self.mech2) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:-360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    for (UIImageView *gear in self.mech3) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    for (UIImageView *gear in self.mech4) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }

}

-(void)hideArrowsAndLabels{
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows1.count; i++) {
        UIImageView *arrow = [self.arrows1 objectAtIndex:i];
        _arrowLocations[0][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels1.count; i++) {
        UILabel *label = [self.labels1 objectAtIndex:i];
        _labelLocations[0][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
//    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows2.count; i++) {
        UIImageView *arrow = [self.arrows2 objectAtIndex:i];
        _arrowLocations[1][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels2.count; i++) {
        UILabel *label = [self.labels2 objectAtIndex:i];
        _labelLocations[1][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows3.count; i++) {
        UIImageView *arrow = [self.arrows3 objectAtIndex:i];
        _arrowLocations[2][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels3.count; i++) {
        UILabel *label = [self.labels3 objectAtIndex:i];
        _labelLocations[2][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows4.count; i++) {
        UIImageView *arrow = [self.arrows4 objectAtIndex:i];
        _arrowLocations[3][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels4.count; i++) {
        UILabel *label = [self.labels4 objectAtIndex:i];
        _labelLocations[3][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
}

- (void)viewDidLoad
{
    [self.startImages addObject:[UIImage imageNamed:@"00_start_11-2.png"]];
    [self.startImages addObject:[UIImage imageNamed:@"00_start_11-1.png"]];
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(1024,4200);
    [self hideArrowsAndLabels];
    
    // Анимация увеличивающегося и уменьшающегося плюса

    // Анимация увеличивающегося и уменьшающегося плюса
    for (UIImageView *plus in self.pluses) {
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut |UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
            plus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        } completion:nil];
    }    
    self.scrollView.delegate = self;
    [self animateMechs];
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setArrows1:nil];
    [self setLabels1:nil];
    [self setMech1:nil];
    [self setArrows2:nil];
    [self setLabels2:nil];
    [self setMech2:nil];
    [self setArrows3:nil];
    [self setLabels3:nil];
    [self setMech3:nil];
    [self setArrows4:nil];
    [self setLabels4:nil];
    [self setMech4:nil];
    [self setToTopButton:nil];
    [self setPluses:nil];
    [self setMorePluses1:nil];
    [self setMorePluses2:nil];
    [self setMorePluses3:nil];
    [self setMorePluses4:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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



- (IBAction)orangeBtnClick:(id)sender {
    [self scrollTo:400];
}

- (IBAction)blueBtnClick:(id)sender {
    [self scrollTo:1300];
}

- (IBAction)greenBtnClick:(id)sender {
    [self scrollTo:2300];
}

- (IBAction)violetBtnClick:(id)sender {
    [self scrollTo:3200];
}

- (IBAction)onPlusButtonClick:(UIButton *)sender { 
    int n = sender.tag;
    
    if (_isPlusClicked[n]) return;
    _isPlusClicked[n] = YES;
    
    UIImageView *plus = [self.pluses objectAtIndex:n];
    [plus.layer removeAllAnimations];
    plus.transform = CGAffineTransformMakeScale(1, 1);
    
    NSArray *arrows, *labels;
    UIImageView *morePlus;
    switch (n) {
        case 0:
            arrows = self.arrows1; 
            labels = self.labels1;
            morePlus = morePluses1;
            break;
        case 1: 
            arrows = self.arrows2; 
            labels = self.labels2; 
            morePlus = morePluses2;
            break;
        case 2: 
            arrows = self.arrows3; 
            labels = self.labels3; 
            morePlus = morePluses3;
            break;
        case 3: 
            arrows = self.arrows4; 
            labels = self.labels4;
            morePlus = morePluses4;
            break;
    }
    
    // Узнать больше плюсов улетает
    [UIView animateWithDuration:1.0f delay:0 options:UIViewAnimationOptionAllowUserInteraction  animations:^{
        CGRect frame = morePlus.frame;
        frame.origin.x -= 2000;
        morePlus.frame = frame;
    }completion:nil];
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < arrows.count; i++) {
        UIImageView *arrow = [arrows objectAtIndex:i];
        UILabel *label = [labels objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations[n][i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations[n][i];
                label.frame = frame;               
            } completion:nil];
        }];
    }
}
@end
