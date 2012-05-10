//
//  Services.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Service.h"

static NSArray *_services;

@implementation Section
@synthesize ID = _ID;
@synthesize name = _name;
@end

@implementation Service
@synthesize ID = _ID;
@synthesize name = _name;
@synthesize sections = _sections;

+ (id)services {
    if (!_services) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Services" ofType:@"plist"];
        NSArray *services = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"Services"];
        NSMutableArray *result = [NSMutableArray array];
        for (NSDictionary *service in services) {
            Service *s = [[Service alloc] init];
            s.ID = [[service objectForKey:@"id"] intValue];
            s.name = [service objectForKey:@"name"];
            NSMutableArray *resultSections = [NSMutableArray array];
            NSArray *sections = [service objectForKey:@"sections"];
            for (NSDictionary *section in sections) {
                Section *se = [[Section alloc] init];
                se.ID = [[section objectForKey:@"id"] intValue];
                se.name = [section objectForKey:@"name"];                
                [resultSections addObject:se];
            }
            s.sections = resultSections;
            [result addObject:s];
        }
        _services = result;
    }
    return _services;
}

@end
