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
@interface TankModelManager : NSObject
{
    NSArray * tankModelConstData;//坦克不一样类型对应的一些固定的数据，和TankModelInfo.plist文件对应
    
}

+ (TankModelManager *)shareTankModelManager;

- (TankModel *) tankModelWithTankType:(TankModelType)tankType;


//判断指定的坦克是否能按指定角度移动
- (BOOL) canMoveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle;



//让指定的坦克按指定角度移动，此函数内部会判断是否能移动，移动的话返回YES，否则NO
- (BOOL) moveForTankModel:(TankModel *)aTankModel withAngle:(CGFloat)angle;




@end
