//
//  MainScreen.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;

@interface MainScreen : UIViewController
@property (strong, nonatomic) IBOutlet News *news;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblCurrencyDate;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnAddresses;

- (IBAction)onServiceButtonClick:(UIButton *)sender;
- (IBAction)showAddresses;

@end
