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



//根据坦克位置地图的属性字典，初始化自己和电脑坦克位置
- (void) setupTankPositionWithTankPositionMap:(NSDictionary *) tankPositionMapProperties
{
    
    //获取自己的坦克可以放置的位置
    NSInteger meTankNumber = [[tankPositionMapProperties objectForKey:@"MeTankNumber"] intValue];
    NSAssert(meTankNumber > 0,@"自己坦克数量不能少于0");
    
    if(!_meTankDefaultPositionArray)
    {
        _meTankDefaultPositionArray = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    [_meTankDefaultPositionArray removeAllObjects];
    
    for(int i = 1;i <= meTankNumber;i++)
    {
        NSString * meTank_x = [NSString stringWithFormat:@"MeTank_x%d",i];
        NSString * meTank_y = [NSString stringWithFormat:@"MeTank_y%d",i];
        
        CGPoint meTankPoint = CGPointMake([[tankPositionMapProperties objectForKey:meTank_x] intValue],
                                          [[tankPositionMapProperties objectForKey:meTank_y] intValue]);
        
        [_meTankDefaultPositionArray addObject:[NSValue valueWithCGPoint:meTankPoint]];
        
    }
    
    //获取电脑坦克可以放置的位置
    
    NSInteger npcTankNumber = [[tankPositionMapProperties objectForKey:@"NPCTankNumber"] intValue];
    
    if(!_npcTankDefaultPositionArray)
    {
        _npcTankDefaultPositionArray = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    [_npcTankDefaultPositionArray removeAllObjects];
    
    for(int i = 1;i <= npcTankNumber;i++)
    {
        NSString * npcTank_x = [NSString stringWithFormat:@"NPCTank_x%d",i];
        NSString * npcTank_y = [NSString stringWithFormat:@"NPCTank_y%d",i];
        
        CGPoint npcTankPoint = CGPointMake([[tankPositionMapProperties objectForKey:npcTank_x] intValue],
                                          [[tankPositionMapProperties objectForKey:npcTank_y] intValue]);
        
        [_npcTankDefaultPositionArray addObject:[NSValue valueWithCGPoint:npcTankPoint]];
        
    }
    
    
    
}

//判断指定的坦克是否能按指定角度移动
- (BOOL) canMoveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle
{
    return YES;
}




//让指定的坦克按指定角度移动，此函数内部会判断是否能移动，移动的话返回YES，否则NO
- (BOOL) moveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle
{
    return YES;
}



//指定坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BOOL) tankFireForTankModel:(TankModel *)aTankModel  withTankFireType:(TankFireType) fireType
{
    return YES;
}


@end
