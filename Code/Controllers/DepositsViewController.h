//
//  CashManagementViewController.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 08.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceViewController.h"

@interface DepositsViewController : ServiceViewController<UIScrollViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgRed;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgViolet;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgGreen;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *txtRed;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *txtViolet;
@property (unsafe_unretained, nonatomic) IBOutlet UITextView *txtGreen;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *bluePlus;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *blueGear1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *blueGear2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *blueGear3;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows5;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *gears5;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *toTopButton;
- (IBAction)backToTop:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels5;
- (IBAction)bluePlusClick:(id)sender;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses3;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses4;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses5;
-(void)animateFirstArrows;
-(void)animateSecondArrows;
-(void)animateThirdArrows;
-(void)animateFoursArrows;

-(void)animateFirstGears;
-(void)animateSecondGears;
-(void)animateThirdGears;
-(void)animateFoursGears;
-(void)scrollTo:(float)height;
@end
