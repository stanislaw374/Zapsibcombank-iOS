//
//  ATM.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 18.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ATM.h"
#import "Config.h"
#import "SBJson.h"

@implementation ATM
//@synthesize ID = _ID;
@synthesize name = _name;
@synthesize address = _address;
@synthesize hours = _hours;
@synthesize currency = _currency;
//@synthesize coordinate = _coordinate;
@synthesize cash = _cash;
@synthesize city = _city;

- (void)setName:(NSString *)name {
    _name = name;
    if (!_name.length) {
        _name = @"Банкомат";
    }
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
