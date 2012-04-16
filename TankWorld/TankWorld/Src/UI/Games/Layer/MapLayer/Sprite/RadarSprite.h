//
//  RadarSprite.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class RadarModel;
@interface RadarSprite : CCSprite 
{
    RadarModel *        _radarModel;//雷达数据实体
}
@property(nonatomic,retain)RadarModel *        radarModel;

@end
