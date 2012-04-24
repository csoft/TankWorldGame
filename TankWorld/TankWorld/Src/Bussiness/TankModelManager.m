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
    
    NSDictionary * dicBulletModel = [dicTankModel objectForKey:@"BulletModel"];
    tm.bullet = [[[BulletModel alloc] init] autorelease];
    tm.bullet.harmValue = [[dicBulletModel objectForKey:@"HarmValue"] floatValue];
    tm.bullet.liftValue = [[dicBulletModel objectForKey:@"LiftValue"] floatValue];
    tm.bullet.moveSpeed = [[dicBulletModel objectForKey:@"MoveSpeed"] floatValue];
    tm.bullet.bulletSize = CGSizeMake([[dicBulletModel objectForKey:@"BulletSize_Width"] floatValue], 
                                      [[dicBulletModel objectForKey:@"BulletSize_Height"] floatValue]);
        
    NSDictionary * dicRadarModel = [dicTankModel objectForKey:@"RadarModel"];
    tm.radar = [[[RadarModel alloc] init] autorelease];
    tm.radar.fieldOfView = [[dicRadarModel objectForKey:@"FieldOfView"] floatValue];
    
    NSDictionary * dicBarrelModel = [dicTankModel objectForKey:@"BarrelModel"];
    tm.barrel = [[[BarrelModel alloc] init] autorelease];
    tm.barrel.turnSpeed = [[dicBarrelModel objectForKey:@"TurnSpeed"] floatValue]; 
    
    return [tm autorelease];
    
}

//根据类型获取自己的坦克实体，此实体包含了位置信息
- (TankModel *) meTankModelWithTankType:(TankModelType)tankType
{
    NSMutableArray * _meTankDefaultPositionArray = [TankMapManager shareTankMapManager].meTankDefaultPositionArray;
    NSAssert([_meTankDefaultPositionArray count] > 0,@"需要先初始化坦克位置,自己坦克数量不能少于0");
    
    if(_meTankModel) return _meTankModel;
    
    _meTankModel = [[self tankModelWithTankType:tankType] retain];
    _meTankModel.position = [[_meTankDefaultPositionArray objectAtIndex:_meTankIndex] CGPointValue];
    _meTankModel.angle = M_PI_2;//垂直于X轴
    
    _meTankModel.barrel.angle = M_PI_2;//垂直于X轴
    
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
        tmOther.angle = M_PI_2;
        tmOther.barrel.angle = M_PI_2;//垂直于X轴
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
- (BOOL) tankFireForTankModel:(TankModel *)aTankModel  withTankFireType:(TankFireType) fireType
{
    return YES;
}


@end
