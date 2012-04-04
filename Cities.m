//
//  Cities.m
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 03.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Cities.h"

static NSArray *_all;

@interface Cities()
@property (nonatomic, strong) NSArray *cities;
@end

@implementation Cities
@synthesize cities = _cities;

+ (NSArray *)all {
    if (!_all) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Cities" ofType:@"plist"];
        NSDictionary *citiesDict = [NSDictionary dictionaryWithContentsOfFile:path];
        NSArray *citiesArray = [citiesDict objectForKey:@"Cities"];
        for (NSDictionary *city in citiesArray) {
            [result addObject:city];
        }
        _all = result;
    }
    return _all;
}

@end
