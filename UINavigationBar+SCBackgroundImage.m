//
//  UINavigationBar+SCBackgroundImage.m
//  MegaTyumen
//
//  Created by Yazhenskikh Stanislaw on 28.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+SCBackgroundImage.h"
#import "SCAppUtils.h"

@implementation UINavigationBar (SCBackgroundImage)

- (void)scInsertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [self scInsertSubview:view atIndex:index];
    
    UIView *backgroundImageView = [self viewWithTag:kSCNavBarImageTag];
    if (backgroundImageView != nil)
    {
        [self scSendSubviewToBack:backgroundImageView];
    }
}

- (void)scSendSubviewToBack:(UIView *)view
{
    [self scSendSubviewToBack:view];
    
    UIView *backgroundImageView = [self viewWithTag:kSCNavBarImageTag];
    if (backgroundImageView != nil)
    {
        [self scSendSubviewToBack:backgroundImageView];
    }
}

//- (CGSize)sizeThatFits:(CGSize)size {
//    CGSize newSize = CGSizeMake(320, 53);
//    return newSize;
//}

@end