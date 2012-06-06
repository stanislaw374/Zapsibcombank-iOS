//
//  VipDepositViewController.h
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceViewController.h"

@interface VipDepositViewController : ServiceViewController<UIScrollViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *pluses;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows1;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels1;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *mech1;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows2;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels2;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *mech2;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows3;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels3;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *mech3;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *arrows4;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels4;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *mech4;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses1;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses2;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses3;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *morePluses4;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *toTopButton;
- (IBAction)backToTop:(id)sender;

-(void) hideArrowsAndLabels;
-(void) scrollTo: (float) height;
-(void) animateMechs;
- (IBAction)onPlusButtonClick:(UIButton *)sender;
@end
