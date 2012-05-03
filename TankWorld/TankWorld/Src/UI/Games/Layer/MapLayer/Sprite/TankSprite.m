//
//  TankSprite.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "TankSprite.h"
#import "TankModelManager.h"
#import "TankModel.h"
#import "BulletModel.h"
#import "BulletSprite.h"
#import "RadarModel.h"
#import "RadarSprite.h"
#import "BarrelModel.h"
#import "BarrelSprite.h"
#import "TankWorldConfig.h"
#import "TankWorldProtocol.h"
#import "DDLog.h"

@implementation TankSprite
@synthesize tankModel=_tankModel;
@synthesize bullet=_bullet;
@synthesize radar=_radar;
@synthesize barrel=_barrel;
@synthesize delegate=_delegate;


- (id) init
{
    if(self = [super init])
    {
        [self schedule:@selector(updateTheTank:) interval:SPRITE_UPDATE_TIME];
    }
    
    return self;
}


//根据坦克的类型创建自己控制的坦克精灵
+ (TankSprite *) tankSpriteForMeWithTankModelType:(TankModelType)tankType
{
    TankModel * tModel = [[TankModelManager shareTankModelManager] meTankModelWithTankType:tankType];
    
    CGFloat tankIndex = (NSUInteger)tankType*tModel.tankSize.width;
    TankSprite * ts = [[TankSprite alloc] initWithFile:@"Tank.PNG" 
                                                  rect:CGRectMake(tankIndex,0,tModel.tankSize.width,tModel.tankSize.height)];
    ts.tankModel = tModel;
    
    
    
    ts.radar = [RadarSprite radarSpriteWithRadarModel:ts.tankModel.radar];
    
    ts.barrel = [BarrelSprite barrelSpriteWithBarrelModel:ts.tankModel.barrel];
    
    
    return [ts autorelease];
}

//根据地图信息创建NPC坦克精灵
+ (NSMutableArray *) tankSpritesForNPC
{
    NSMutableArray * tankSpriteArr = [NSMutableArray array];
    NSArray * tms = [[TankModelManager shareTankModelManager] otherTankModels];
    for(TankModel * tModel in tms)
    {
        CGFloat tankIndex = (NSUInteger)kTankModelTypeDefault *tModel.tankSize.width;
        TankSprite * ts = [[TankSprite alloc] initWithFile:@"Tank.PNG" 
                                                      rect:CGRectMake(tankIndex,0,tModel.tankSize.width,tModel.tankSize.height)];
        ts.tankModel = tModel;
        
        
        
        ts.radar = [RadarSprite radarSpriteWithRadarModel:ts.tankModel.radar];
        
        ts.barrel = [BarrelSprite barrelSpriteWithBarrelModel:ts.tankModel.barrel];
        
        
        [tankSpriteArr addObject:ts];
    }
    
    return tankSpriteArr;
}


////根据坦克的类型创建坦克精灵
//+ (id) tankSpriteWithTankModelType:(TankModelType)tankType
//{
//    TankModel * tModel = [[TankModelManager shareTankModelManager] tankModelWithTankType:tankType];
//    
//    CGFloat tankIndex = (NSUInteger)tankType*tModel.tankSize.width;
//    TankSprite * ts = [[TankSprite alloc] initWithFile:@"Tank.PNG" 
//                                                  rect:CGRectMake(tankIndex,0,tModel.tankSize.width,tModel.tankSize.height)];
//    ts.tankModel = tModel;
//    
//    
//    
//    ts.radar = [RadarSprite radarSpriteWithRadarModel:ts.tankModel.radar];
//    
//    ts.barrel = [BarrelSprite barrelSpriteWithBarrelModel:ts.tankModel.barrel];
//    [ts addChild:ts.barrel z:BARREL_Z_INDEX];
//    
//    return [ts autorelease];
//    
//    
//}


//根据角度移动
- (BOOL) moveWithAngle:(CGFloat)angle
{    
    return [[TankModelManager shareTankModelManager] moveForTankModel:self.tankModel withAngle:angle];
}

//坦克根据地图上的目的坐标移动
- (BOOL) moveWithDestPosition:(CGPoint)aDestPosition
{
    return [[TankModelManager shareTankModelManager] moveForTankModel:self.tankModel withDestPosition:aDestPosition];
}

//坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BulletSprite *) tankFireWithTankFireType:(TankFireType) fireType
{
    BulletModel * bm = [[TankModelManager shareTankModelManager] tankFireForTankModel:self.tankModel
                                                                     withTankFireType:kTankFireTypeDefault];
    if(bm)
    {
        if(!_bullet)
        {
            self.bullet = [BulletSprite bulletSpriteWithBulletModel:bm];
            self.bullet.delegate = self.delegate;
            
            [self.delegate addToMapForNode:self.bullet z:BULLET_Z_INDEX tag:200];
            [self.delegate addToMapForNode:self.bullet.explodeSprite z:BULLET_EXPLOED_Z_INDEX tag:201];
            
            
        }
        
        //开火
        [_bullet fire];
        
        return _bullet;
    }
    return nil;
}

- (void) updateTheTank:(ccTime) time
{
    
    if(_isNPC)
    {
        //TODO: 智能改变自己的位置
        
        self.position = [self.delegate screenPositionWithTilePosition:self.tankModel.position];
    }
    
    self.barrel.position = self.position;
}


//激活或者关闭坦克智能系统
- (void) activeNPCTank:(BOOL) isActive
{
    _isNPC = isActive;
}


@end
