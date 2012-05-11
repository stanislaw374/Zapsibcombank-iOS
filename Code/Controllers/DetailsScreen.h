//
//  DetailsScreen.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Service, Section;

@interface DetailsScreen : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) Service *service;
@property (nonatomic, strong) Section *section;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *menu;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *allServicesView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *arrow2;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnAllServices;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *page1;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *page2;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *page3;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *sectionsScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *pages;

- (IBAction)onSectionButtonClick:(UIButton *)button;
- (IBAction)onCancelButtonClick:(id)sender;
- (IBAction)onAllServicesButtonClick:(id)sender;
- (IBAction)onMainButtonClick:(id)sender;
- (IBAction)onCloseButtonClick:(id)sender;
- (IBAction)viewDragged:(UIPanGestureRecognizer *)gesture;

@end
