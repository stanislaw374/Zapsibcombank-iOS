//
//  DetailsScreen.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsScreen : UIViewController

@property (nonatomic, copy) NSString *service;
@property (nonatomic) int section;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *menu;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *allServicesView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView3;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *imagesView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnAllServices;

- (IBAction)onCancelButtonClick:(id)sender;
- (IBAction)onAllServicesButtonClick:(id)sender;
- (IBAction)onMainButtonClick:(id)sender;
- (IBAction)onCloseButtonClick:(id)sender;

- (IBAction)viewDragged:(id)sender;

@end
