//
//  LoadingScreen.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCProgress;

@interface LoadingScreen : UIViewController

@property (unsafe_unretained, nonatomic) IBOutlet OCProgress *progressView;

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *progressBar;

@end
