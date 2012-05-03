//
//  RadarSprite.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "RadarSprite.h"
#import "RadarModel.h"

@implementation RadarSprite
@synthesize radarModel = _radarModel;

+ (RadarSprite *)radarSpriteWithRadarModel:(RadarModel *)aRadarModel
{
    RadarSprite *rs = [[RadarSprite alloc] initWithFile:@"worldmap.jpg" rect:CGRectMake(0, 0, 100, 100)];
    rs.radarModel = aRadarModel;
    return [rs autorelease];
}


@end
