//
//  TankWorldProtocol.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-17.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TankWorldTypeDef.h"


//地图委托
@protocol ControlMainLayerDelegate <NSObject>

//坦克根据指定角度移动，移动成功返回YES，失败NO
- (BOOL) tankMoveWithAngle:(CGFloat) angle;

//坦克根据地图上的目的坐标移动
- (BOOL) tankMoveWithDestPosition:(CGPoint)aDestPosition;


//坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BOOL) tankFireWithTankFireType:(TankFireType) fireType;

@end


@protocol SpriteDelegate <NSObject>


@end


