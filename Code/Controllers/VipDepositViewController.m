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
    CGPoint _arrowLocations1[3];
    CGPoint _labelLocations1[3];
    
    CGPoint _arrowLocations2[3];
    CGPoint _labelLocations2[3];
    
    CGPoint _arrowLocations3[3];
    CGPoint _labelLocations3[3];
    
    CGPoint _arrowLocations4[3];
    CGPoint _labelLocations4[3];
    
    BOOL _isOrangePlusClicked;
    BOOL _isBluePlusClicked;
    BOOL _isGreenPlusClicked;
    BOOL _isVioletPlusClicked;
}

@end

@implementation VipDepositViewController
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
@synthesize violetPlus;
@synthesize greenPlus;
@synthesize bluePlus;
@synthesize orangeBtn;
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
// скрытие всех стрелок и лейблов у стрелок при загрузке страницы
-(void)hideArrowsAndLabels{
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows1.count; i++) {
        UIImageView *arrow = [self.arrows1 objectAtIndex:i];
        _arrowLocations1[i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels1.count; i++) {
        UILabel *label = [self.labels1 objectAtIndex:i];
        _labelLocations1[i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
//    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows2.count; i++) {
        UIImageView *arrow = [self.arrows2 objectAtIndex:i];
        _arrowLocations2[i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels2.count; i++) {
        UILabel *label = [self.labels2 objectAtIndex:i];
        _labelLocations2[i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows3.count; i++) {
        UIImageView *arrow = [self.arrows3 objectAtIndex:i];
        _arrowLocations3[i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels3.count; i++) {
        UILabel *label = [self.labels3 objectAtIndex:i];
        _labelLocations3[i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }   
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows4.count; i++) {
        UIImageView *arrow = [self.arrows4 objectAtIndex:i];
        _arrowLocations4[i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    
    // Сохранение позиций текста и перемещение текста за пределы экрана
    for (int i = 0; i < self.labels4.count; i++) {
        UILabel *label = [self.labels4 objectAtIndex:i];
        _labelLocations4[i] = label.frame.origin;
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
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut |UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.orangeBtn.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.bluePlus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.greenPlus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        self.violetPlus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    } completion:nil];
    
    [self animateMechs];
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setBluePlus:nil];
    [self setGreenPlus:nil];
    [self setOrangeBtn:nil];
    [self setBluePlus:nil];
    [self setGreenPlus:nil];
    [self setVioletPlus:nil];
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
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
- (IBAction)orangePlusClick:(id)sender {
    if (_isOrangePlusClicked) return;
    _isOrangePlusClicked = YES;
    [self.orangeBtn.layer removeAllAnimations];
    self.orangeBtn.transform = CGAffineTransformMakeScale(1, 1);
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows1.count; i++) {
        UIImageView *arrow = [self.arrows1 objectAtIndex:i];
        UILabel *label = [self.labels1 objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations1[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations1[i];
                label.frame = frame;
            } completion:nil];
        }];
    }
}
- (IBAction)bluePlusClick:(id)sender {
    if (_isBluePlusClicked) return;
    _isBluePlusClicked = YES;
    [self.bluePlus.layer removeAllAnimations];
    self.bluePlus.transform = CGAffineTransformMakeScale(1, 1);
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows2.count; i++) {
        UIImageView *arrow = [self.arrows2 objectAtIndex:i];
        UILabel *label = [self.labels2 objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations2[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations2[i];
                label.frame = frame;
            } completion:nil];
        }];
    }
}
- (IBAction)greenPlusClick:(id)sender {
    if (_isGreenPlusClicked) return;
    _isGreenPlusClicked = YES;
    [self.greenPlus.layer removeAllAnimations];
    self.greenPlus.transform = CGAffineTransformMakeScale(1, 1);
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows3.count; i++) {
        UIImageView *arrow = [self.arrows3 objectAtIndex:i];
        UILabel *label = [self.labels3 objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations3[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations3[i];
                label.frame = frame;
            } completion:nil];
        }];
    }

}
- (IBAction)violetPlusClick:(id)sender {
    if (_isVioletPlusClicked) return;
    _isVioletPlusClicked = YES;
    [self.violetPlus.layer removeAllAnimations];
    self.violetPlus.transform = CGAffineTransformMakeScale(1, 1);
    
    // Анимация выплывающих стрелок и текста
    for (int i = 0; i < self.arrows4.count; i++) {
        UIImageView *arrow = [self.arrows4 objectAtIndex:i];
        UILabel *label = [self.labels4 objectAtIndex:i];
        
        [UIView animateWithDuration:1 delay:i options:UIViewAnimationCurveEaseInOut animations:^{
            CGRect frame = arrow.frame;
            frame.origin = _arrowLocations4[i];
            arrow.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
                CGRect frame = label.frame;
                frame.origin = _labelLocations4[i];
                label.frame = frame;
            } completion:nil];
        }];
    }
}
@end
