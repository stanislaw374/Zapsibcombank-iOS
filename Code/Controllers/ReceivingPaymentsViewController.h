//
//  ReceivingPaymentsViewController.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceViewController.h"

@interface ReceivingPaymentsViewController : ServiceViewController

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *persons;

@end
