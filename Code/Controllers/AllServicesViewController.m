//
//  AllServicesViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AllServicesViewController.h"
#import "Service.h"

@interface AllServicesViewController()
- (IBAction)close;
- (void)chooseService:(UIButton *)sender;
@end

@implementation AllServicesViewController
@synthesize delegate = _delegate;

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
    
    NSArray *services = [Service services];
    
    int sx = 30, sy = 30;
    int row = 0, column = 0;
    int dx = 40, dy = 40;
    
    for (int i = 0; i < services.count; i++) {
        Service *service = [services objectAtIndex:i];
        int buttonNumber = i % 10;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(dx, dy, 294, 78)];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"button_%d.png", buttonNumber + 1]] forState:UIControlStateNormal];
        [btn setTitle:service.name forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        btn.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [btn addTarget:self action:@selector(chooseService:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = service.ID;
        dx += btn.frame.size.width + sx;
        if (++column == 3) {
            row++;
            dy += btn.frame.size.height + sy;
            column = 0;
            dx = 40;
        }
        [self.view addSubview:btn];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)chooseService:(UIButton *)sender {
    int serviceIndex = [[Service services] indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        Service *s = (Service *)obj;
        if (s.ID == sender.tag) {
            *stop = YES;
            return YES;
        }
        else return NO;
    }];
    Service *serviceToShow = [[Service services] objectAtIndex:serviceIndex];
    if ([self.delegate respondsToSelector:@selector(allServicesViewControllerDidChooseService:)]) {
        [self.delegate allServicesViewControllerDidChooseService:serviceToShow];
    }
    
    [self close];
}

- (IBAction)close {
    if ([self.delegate respondsToSelector:@selector(allServicesViewControllerDidFinish)]) {
        [self.delegate allServicesViewControllerDidFinish];
    }
}

@end
