//
//  CashManagementViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 08.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DepositsViewController.h"
#import <QuartzCore/QuartzCore.h>


#import <QuartzCore/QuartzCore.h> 
@interface DepositsViewController ()
{
    CGPoint _arrowLocations[5][4];
    CGPoint _labelLocations[5][4];
    BOOL _isPlusClicked[5];
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblOvernightDeposit;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblStandardDeposit;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblConstructorDeposit;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblPartnerDeposit;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *pluses;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows1;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows2;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows3;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows4;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *gears1;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *gears2;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *gears3;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *gears4;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels1;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels2;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels3;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels4;

- (IBAction)showOvernightDeposit;
- (IBAction)showStandardDeposit;
- (IBAction)showConstructorDeposit;
- (IBAction)showPartnerDeposit;
- (IBAction)onPlusButtonClick:(UIButton *)sender;
@end

@implementation DepositsViewController
@synthesize morePluses1;
@synthesize morePluses2;
@synthesize morePluses3;
@synthesize morePluses4;
@synthesize morePluses5;
@synthesize imgRed;
@synthesize imgViolet;
@synthesize imgGreen;
@synthesize txtRed;
@synthesize txtViolet;
@synthesize txtGreen;
@synthesize bluePlus;
@synthesize blueGear1;
@synthesize blueGear2;
@synthesize blueGear3;
@synthesize arrows5;
@synthesize gears5;
@synthesize toTopButton;
@synthesize labels5;
@synthesize scrollView;
@synthesize lblOvernightDeposit;
@synthesize lblStandardDeposit;
@synthesize lblConstructorDeposit;
@synthesize lblPartnerDeposit;
@synthesize pluses;
@synthesize arrows1;
@synthesize arrows2;
@synthesize arrows3;
@synthesize arrows4;
@synthesize gears1;
@synthesize gears2;
@synthesize gears3;
@synthesize gears4;
@synthesize labels1;
@synthesize labels2;
@synthesize labels3;
@synthesize labels4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Добавление стартовых страниц
        [self.startImages addObject:[UIImage imageNamed:@"02_01_page2.png"]];
        [self.startImages addObject:[UIImage imageNamed:@"02_01_page1.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self animateFirstArrows];
    self.scrollView.delegate = self;
    // Do any additional setup after loading the view from its nib.    
    self.scrollView.contentSize = CGSizeMake(1024, 6000);
    
    // Анимация увеличивающегося и уменьшающегося плюса
    for (UIImageView *plus in self.pluses) {
        [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationCurveEaseInOut |UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction animations:^{
            plus.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
            } completion:nil];
    }
    
    // Сохранение позиций стрелок и перемещение их за пределы экрана
    for (int i = 0; i < self.arrows1.count; i++) {
        UIImageView *arrow = [self.arrows1 objectAtIndex:i];
        _arrowLocations[0][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    for (int i = 0; i < self.arrows2.count; i++) {
        UIImageView *arrow = [self.arrows2 objectAtIndex:i];
        _arrowLocations[1][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    for (int i = 0; i < self.arrows3.count; i++) {
        UIImageView *arrow = [self.arrows3 objectAtIndex:i];
        _arrowLocations[2][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }
    for (int i = 0; i < self.arrows4.count; i++) {
        UIImageView *arrow = [self.arrows4 objectAtIndex:i];
        _arrowLocations[3][i] = arrow.frame.origin;
        CGRect frame = arrow.frame;
        frame.origin.x = - arrow.frame.size.width;
        arrow.frame = frame;
    }   
    
    for (int i = 0; i < self.arrows5.count; i++) {
        UIImageView *arrow = [self.arrows5 objectAtIndex:i];
        _arrowLocations[4][i] = arrow.frame.origin;
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
    for (int i = 0; i < self.labels2.count; i++) {
        UILabel *label = [self.labels2 objectAtIndex:i];
        _labelLocations[1][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }
    for (int i = 0; i < self.labels3.count; i++) {
        UILabel *label = [self.labels3 objectAtIndex:i];
        _labelLocations[2][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }
    for (int i = 0; i < self.labels4.count; i++) {
        UILabel *label = [self.labels4 objectAtIndex:i];
        _labelLocations[3][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }
    
    for (int i = 0; i < self.labels5.count; i++) {
        UILabel *label = [self.labels5 objectAtIndex:i];
        _labelLocations[4][i] = label.frame.origin;
        CGRect frame = label.frame;
        frame.origin.x = 1024;
        label.frame = frame;
    }
        
    const int duration = 10;
    
    for (UIImageView *gear in self.gears1) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    for (UIImageView *gear in self.gears2) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:-360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    for (UIImageView *gear in self.gears3) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    
    for (UIImageView *gear in self.gears5) {           
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:360.0 * M_PI / 180.0];
        fullRotation.duration = duration;
        fullRotation.repeatCount = 1e100f;
        [gear.layer addAnimation:fullRotation forKey:@"360"];
    }
    
}
-(void) scrollTo:(float)height {
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 1.0f];
    self.scrollView.contentOffset = CGPointMake(0, height);
    [UIView commitAnimations];
}

- (IBAction)btnConstructClick:(id)sender {
    [self scrollTo:2900];
}

- (IBAction)btnOvernightClick:(id)sender {
    [self scrollTo:900];
}

- (IBAction)btnStandartClick:(id)sender {
    [self scrollTo:1900];
}

- (IBAction)btnPartnerClick:(id)sender {
    [self scrollTo:3900];
}

- (IBAction)btnIpClick:(id)sender {
    [self scrollTo:4900];
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
    [self scrollTo:280];
}




-(void) viewDidAppear:(BOOL)animated{
    [self animateFirstArrows];
}

-(void)animateFirstArrows{
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionAllowUserInteraction  animations:^{
        self.bluePlus.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }completion:nil];

}
- (void)viewDidUnload
{
    [self setLblOvernightDeposit:nil];
    [self setLblStandardDeposit:nil];
    [self setLblConstructorDeposit:nil];
    [self setLblPartnerDeposit:nil];
    [self setScrollView:nil];
    [self setPluses:nil];
    [self setArrows1:nil];
    [self setArrows2:nil];
    [self setArrows3:nil];
    [self setArrows4:nil];
    [self setGears1:nil];
    [self setGears2:nil];
    [self setGears3:nil];
    [self setGears4:nil];
    [self setLabels1:nil];
    [self setLabels2:nil];
    [self setLabels3:nil];
    [self setLabels4:nil];

    [self setImgRed:nil];
    [self setImgViolet:nil];
    [self setImgGreen:nil];
    [self setTxtRed:nil];
    [self setTxtViolet:nil];
    [self setTxtGreen:nil];
    [self setBlueGear1:nil];
    [self setBlueGear2:nil];
    [self setBlueGear3:nil];
    [self setBluePlus:nil];

    [self setArrows5:nil];
    [self setLabels5:nil];
    [self setGears5:nil];
    [self setToTopButton:nil];
    [self setMorePluses1:nil];
    [self setMorePluses2:nil];
    [self setMorePluses3:nil];
    [self setMorePluses4:nil];
    [self setMorePluses5:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (IBAction)showOvernightDeposit {
    self.scrollView.contentOffset = CGPointMake(0, self.lblOvernightDeposit.frame.origin.y);
}

- (IBAction)showStandardDeposit {
    self.scrollView.contentOffset = CGPointMake(0, self.lblStandardDeposit.frame.origin.y);
}

- (IBAction)showConstructorDeposit {
    self.scrollView.contentOffset = CGPointMake(0, self.lblConstructorDeposit.frame.origin.y);
}

- (IBAction)showPartnerDeposit {
    self.scrollView.contentOffset = CGPointMake(0, self.lblPartnerDeposit.frame.origin.y);
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
        case 4: 
            arrows = self.arrows5; 
            labels = self.labels5; 
            morePlus = morePluses5;
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

- (IBAction)bluePlusClick:(id)sender {
    if ([sender tag] == 1){
        [sender setTag:3];
        [[self.bluePlus layer] removeAllAnimations];
        self.bluePlus.transform = CGAffineTransformMakeScale(1, 1);
        [UIView animateWithDuration:1.0f
                         animations:^{
                             CGRect frame = imgRed.frame;
                             frame.origin.x += 540;
                             imgRed.frame = frame;
                             
                             frame = txtRed.frame;
                             frame.origin.x -= 458;
                             txtRed.frame = frame; 
                             
                         }completion:^(BOOL finished){
                             [UIView animateWithDuration:1.0f
                                              animations:^{
                                                  CGRect frame = imgViolet.frame;
                                                  frame.origin.x += 558;
                                                  imgViolet.frame = frame;
                                                  
                                                  frame = txtViolet.frame;
                                                  frame.origin.x -= 458;
                                                  txtViolet.frame = frame;                                              
                                              
                                              }completion:^(BOOL finished){
                                                  [UIView animateWithDuration:1.0f
                                                                   animations:^{
                                                                       CGRect frame = imgGreen.frame;
                                                                       frame.origin.x += 540;
                                                                       imgGreen.frame = frame;
                                                                       
                                                                       frame = txtGreen.frame;
                                                                       frame.origin.x -= 458;
                                                                       txtGreen.frame = frame;                                              
                                                                       
                                                                   }completion:nil];
                                              }];
                         }];
        
    }

}
@end
