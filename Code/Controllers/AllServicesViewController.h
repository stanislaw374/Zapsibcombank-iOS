//
//  AllServicesViewController.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 10.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Service;

@protocol AllServicesViewControllerDelegate <NSObject>
@optional
- (void)allServicesViewControllerDidFinish;
- (void)allServicesViewControllerDidChooseService:(Service *)service;
@end

@interface AllServicesViewController : UIViewController
@property (nonatomic, unsafe_unretained) id<AllServicesViewControllerDelegate> delegate;
@end
