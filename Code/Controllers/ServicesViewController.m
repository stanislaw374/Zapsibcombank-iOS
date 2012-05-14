//
//  ServicesViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 09.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Service.h"
#import "ServicesViewController.h"
#import "AllServicesViewController.h"

#import "CashServicesViewController.h"
#import "CorporateCardsViewController.h"
#import "PackageOfServicesViewController.h"
#import "SalaryProjectViewController.h"
#import "DistantServiceViewController.h"
#import "EncashmentViewController.h"

#import "DepositsViewController.h"
#import "BillsViewController.h"
#import "BrokerServiceViewController.h"

@interface ServicesViewController() <AllServicesViewControllerDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIView *contentView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *menuScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *serviceLabel;
@property (nonatomic, strong) UIViewController *currentSectionViewController;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *allServicesArrow;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *currentSectionArrow;
@property (nonatomic, strong) AllServicesViewController *allServicesViewController;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *menuView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *allServicesButton;

- (IBAction)close;
- (IBAction)showAllServices;
- (void)showSectionWithID:(int)ID;
- (IBAction)showSection:(UIButton *)sender;
- (void)initUIForCurrentService;
@end

@implementation ServicesViewController
@synthesize contentView;
@synthesize menuScrollView = _menuScrollView;
@synthesize serviceLabel = _serviceLabel;
@synthesize service = _service;
@synthesize currentSectionViewController = _currentSectionViewController;
@synthesize allServicesArrow = _allServicesArrow;
@synthesize currentSectionArrow = _currentSectionArrow;
@synthesize allServicesViewController = _allServicesViewController;
@synthesize menuView = _menuView;
@synthesize allServicesButton = _allServicesButton;

- (AllServicesViewController *) allServicesViewController {
    if (!_allServicesViewController) {
        _allServicesViewController = [[AllServicesViewController alloc] init];
        _allServicesViewController.delegate = self;
    }
    return _allServicesViewController;
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initUIForCurrentService];
    
    if (self.menuScrollView.subviews.count) {
        [self showSection:[self.menuScrollView.subviews objectAtIndex:0]];
    }
}

- (void)viewDidUnload
{
    [self setContentView:nil];
    [self setMenuScrollView:nil];
    [self setServiceLabel:nil];
    [self setAllServicesArrow:nil];
    [self setCurrentSectionArrow:nil];
    [self setMenuView:nil];
    [self setAllServicesButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Helpers
- (void)setService:(Service *)service {
    _service = service;
    
    [self initUIForCurrentService];
    
    if (self.menuScrollView.subviews.count) {
        [self showSection:[self.menuScrollView.subviews objectAtIndex:0]];
    }
}

- (void)initUIForCurrentService {
    self.serviceLabel.text = self.service.name;
    [self.currentSectionViewController.view removeFromSuperview];
    
    const int fontHeight = 14;
    int dx = 10;        
    const int sx = 20;
    
    for (UIView *subview in self.menuScrollView.subviews) {
        [subview removeFromSuperview];
    }
    
    NSArray *sections = self.service.sections;
    for (Section *section in sections) {
        CGSize btnSize = [section.name sizeWithFont:[UIFont systemFontOfSize:fontHeight] constrainedToSize:CGSizeMake(9999, 44)];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(dx, fontHeight, btnSize.width, btnSize.height)];
        btn.tag = section.ID;
        btn.titleLabel.font = [UIFont systemFontOfSize:fontHeight];
        [btn setTitle:section.name forState:UIControlStateNormal];
        dx += btn.frame.size.width + sx;
        [btn addTarget:self action:@selector(showSection:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithRed:1 green:192/255.0 blue:0 alpha:1] forState:UIControlStateSelected];
        btn.showsTouchWhenHighlighted = YES;
        [self.menuScrollView addSubview:btn];
    }
    self.menuScrollView.contentSize = CGSizeMake(dx, self.menuScrollView.frame.size.height);
}

- (IBAction)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)showAllServices {
    if (self.allServicesButton.selected) return;
    
    self.allServicesViewController.view.frame = CGRectMake(0, -717, self.allServicesViewController.view.frame.size.width, self.allServicesViewController.view.frame.size.height);
    [self.view insertSubview:self.allServicesViewController.view belowSubview:self.menuView];
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = self.allServicesViewController.view.frame;
        frame.origin.y = 51;
        self.allServicesViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        self.allServicesButton.selected = YES;
        self.allServicesArrow.hidden = NO;
    }];
}

- (void)showSectionWithID:(int)ID {  
    if (ID >= self.service.sections.count) return;
    
    [self.currentSectionViewController.view removeFromSuperview];
    
    switch (self.service.ID) {
        case 0:
            switch (ID) {
                case 0:
                    self.currentSectionViewController = [[CashServicesViewController alloc] init];
                    break;
                case 1:
                    self.currentSectionViewController = [[PackageOfServicesViewController alloc] init];
                    break;
                case 2:
                    self.currentSectionViewController = [[CorporateCardsViewController alloc] init];
                    break;
                case 3:
                    self.currentSectionViewController = [[SalaryProjectViewController alloc] init];
                    break;
                case 4:
                    self.currentSectionViewController = [[DistantServiceViewController alloc] init];
                    break;
                case 5:
                    self.currentSectionViewController = [[EncashmentViewController alloc] init];
                    break;
            }
            break;
            
        case 2:
            switch (ID) {
                case 0:
                    self.currentSectionViewController = [[DepositsViewController alloc] init];
                    break;
                case 1:
                    self.currentSectionViewController = [[BillsViewController alloc] init];
                    break;
                case 2:
                    self.currentSectionViewController = [[BrokerServiceViewController alloc] init];
            }
            break;
    }
    
    self.currentSectionViewController.view.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);    
    [self.contentView addSubview:self.currentSectionViewController.view];
}
     
- (IBAction)showSection:(UIButton *)sender { 
    for (UIButton *btn in self.menuScrollView.subviews) {
        btn.selected = NO;
    }
    sender.selected = YES;
    self.currentSectionArrow.center = CGPointMake(sender.center.x - self.menuScrollView.contentOffset.x, self.currentSectionArrow.center.y); 
    
    [self showSectionWithID:sender.tag];
}

#pragma mark - AllServicesViewControllerDelegate
- (void)allServicesViewControllerDidFinish {    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = self.allServicesViewController.view.frame;
        frame.origin.y = -700;
        self.allServicesViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        self.allServicesButton.selected = NO;
        self.allServicesArrow.hidden = YES;
        [self.allServicesViewController.view removeFromSuperview];
    }];    
}

- (void)allServicesViewControllerDidChooseService:(Service *)service {
    self.service = service;
}

@end
