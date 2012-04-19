//
//  Office.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 19.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Office.h"
#import "SBJson.h"
#import "Config.h"

@implementation Office
@synthesize name = _name;
@synthesize address = _address;

- (void)setName:(NSString *)name {
    _name = name;
    if (!_name.length) {
        _name = @"Офис";
    }
    _name = [_name stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
}

- (void)setAddress:(NSString *)address {
    _address = address;
    
    NSString *requestString = [[NSString stringWithFormat:@"http://geocode-maps.yandex.ru/1.x/?key=%@&format=json&geocode=%@", YMAPS_KEY, [NSString stringWithFormat:@"%@, %@", self.city.name, self.address]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:requestString];    
    
    NSError *error;
    NSStringEncoding encoding;
    NSString *responseString = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
    //NSLog(@"%@, response: %@", NSStringFromSelector(_cmd), responseString);
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *responseDict = [parser objectWithString:responseString];
    NSDictionary *response = [responseDict objectForKey:@"response"];
    
    NSArray *featureMembers = [[response objectForKey:@"GeoObjectCollection"] objectForKey:@"featureMember"];
    if (featureMembers.count) {        
        NSArray *coordinates = [[[[[[[response objectForKey:@"GeoObjectCollection"] objectForKey:@"featureMember"] objectAtIndex:0] objectForKey:@"GeoObject"] objectForKey:@"Point"] objectForKey:@"pos"] componentsSeparatedByString:@" "];
        self.coordinate = CLLocationCoordinate2DMake([[coordinates objectAtIndex:1] doubleValue], [[coordinates objectAtIndex:0] doubleValue]);
    }
}

@end
