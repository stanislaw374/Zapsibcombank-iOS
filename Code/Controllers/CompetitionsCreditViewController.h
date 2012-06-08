//
//  CompetitionsCreditViewController.h
//  Zapsibcombank
//
//  Created by Кирилл Кунст on 17.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceViewController.h"
@interface CompetitionsCreditViewController : ServiceViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *bigArrows;
- (IBAction)btnStep1:(id)sender;
- (IBAction)btnStep2:(id)sender;
- (IBAction)btnStep3:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *toTopButton;

- (IBAction)backToTop:(id)sender;
-(void) scrollTo: (float) height;
@end
