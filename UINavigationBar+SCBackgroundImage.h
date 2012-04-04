//
//  UINavigationBar+SCBackgroundImage.h
//  MegaTyumen
//
//  Created by Yazhenskikh Stanislaw on 28.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (SCBackgroundImage)

- (void)scInsertSubview:(UIView *)view atIndex:(NSInteger)index;
- (void)scSendSubviewToBack:(UIView *)view;

@end
