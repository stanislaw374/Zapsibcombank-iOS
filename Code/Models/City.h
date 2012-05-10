//
//  City.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 18.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CityDelegate <NSObject>
@optional
- (void)citiesDidLoad:(NSArray *)cities;
- (void)citiesDidFailWithError:(NSError *)error;
- (void)cityObjectsDidLoad;
- (void)cityObjectsDidFailWithError:(NSError *)error;
@end

@interface City : NSObject 
@property (nonatomic, unsafe_unretained) id <CityDelegate> delegate;

@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *atms;
@property (nonatomic, strong) NSArray *offices;

+ (void)getWithDelegate:(id <CityDelegate>)delegate;
- (void)getATMs;
- (void)getOffices;
@end
