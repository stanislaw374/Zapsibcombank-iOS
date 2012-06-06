//
//  DistantServiceViewController.h
//  Zapsibcombank
//
//  Created by Stanislaw Lazienki on 09.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceViewController.h"

@interface DistantServiceViewController : ServiceViewController
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *speedImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *usabilityImage;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *accessImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *speedText;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtUsability_1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtUsability_2;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtUsability_3;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtAccess_1;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtAccess_3;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtAccess_2;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnPlus;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnFrame;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *txtFrame;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *hideView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses;

-(void)animatePlus;
-(void) animateFrameButton;
- (IBAction)animateLabels:(id)sender;
- (IBAction)animateFrame:(id)sender;

@end
