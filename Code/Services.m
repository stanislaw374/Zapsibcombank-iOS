//
//  Services.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Services.h"

static NSArray *_services;

@implementation Services

+ (id)all {
    if (!_services) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Services" ofType:@"plist"];
        _services = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"Services"];
    }
    return _services;
}

@end
