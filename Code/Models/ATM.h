//
//  ATM.h
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 18.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "MapObject.h"

@interface ATM : MapObject
@property (nonatomic, strong) NSString *hours;
@property (nonatomic, strong) NSString *cash;
@property (nonatomic, strong) NSString *currency;
@end
