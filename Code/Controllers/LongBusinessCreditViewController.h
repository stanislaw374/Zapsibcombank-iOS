//
//  LongBusinessCreditViewController.h
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 17.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LongBusinessCreditViewController : UIViewController<UIScrollViewDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *angleArrow;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *persons;
- (IBAction)btnAutoClick:(id)sender;
- (IBAction)btnDeviceClick:(id)sender;
- (IBAction)btnBusinessClick:(id)sender;
- (IBAction)btnBuildClick:(id)sender;
- (IBAction)btnReconstructionClick:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *toTopButton;
- (IBAction)backToTop:(id)sender;

-(void) animateAngleArrow;

-(void) scrollTo: (float) height;


@end
