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
@class BarrelModel;
@interface TankModel : NSObject
{
    TankModelType   _tankType;//此坦克的类型，这个字段非常重要，因为要根据类型，去数据库中读出炮弹，雷达，移动速度，转动速度等固定的数据
    
    NSString *      _name;//此坦克的名称
    
    NSUInteger      _groupID; //此坦克所属的组（队伍），同一个组的坦克相互之间不会造成伤害
    
    BulletModel *   _bullet;//炮弹，一辆坦克发射炮弹，只能一个炮弹消失后才能发第二个，所以不是数组
    
    RadarModel *    _radar;//此坦克的雷达
    
    BarrelModel *   _barrel;//此坦克的炮筒
    
    CGPoint         _position;//此坦克现在在地图上的位置，是相对位置
    
    CGFloat         _angle;//此坦克现在的角度，参考右侧X的坐标开始，坦克移动前进方向，要转弯的话，这个角度会改变，有效值0~359
    
    CGSize          _tankSize;//此坦克的大小
    
    CGFloat         _moveSpeed;//此坦克移动的速度
    
    CGFloat         _turnSpeed;//此坦克转动的速度
    
    CGFloat         _lifeValue;//此坦克的生命值
    
    CGFloat         _fieldOfView;//此坦克的可视范围半径，以自己为圆中心点
    
}
@property(nonatomic,assign)TankModelType    tankType;
@property(nonatomic,copy)NSString *         name;
@property(nonatomic,assign)NSUInteger       groupID;
@property(nonatomic,retain)BulletModel *    bullet;
@property(nonatomic,retain)RadarModel *     radar;
@property(nonatomic,retain)BarrelModel *    barrel;
@property(nonatomic,assign)CGPoint          position;
@property(nonatomic,assign)CGFloat          angle;
@property(nonatomic,assign)CGFloat          moveSpeed;
@property(nonatomic,assign)CGSize           tankSize;
@property(nonatomic,assign)CGFloat          turnSpeed;
@property(nonatomic,assign)CGFloat          lifeValue;
@property(nonatomic,assign)CGFloat          fieldOfView;



- (id)initWithTankType:(TankModelType) tankType;

@end
