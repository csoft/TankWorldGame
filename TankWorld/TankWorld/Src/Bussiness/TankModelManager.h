//
//  TankModelManager.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TankWorldTypeDef.h"


@class TankModel;
@class BulletModel;
@interface TankModelManager : NSObject
{
    NSArray * tankModelConstData;//坦克不一样类型对应的一些固定的数据，和TankModelInfo.plist文件对应
    
    //自己控制的坦克的索引号，因为多个人联网对打时，此索引号指定自己的坦克在地图中的位置索引，
    //对打时这个数据是服务器随机产生分配给各个玩家的,单打时在玩家数内随机一个位置
    NSInteger  _meTankIndex;
    
    
    //自己控制的坦克
    TankModel * _meTankModel;
    
    //电脑坦克和联机的坦克的集合
    NSMutableArray * _otherTankModels;
    
    
}
@property(nonatomic,assign)NSInteger  meTankIndex;


+ (TankModelManager *)shareTankModelManager;

- (TankModel *) tankModelWithTankType:(TankModelType)tankType;

- (BulletModel *)bulletModelWithTankType:(TankModelType)tankType;

//根据类型获取自己的坦克实体，此实体包含了位置信息
- (TankModel *) meTankModelWithTankType:(TankModelType)tankType;

//获取其他的坦克的集合，包括NPC，以及联网的对手的坦克集合
- (NSArray *)otherTankModels;


//判断指定的坦克是否能按指定角度移动
- (BOOL) canMoveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle;



//让指定的坦克按指定角度移动，此函数内部会判断是否能移动，移动的话返回YES，否则NO
- (BOOL) moveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle;

//坦克根据地图上的目的坐标移动
- (BOOL) moveForTankModel:(TankModel *)aTankModel withDestPosition:(CGPoint)aDestPosition;


//指定坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BulletModel *) tankFireForTankModel:(TankModel *)aTankModel  withTankFireType:(TankFireType) fireType;




@end
