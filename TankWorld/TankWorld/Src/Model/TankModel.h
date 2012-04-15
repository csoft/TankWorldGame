//
//  TankModel.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TankWorldTypeDef.h"

@class BulletModel;
@class RadarModel;
@interface TankModel : NSObject
{
    TankModelType   _tankType;//此坦克的类型，这个字段非常重要，因为要根据类型，去数据库中读出炮弹，雷达，移动速度，转动速度等固定的数据
    
    NSUInteger _groupID; //此坦克所属的组（队伍），同一个组的坦克相互之间不会造成伤害
    
    BulletModel * _bullet;//炮弹，一辆坦克发射炮弹，只能一个炮弹消失后才能发第二个，所以不是数组
    
    RadarModel * _radar;//此坦克的雷达
    
    CGPoint    _position;//此坦克现在在地图上的坐标
    
    CGFloat    _moveSpeed;//此坦克移动的速度
    
    CGFloat    _turnSeed;//此坦克转动的速度
    
    CGFloat    _lifeValue;//此坦克的生命值
    
}
@property(nonatomic,assign)TankModelType   tankType;
@property(nonatomic,assign)NSUInteger      groupID;
@property(nonatomic,retain)BulletModel *   bullet;
@property(nonatomic,retain)RadarModel *    radar;
@property(nonatomic,assign)CGPoint      position;
@property(nonatomic,assign)CGFloat      moveSpeed;
@property(nonatomic,assign)CGFloat      turnSeed;
@property(nonatomic,assign)CGFloat      lifeValue;




- (id)initWithTankType:(TankModelType) tankType;

@end
