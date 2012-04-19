//
//  City.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 18.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "City.h"
#import "Config.h"
#import "SBJsonParser.h"
#import "ATM.h"
#import "Office.h"
static NSArray *_all;

@implementation City
@synthesize ID = _ID;
@synthesize name = _name;
@synthesize atms = _atms;
@synthesize offices = _offices;
@synthesize delegate = _delegate;

//- (NSArray *)atms {
//    if (!_atms) {
//        _atms = [NSArray array];
//    }
//    return _atms;
//}

+ (void)getWithDelegate:(id<CityDelegate>)delegate {
    if (!_all) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:@"/api/cities/" relativeToURL:API_URL];
            NSError *error;
            NSStringEncoding encoding;
            NSString *responseString = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
            
            NSLog(@"%@ : %@", NSStringFromSelector(_cmd), responseString);
            
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [delegate citiesDidFailWithError:error];
                });
            }
            else {
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSMutableArray *result = [NSMutableArray array];
                NSArray *cities = [parser objectWithString:responseString];
                for (NSDictionary *city in cities) {
                    City *c = [[City alloc] init];
                    c.ID = [[city objectForKey:@"id"] intValue];
                    c.name = [city objectForKey:@"name"];
                    [result addObject:c];
                }
                _all = result;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [delegate citiesDidLoad:_all];
                });
            }
        });
    }
    else {
        [delegate citiesDidLoad:_all];
    }
}

- (void)getATMs {
    if (!_atms) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"/api/atms/%d", self.ID] relativeToURL:API_URL];
            NSError *error;
            NSStringEncoding encoding;
            NSString *responseString = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
            
            NSLog(@"%@ : %@", NSStringFromSelector(_cmd), responseString);
            
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate cityObjectsDidFailWithError:error];
                });
            }
            else {
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSArray *atms = [parser objectWithString:responseString];
                NSMutableArray *result = [NSMutableArray array];
                for (NSDictionary *atm in atms) {
                    ATM *a = [[ATM alloc] init];
                    a.city = self;
                    a.ID = [[atm objectForKey:@"id"] intValue];
                    a.name = [atm objectForKey:@"place"];
                    a.address = [atm objectForKey:@"adres"];
                    a.cash = [atm objectForKey:@"cash"];
                    a.currency = [atm objectForKey:@"currency"];
                    a.hours = [atm objectForKey:@"hours"];
                    
                    [result addObject:a];
                }
                self.atms = result;
                dispatch_async(dispatch_get_main_queue(), ^{
                    //_isATMsLoaded = YES;
                    [self.delegate cityObjectsDidLoad];
                });
            }
        });
    }
    else {
        [self.delegate cityObjectsDidLoad];
    }
}

- (void)getOffices {
    if (!_offices) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"/api/offices/%d", self.ID] relativeToURL:API_URL];
            NSError *error;
            NSStringEncoding encoding;
            NSString *responseString = [NSString stringWithContentsOfURL:url usedEncoding:&encoding error:&error];
            
            NSLog(@"%@ : %@", NSStringFromSelector(_cmd), responseString);
            
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate cityObjectsDidFailWithError:error];
                });
            }
            else {
                SBJsonParser *parser = [[SBJsonParser alloc] init];
                NSArray *offices = [parser objectWithString:responseString];
                NSMutableArray *result = [NSMutableArray array];
                for (NSDictionary *office in offices) {
                    Office *o = [[Office alloc] init];
                    o.city = self;
                    o.ID = [[office objectForKey:@"id"] intValue];
                    o.name = [office objectForKey:@"name"];
                    o.address = [office objectForKey:@"adres"];
                    
                    [result addObject:o];
                }
                self.offices = result;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate cityObjectsDidLoad];
                });
            }
        });
    }
    else {
        [self.delegate cityObjectsDidLoad];
    }
}

@end
