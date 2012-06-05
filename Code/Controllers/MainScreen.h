//
//  MainScreen.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "New.h"
@class News;
@class Currencies;

@interface MainScreen : UIViewController <UITableViewDataSource, UITableViewDelegate, NewDelegate>
@property (strong, nonatomic) IBOutlet News *news;
@property (strong, nonatomic) IBOutlet Currencies *currencies;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblCurrencyDate;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnAddresses;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *aboutBankView;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *aboutBankContentView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnAboutBank;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnPresidentsStatement;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnRatingsAndLicenses;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *aboutWSCB;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *aboutWSCBscrollView;

- (IBAction)showAddresses;
- (IBAction)showInetbank;
- (IBAction)showAbout;
- (IBAction)showAboutBank:(id)sender;
- (IBAction)goMain;
- (IBAction)showPresidentsStatement:(id)sender;
- (IBAction)showRatingsAndLicenses:(id)sender;

@end
