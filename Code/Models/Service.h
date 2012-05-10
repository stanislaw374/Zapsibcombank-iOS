//
//  Services.h
//  Zabsibcombank
//
//  Created by Yazhenskikh Stanislaw on 05.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject
@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *name;
@end

@interface Service : NSObject
@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *sections;

+ (id)services;

@end
