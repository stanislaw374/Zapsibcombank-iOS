/*
 * PointAnnotation.h
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011 YANDEX
 * 
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import <Foundation/Foundation.h>
#import "YandexMapKit.h"
#import "MapObject.h"

@interface PointAnnotation : NSObject <YMKAnnotation>

+ (id)pointAnnotation;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic) YMKMapCoordinate coordinate;

@property (nonatomic, strong) MapObject *mapObject;

@end
