//
//  CashManagementViewController.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 08.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepositsViewController : UIViewController
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

- (IBAction)bluePlusClick:(id)sender;

-(void)animateFirstArrows;
-(void)animateSecondArrows;
-(void)animateThirdArrows;
-(void)animateFoursArrows;

-(void)animateFirstGears;
-(void)animateSecondGears;
-(void)animateThirdGears;
-(void)animateFoursGears;
@end
