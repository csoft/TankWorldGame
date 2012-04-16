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


@implementation TankModelManager

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





@end
