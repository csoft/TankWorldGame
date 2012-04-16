//
//  MapMainLayer.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "MapMainLayer.h"
#import "TankWorldTypeDef.h"


@implementation MapMainLayer

- (id) init
{
    if(self = [super init])
    {
        CCSprite * bgSprite = [CCSprite spriteWithFile:@"worldmap.jpg"];
        [self addChild:bgSprite];
        
    }
    return self;
}








#pragma -
#pragma MapMainLayerDelegate

//坦克根据指定角度移动，移动成功返回YES，失败NO
- (BOOL) tankMoveWithAngle:(CGFloat) angle
{
    return YES;
}


//坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BOOL) tankFireWithTankFireType:(TankFireType) fireType
{
    return YES;
}







@end
