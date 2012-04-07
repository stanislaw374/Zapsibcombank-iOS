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
#import "MapScreen.h"
#import "Services.h"

@interface MainScreen()
- (void)initMenu;
- (void)showService:(UIButton *)sender;
@end

@implementation MainScreen
@synthesize news = _news;
@synthesize lblCurrencyDate = _lblCurrencyDate;
@synthesize btnAddresses = _btnAddresses;

- (News *)news {
    if (!_news) {
        _news = [[News alloc] init];
    }
    return _news;
}

//- (IBAction)onServiceButtonClick:(UIButton *)sender {
//    DetailsScreen *detailsScreen = [[DetailsScreen alloc] init];
//    [self.navigationController pushViewController:detailsScreen animated:YES];
//    detailsScreen.service = sender.titleLabel.text;
//}

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
    [self.news update];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM.yyyy";
    self.lblCurrencyDate.text = [df stringFromDate:[NSDate date]];
    
    //CGSize textSize = [[self.btnAddresses titleForState:UIControlStateNormal] sizeWithFont:[UIFont boldSystemFontOfSize:15]];
    
    [self initMenu];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidUnload
{
    [self setNews:nil];
    [self setLblCurrencyDate:nil];
    [self setBtnAddresses:nil];
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
    NSArray *services = [Services all];

    CGPoint btnOrigin = CGPointMake(40, 196);
    CGSize btnSize = CGSizeMake(294, 78);
    const int sx = 20, sy = 20;
    int dx = 0, dy = 0, i = 0, row = 0, column = 0;
    for (NSDictionary *service in services) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnOrigin.x + dx, btnOrigin.y + dy, btnSize.width, btnSize.height)];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button_%d.png", (i++ % 10) + 1]] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn setTitle:[service objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;        
        btn.tag = [[service objectForKey:@"id"] intValue];
        [btn addTarget:self action:@selector(showService:) forControlEvents:UIControlEventTouchUpInside];
        
        dx += btn.frame.size.width + sx;
        if (++column == 2) {
            row++;
            column = 0;
            dx = 0;
            dy += btn.frame.size.height + sy;
        }
        
        [self.view addSubview:btn];
    }
}

- (void)showService:(UIButton *)sender {
    DetailsScreen *detailsScreen = [[DetailsScreen alloc] init];
    [self.navigationController pushViewController:detailsScreen animated:YES];
    
    int serviceIndex = [[Services all] indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary *service = (NSDictionary *)obj;
        if ([[service objectForKey:@"id"] intValue] == sender.tag) {
            return YES;
        }
        return NO;
    }]; 
    NSDictionary *service = [[Services all] objectAtIndex:serviceIndex];
    detailsScreen.service = service;
}

@end
