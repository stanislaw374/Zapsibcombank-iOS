//
//  MapObject.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 19.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "City.h"

@interface MapObject : NSObject
@property (nonatomic, unsafe_unretained) City *city;
@property (nonatomic) int ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end
