//
//  MainScreen.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainScreen.h"
#import "News.h"
#import "DetailsScreen.h"
#import "RaschetScreen.h"
#import "MapScreen.h"
#import "Service.h"
#import "AboutView.h"
#import <QuartzCore/QuartzCore.h>
#import "Information.h"
#import "ServicesViewController.h"

@interface MainScreen()
- (void)initMenu;
- (void)initUI;
- (void)showService:(UIButton *)sender;
@end

@implementation MainScreen
@synthesize news = _news;
@synthesize currencies = _currencies;
@synthesize lblCurrencyDate = _lblCurrencyDate;
@synthesize btnAddresses = _btnAddresses;
@synthesize aboutBankView = _aboutBankView;
@synthesize aboutBankContentView = _aboutBankContentView;
@synthesize mainView = _mainView;
@synthesize btnAboutBank = _btnAboutBank;
@synthesize btnPresidentsStatement = _btnPresidentsStatement;
@synthesize btnRatingsAndLicenses = _btnRatingsAndLicenses;
@synthesize imgPhoto = _imgPhoto;

- (News *)news {
    if (!_news) {
        _news = [[News alloc] init];
    }
    return _news;
}

- (IBAction)showAddresses {
    MapScreen *mapScreen = [[MapScreen alloc] init];
    [self.navigationController pushViewController:mapScreen animated:YES];
}

- (IBAction)showInetbank {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://inetbank.zapsibkombank.ru/"]];
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
    [self initUI];
}

- (void)viewDidUnload
{
    [self setNews:nil];
    [self setLblCurrencyDate:nil];
    [self setBtnAddresses:nil];
    [self setAboutBankView:nil];
    [self setAboutBankContentView:nil];
    [self setMainView:nil];
    [self setBtnAboutBank:nil];
    [self setBtnPresidentsStatement:nil];
    [self setBtnRatingsAndLicenses:nil];
    [self setImgPhoto:nil];
    [self setCurrencies:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (void)initMenu {
    NSArray *services = [Service services];

    CGPoint btnOrigin = CGPointMake(0, 40);
    CGSize btnSize = CGSizeMake(294, 78);
    const int sx = 20, sy = 20;
    int dx = 0, dy = 0, i = 0, row = 0, column = 0;
    for (Service *service in services) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnOrigin.x + dx, btnOrigin.y + dy, btnSize.width, btnSize.height)];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button_%d.png", (i++ % 10) + 1]] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn setTitle:service.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;        
        btn.tag = service.ID;
        [btn addTarget:self action:@selector(showService:) forControlEvents:UIControlEventTouchUpInside];
        
        dx += btn.frame.size.width + sx;
        if (++column == 2) {
            row++;
            column = 0;
            dx = 0;
            dy += btn.frame.size.height + sy;
        }
        
        [self.mainView addSubview:btn];
    }
}

- (void)initUI { 
    [self initMenu];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM.yyyy";
    self.lblCurrencyDate.text = [df stringFromDate:[NSDate date]];
    self.aboutBankView.layer.cornerRadius = 5;
}

- (void)showService:(UIButton *)sender {
    int indexOfService = [[Service services] indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        Service *s = (Service *)obj;
        if (s.ID == sender.tag) {
            *stop = YES;
            return YES;
        }
        else return NO;
    }];
    Service *serviceToShow = [[Service services] objectAtIndex:indexOfService];
    ServicesViewController *view = [[ServicesViewController alloc] init];
    view.service = serviceToShow;
    [self.navigationController pushViewController:view animated:YES];
    return;
    
    
    
    // определение экрана перехода 
    UIViewController *screen;
    if (sender.tag == 0) {
            screen = [[RaschetScreen alloc] init];
    } else {
        screen = [[DetailsScreen alloc] init];
    }
    
    [self.navigationController pushViewController:screen animated:YES];
    
    int serviceIndex = [[Service services] indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        Service *service = (Service *)obj;
        if (service.ID == sender.tag) {
            *stop = YES;
            return YES;
        }
        return NO;
    }]; 
    
    Service *service = [[Service services] objectAtIndex:serviceIndex];
    if (sender.tag == 0){
        ((RaschetScreen *)screen).service = service;
    } else {
        ((DetailsScreen *)screen).service = service;
    }
}

- (IBAction)showAbout {
    AboutView *aboutView = [[AboutView alloc] init];
    aboutView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:aboutView animated:YES];
}

- (IBAction)showAboutBank:(id)sender {
    self.btnPresidentsStatement.selected = NO;
    self.btnRatingsAndLicenses.selected = NO;
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    self.imgPhoto.image = [UIImage imageNamed:@"about_bank_photo.png"];
    [self.aboutBankContentView loadHTMLString:[Information aboutBank] baseURL:nil];
    self.aboutBankView.hidden = !btn.selected;
}

- (IBAction)showPresidentsStatement:(id)sender {
    self.btnAboutBank.selected = NO;
    self.btnRatingsAndLicenses.selected = NO;
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    self.imgPhoto.image = [UIImage imageNamed:@"president_photo.png"];
    [self.aboutBankContentView loadHTMLString:[Information presidentsStatement] baseURL:nil];
    self.aboutBankView.hidden = !btn.selected;
}

- (IBAction)showRatingsAndLicenses:(id)sender {
    self.btnAboutBank.selected = NO;
    self.btnPresidentsStatement.selected = NO;
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    self.imgPhoto.image = [UIImage imageNamed:@"about_bank_photo.png"];
    [self.aboutBankContentView loadHTMLString:[Information ratingsAndLicenses] baseURL:nil];
    self.aboutBankView.hidden = !btn.selected;
}

- (IBAction)goMain {
    self.aboutBankView.hidden = YES;
    self.btnAboutBank.selected = NO;
    self.btnPresidentsStatement.selected = NO;
    self.btnRatingsAndLicenses.selected = NO;
}

@end
