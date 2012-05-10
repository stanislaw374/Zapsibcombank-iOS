//
//  SCAppUtils.m
//  MegaTyumen
//
//  Created by Yazhenskikh Stanislaw on 28.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SCAppUtils.h"
//#import "UIImage+Thumbnail.h"

@implementation SCAppUtils

+ (void)customizeNavigationController:(UINavigationController *)navController
{
    UINavigationBar *navBar = [navController navigationBar];
    [navBar setTintColor:kSCNavBarColor];

    UIImage *image = [UIImage imageNamed:@"inside_topbar_44.png"];
    
    if ([navBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {              
        [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];            
    }
    else
    {
        UIImageView *imageView = (UIImageView *)[navBar viewWithTag:kSCNavBarImageTag];
        if (imageView == nil)
        {
            imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setTag:kSCNavBarImageTag];
            [navBar insertSubview:imageView atIndex:0];
        }
    }
}

@end
