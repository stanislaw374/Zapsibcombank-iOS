//
//  DetailsScreen.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailsScreen.h"
#import "MainScreen.h"

@interface DetailsScreen()
@property (nonatomic) int currentPage;
@property (nonatomic) int pagesCount;
@property (nonatomic) CGPoint touchLocation;
@property (nonatomic) BOOL isMoving;
- (void)onSectionButtonClick:(UIButton *)button;
- (void)initMenu;
- (void)initMainMenu;
- (void)onServiceButtonClick:(UIButton *)button;
@end

@implementation DetailsScreen
@synthesize lblTitle;
@synthesize menu;
@synthesize arrow;
@synthesize allServicesView;
@synthesize arrow2;
@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize imagesView;
@synthesize btnAllServices;
@synthesize service = _service;
@synthesize section = _section;
@synthesize currentPage = _currentPage;
@synthesize pagesCount = _pagesCount;
@synthesize touchLocation = _touchLocation;
@synthesize isMoving = _isMoving;

- (void)setService:(NSString *)service {
    _service = service;
    self.lblTitle.text = _service;
    
    [self initMenu];
    [self initMainMenu];
}

- (void)setSection:(int)section {
    _section = section;
}

- (void)setCurrentPage:(int)currentPage {
    _currentPage = currentPage;    
}

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

    self.section = 0;
    self.pagesCount = 3;
    self.currentPage = 0;
    
    self.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"services_%d_pages_%d", 0, _currentPage - 1]];
    self.imageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"services_%d_pages_%d", 0, _currentPage]];
    self.imageView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"services_%d_pages_%d", 0, _currentPage + 1]];  
}

- (void)viewDidUnload
{
    [self setMenu:nil];
    [self setLblTitle:nil];
    [self setArrow:nil];
    [self setAllServicesView:nil];
    [self setArrow2:nil];
    [self setImageView1:nil];
    [self setImageView2:nil];
    [self setImageView3:nil];
    [self setImagesView:nil];
    [self setBtnAllServices:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (IBAction)onCancelButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onAllServicesButtonClick:(id)sender {
    [self.btnAllServices setSelected:YES];
    //self.arrow2.center = CGPointMake(self.btnAllServices.center.x, self.arrow2.center.y);
    
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = self.allServicesView.frame;
        frame.origin.y = 51;
        self.allServicesView.frame = frame;
    } completion:^(BOOL finished) {
        self.arrow2.hidden = NO;
    }];
}

- (IBAction)onMainButtonClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onCloseButtonClick:(id)sender {
    [self.btnAllServices setSelected:NO];
    self.arrow2.hidden = YES;
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = self.allServicesView.frame;
        frame.origin.y = -self.allServicesView.frame.size.height;
        self.allServicesView.frame = frame;
    }];
}

- (void)onServiceButtonClick:(UIButton *)button {
    [self onCloseButtonClick:nil];
    self.service = [button titleForState:UIControlStateNormal];
}

- (void)initMenu {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Services" ofType:@"plist"];
    NSDictionary *services = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *sections = [services objectForKey:self.service]; 
    const int fontHeight = 14;
    int dx = 10;        
    int i = 0;
    for (UIView *subview in self.menu.subviews) {
        [subview removeFromSuperview];
    }
    for (NSString *section in sections) {
        CGSize btnSize = [section sizeWithFont:[UIFont systemFontOfSize:fontHeight] constrainedToSize:CGSizeMake(9999, 44)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(dx, fontHeight, btnSize.width, btnSize.height)];
        btn.tag = i++;
        btn.titleLabel.font = [UIFont systemFontOfSize:fontHeight];
        [btn setTitle:section forState:UIControlStateNormal];
        dx += btn.frame.size.width + 8;
        [btn addTarget:self action:@selector(onSectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //btn.showsTouchWhenHighlighted = YES;
        [self.menu addSubview:btn];
    }
    self.menu.contentSize = CGSizeMake(dx, self.menu.frame.size.height);
}

- (void)initMainMenu {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Services" ofType:@"plist"];
    NSDictionary *services = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *keys = [services allKeys];
    
    int sx = 30, sy = 30;
    int row = 0, column = 0;
    int dx = 40, dy = 40;
    
    for (int i = 0; i < keys.count; i++) {
        int buttonNumber = i % 10;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(dx, dy, 294, 78)];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button_%d.png", buttonNumber + 1]] forState:UIControlStateNormal];
        NSString *key = [keys objectAtIndex:i];
        [btn setTitle:key forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn addTarget:self action:@selector(onServiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        dx += btn.frame.size.width + sx;
        if (++column == 3) {
            row++;
            dy += btn.frame.size.height + sy;
            column = 0;
            dx = 40;
        }
        [self.allServicesView addSubview:btn];
    }
}

- (void)onSectionButtonClick:(UIButton *)button {
    self.arrow.center = CGPointMake(button.center.x, self.arrow.center.y);
    self.section = button.tag;
    self.arrow.hidden = NO;
}

#pragma mark - UIResponderDelegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [super touchesBegan:touches withEvent:event];
    
    //if (self.isMoving) return;
    //else self.isMoving = YES;
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        self.touchLocation = [touch locationInView:self.view];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    if ([touch.view isKindOfClass:[UIImageView class]]) {
        CGPoint touchLocation = [touch locationInView:self.view];
        
        int dx = touchLocation.x - self.touchLocation.x;
        
        if (dx < 0 && self.currentPage == self.pagesCount - 1) { return; }
        if (dx > 0 && self.currentPage == 0) { return; }
        
        CGSize winSize = CGSizeMake(1024, 768);
        
        if (touch.view.center.x < winSize.width / 2) {
            [self.imagesView bringSubviewToFront:self.imageView3];
        }
        else {
            [self.imagesView bringSubviewToFront:self.imageView1];
        }
        [self.imagesView bringSubviewToFront:self.imageView2];  
    
        CGRect frame = self.imageView2.frame;
        frame.origin.x += dx;
        self.imageView2.frame = frame;            
        
        self.touchLocation = touchLocation;                
    }    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    //self.isMoving = NO;
    
    //UIImageView *currentView = (UIImageView *)[[touches anyObject] view];
    //UIImageView *hiddenView = [currentView isEqual:self.imageView1] ? self.imageView2 : self.imageView1;
    CGSize winSize = CGSizeMake(1024, 768);   
    
    UITouch *touch = [touches anyObject];
    
    int dx = touch.view.center.x - (winSize.width / 2);
    if (dx != 0) {
        //self.isMoving = YES;
        [UIView animateWithDuration:0.3f animations:^{
            if (dx < 0) {
                //CGRect frame = self.imageView3.frame;
                //frame.origin.x = 0;
                //self.imageView3.frame = frame;
                
                CGRect frame = touch.view.frame;
                frame.origin.x = - frame.size.width;
                touch.view.frame = frame;
                
                //self.currentPage--;
            }
            else {
                //CGRect frame = self.imageView1.frame;
                //frame.origin.x = 0;
                //self.imageView1.frame = frame;                
                
                CGRect frame = touch.view.frame;
                frame.origin.x = winSize.width;
                touch.view.frame = frame;
                
                //self.currentPage++;
            }
        } completion:^(BOOL finished) {
            if (dx < 0) self.currentPage++;
            else self.currentPage--;
            
            self.imageView2.image = [UIImage imageNamed:[NSString stringWithFormat:@"services_%d_pages_%d", 0, self.currentPage]];            
            self.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"services_%d_pages_%d", 0, self.currentPage - 1]];
            self.imageView3.image = [UIImage imageNamed:[NSString stringWithFormat:@"services_%d_pages_%d", 0, self.currentPage + 1]];
            
            CGRect frame = self.imageView2.frame;
            frame.origin.x = 0;
            self.imageView2.frame = frame;
            
            [self.imagesView bringSubviewToFront:self.imageView2];
            
            self.isMoving = NO;
        }];        
    }
}

@end
