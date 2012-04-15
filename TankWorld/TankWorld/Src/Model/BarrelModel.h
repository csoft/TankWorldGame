//
//  BarrelModel.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BarrelModel : NSObject
{
    CGFloat         _angle;//此炮筒当前的角度，发射的炮弹就是这个角度
    
    CGFloat         _turnSpeed;//此炮筒转动的速度
}
@property(nonatomic,assign)CGFloat          angle;
@property(nonatomic,assign)CGFloat          turnSpeed;

@end
