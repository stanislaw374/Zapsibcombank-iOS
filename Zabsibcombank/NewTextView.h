//
//  NewTextView.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 13.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTextView : UIViewController
@property (strong, nonatomic) NSString *text;
@property (unsafe_unretained, nonatomic) IBOutlet UIWebView *textView;
@end
