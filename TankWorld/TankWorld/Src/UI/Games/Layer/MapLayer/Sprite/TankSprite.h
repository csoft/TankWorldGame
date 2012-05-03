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
#import "TankWorldProtocol.h"

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
    
    id<SpriteDelegate>   _delegate;//精灵委托
    
    BOOL _isNPC;     //是否是智能NPC
}

@property(nonatomic,retain)TankModel *          tankModel;
@property(nonatomic,retain)BulletSprite *       bullet;
@property(nonatomic,retain)RadarSprite *        radar;
@property(nonatomic,retain)BarrelSprite *       barrel;
@property(nonatomic,assign)id<SpriteDelegate>   delegate;



//根据坦克的类型创建自己控制的坦克精灵
+ (TankSprite *) tankSpriteForMeWithTankModelType:(TankModelType)tankType;

//根据地图信息创建NPC坦克精灵
+ (NSMutableArray *) tankSpritesForNPC;


//根据坦克的类型创建坦克精灵
//+ (id) tankSpriteWithTankModelType:(TankModelType)tankType;



//根据角度移动
- (BOOL) moveWithAngle:(CGFloat)angle;

//坦克根据地图上的目的坐标移动
- (BOOL) moveWithDestPosition:(CGPoint)aDestPosition;


//坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BulletSprite *) tankFireWithTankFireType:(TankFireType) fireType;

//激活或者关闭坦克智能系统
- (void) activeNPCTank:(BOOL) isActive;

@end
