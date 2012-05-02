//
//  TankModelManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "TankModelManager.h"
#import "TankModel.h"
#import "BulletModel.h"
#import "RadarModel.h"
#import "BarrelModel.h"
#import <math.h>
#import "TankMapManager.h"
#import "DDLog.h"
#import "TankWorldConfig.h"


@implementation TankModelManager
@synthesize meTankIndex=_meTankIndex;


+ (TankModelManager *)shareTankModelManager
{
    static TankModelManager * shareModelManager = nil;
    
    if(shareModelManager){return shareModelManager;}
    
    shareModelManager = [[TankModelManager alloc] init];
    
    return shareModelManager;
}


- (id) init
{
    if(self = [super init])
    {

        tankModelConstData = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TankModelInfo" ofType:@"plist"]];
        
        _meTankIndex = 0;
        
    }
    
    return self;
}



- (TankModel *) tankModelWithTankType:(TankModelType)tankType
{
    TankModel * tm = [[TankModel alloc] init];
    tm.tankType = tankType;
    
    
    //去处对应类型的坦克的常数据
    NSDictionary * dicTankModel = [tankModelConstData objectAtIndex:(NSUInteger)tankType];
    
    tm.tankSize = CGSizeMake([[dicTankModel objectForKey:@"TankSize_Width"] floatValue], 
                             [[dicTankModel objectForKey:@"TankSize_Height"] floatValue]);
    tm.moveSpeed = [[dicTankModel objectForKey:@"MoveSpeed"] floatValue];
    tm.turnSpeed = [[dicTankModel objectForKey:@"TurnSpeed"] floatValue];
    tm.lifeValue = [[dicTankModel objectForKey:@"LifeValue"] floatValue];
    tm.fieldOfView = [[dicTankModel objectForKey:@"FieldOfView"] floatValue];
    
    
        
    NSDictionary * dicRadarModel = [dicTankModel objectForKey:@"RadarModel"];
    tm.radar = [[[RadarModel alloc] init] autorelease];
    tm.radar.fieldOfView = [[dicRadarModel objectForKey:@"FieldOfView"] floatValue];
    
    NSDictionary * dicBarrelModel = [dicTankModel objectForKey:@"BarrelModel"];
    tm.barrel = [[[BarrelModel alloc] init] autorelease];
    tm.barrel.turnSpeed = [[dicBarrelModel objectForKey:@"TurnSpeed"] floatValue]; 
    
    return [tm autorelease];
    
}


- (BulletModel *) bulletModelWithTankType:(TankModelType)tankType
{
    //去处对应类型的坦克的常数据
    NSDictionary * dicTankModel = [tankModelConstData objectAtIndex:(NSUInteger)tankType];
    
    NSDictionary * dicBulletModel = [dicTankModel objectForKey:@"BulletModel"];
    BulletModel * bullet = [[BulletModel alloc] init];
    
    bullet = [[[BulletModel alloc] init] autorelease];
    bullet.harmValue = [[dicBulletModel objectForKey:@"HarmValue"] floatValue];
    bullet.maxLiftValue = [[dicBulletModel objectForKey:@"LiftValue"] floatValue];
    bullet.liftValue = bullet.maxLiftValue;
    bullet.moveSpeed = [[dicBulletModel objectForKey:@"MoveSpeed"] floatValue];
    bullet.bulletSize = CGSizeMake([[dicBulletModel objectForKey:@"BulletSize_Width"] floatValue], 
                                      [[dicBulletModel objectForKey:@"BulletSize_Height"] floatValue]);
    return [bullet autorelease];
}

//根据类型获取自己的坦克实体，此实体包含了位置信息
- (TankModel *) meTankModelWithTankType:(TankModelType)tankType
{
    NSMutableArray * _meTankDefaultPositionArray = [TankMapManager shareTankMapManager].meTankDefaultPositionArray;
    NSAssert([_meTankDefaultPositionArray count] > 0,@"需要先初始化坦克位置,自己坦克数量不能少于0");
    
    if(_meTankModel) return _meTankModel;
    
    _meTankModel = [[self tankModelWithTankType:tankType] retain];
    _meTankModel.position = [[_meTankDefaultPositionArray objectAtIndex:_meTankIndex] CGPointValue];
    
    _meTankModel.angle = changeDegreesToAngle(90);//垂直于X轴
    
    _meTankModel.barrel.angle = changeDegreesToAngle(90);//垂直于X轴
    
    return _meTankModel;
}

//获取其他的坦克的集合，包括NPC，以及联网的对手的坦克集合
- (NSArray *)otherTankModels
{
 
    NSMutableArray * _npcTankDefaultPositionArray = [TankMapManager shareTankMapManager].npcTankDefaultPositionArray;
    NSAssert(_npcTankDefaultPositionArray,@"需要先初始化坦克位置");
    
    if(_otherTankModels) {return _otherTankModels;}
    
    _otherTankModels = [[NSMutableArray alloc] initWithCapacity:10];
    
    for(int i = 0; i< [_npcTankDefaultPositionArray count]; i++)
    {
        TankModel * tmOther = [self tankModelWithTankType:kTankModelTypeDefault];
        tmOther.position = [[_npcTankDefaultPositionArray objectAtIndex:i] CGPointValue];
        tmOther.angle = changeDegreesToAngle(90);
        tmOther.barrel.angle = changeDegreesToAngle(90);//垂直于X轴
        [_otherTankModels addObject:tmOther];
    }
    
    return _otherTankModels;
    
}



//判断指定的坦克是否能按指定角度移动
- (BOOL) canMoveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle
{
    return YES;
}




//让指定的坦克按指定角度移动，此函数内部会判断是否能移动，移动的话返回YES，否则NO
- (BOOL) moveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle
{
    CGFloat dx = aTankModel.moveSpeed*cos(angle);
    CGFloat dy = aTankModel.moveSpeed*sin(angle);
    
    
	DDLogVerbose(@"angle:%0.f old:(%.0f, %.0f) moved: (%.0f, %.0f)", angle,aTankModel.position.x,aTankModel.position.y,dx,dy); 
    aTankModel.angle = angle;
    aTankModel.position = CGPointMake(aTankModel.position.x+dx, aTankModel.position.y+dy);
    
    return YES;
}

//坦克根据地图上的目的坐标移动
- (BOOL) moveForTankModel:(TankModel *)aTankModel withDestPosition:(CGPoint)aDestPosition
{
    aTankModel.position = aDestPosition;
    return YES;
}



//指定坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BulletModel *) tankFireForTankModel:(TankModel *)aTankModel  withTankFireType:(TankFireType) fireType
{
    //fireType参数以后扩展，产生不一样的炮弹。
    
    
    
    if(aTankModel.bullet)
    {
        if(aTankModel.bullet.liftValue > 0)
        {//炮弹已经存在，不产生炮弹
            return nil;
        }
    }
    else
    {
        aTankModel.bullet = [self bulletModelWithTankType:fireType];
        
    }
    //炮弹原先消失的，重新赋值产生新炮弹
    aTankModel.bullet.liftValue = aTankModel.bullet.maxLiftValue;
    aTankModel.bullet.position = aTankModel.position;
    aTankModel.bullet.angle = aTankModel.barrel.angle;

    return aTankModel.bullet; 
    
}


@end
