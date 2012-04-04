/*
 * PointAnnotation.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011 YANDEX
 * 
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "PointAnnotation.h"

@implementation PointAnnotation

+ (id)pointAnnotation {
    return [[[self class] alloc] init];
}

@synthesize title;
@synthesize subtitle;
@synthesize coordinate;

@end
