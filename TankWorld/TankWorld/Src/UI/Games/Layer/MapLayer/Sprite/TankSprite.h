//
//  TankSprite.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BulletSprite;
@class RadarSprite;
@class BarrelSprite;
@class TankModel;
@interface TankSprite : CCSprite 
{
    TankModel *         _tankModel;//坦克数据实体
    BulletSprite *      _bullet;//炮弹精灵
    RadarSprite *       _radar; //雷达精灵
    BarrelSprite *      _barrel;//炮筒精灵
    
    
}

@property(nonatomic,retain)TankModel *          tankModel;
@property(nonatomic,retain)BulletSprite *       bullet;
@property(nonatomic,retain)RadarSprite *        radar;
@property(nonatomic,retain)BarrelSprite *       barrel;
@end
