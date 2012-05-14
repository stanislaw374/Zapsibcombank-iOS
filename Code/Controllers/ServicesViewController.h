//
//  ServicesViewController.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 09.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Service;
@class Section;

@interface ServicesViewController : UIViewController
@property (nonatomic, strong) Service *service;
@property (nonatomic, strong) Section *section;
@end
