//
//  main.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 02.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SCClassUtils.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [SCClassUtils swizzleSelector:@selector(insertSubview:atIndex:)
                              ofClass:[UINavigationBar class]
                         withSelector:@selector(scInsertSubview:atIndex:)];
        [SCClassUtils swizzleSelector:@selector(sendSubviewToBack:)
                              ofClass:[UINavigationBar class]
                         withSelector:@selector(scSendSubviewToBack:)];               
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
