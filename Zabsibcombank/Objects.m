//
//  Objects.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 04.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Objects.h"

static NSArray *_all;

@implementation Objects
+ (NSArray *)all {
    if (!_all) {
        NSMutableDictionary *object = [[NSMutableDictionary alloc] init];
        [object setValue:@"Доп. офис №3 Червишевский" forKey:@"name"];
        [object setValue:@"ул. Червишевский тракт 64" forKey:@"address"];
        [object setValue:@"10:00 - 22:00" forKey:@"hours"];
        [object setValue:[NSNumber numberWithBool:YES] forKey:@"rub"];
        [object setValue:[NSNumber numberWithBool:YES] forKey:@"usd"];
        _all = [NSArray arrayWithObject:object];
    }
    return _all;
}
@end
