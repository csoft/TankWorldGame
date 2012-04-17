//
//  TankSprite.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TankWorldTypeDef.h"

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


//根据坦克的类型创建坦克精灵
+ (id) tankSpriteWithTankModelType:(TankModelType)tankType;



//根据角度移动
- (BOOL) moveWithAngle:(CGFloat)angle;


//坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BOOL) tankFireWithTankFireType:(TankFireType) fireType;




@end
