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


//判断指定的坦克是否能往左移动
- (BOOL) canMoveLeftForTankModel:(TankModel *)aTankModel;

//判断指定的坦克是否能否往右移动
- (BOOL) canMoveRightForTankModel:(TankModel *)aTankModel;

//判断指定的坦克是否能否往上移动
- (BOOL) canMoveUpForTankModel:(TankModel *)aTankModel;

//判断指定的坦克是否能否往下移动
- (BOOL) canMoveDownForTankModel:(TankModel *)aTankModel;



//指定的坦克是否能往左移动
- (BOOL) moveToLeftForTankModel:(TankModel *)aTankModel;

//指定的坦克是否能否往右移动
- (BOOL) moveToRightForTankModel:(TankModel *)aTankModel;

//指定的坦克是否能否往上移动
- (BOOL) moveToUpForTankModel:(TankModel *)aTankModel;

//指定的坦克是否能否往下移动
- (BOOL) moveToDownForTankModel:(TankModel *)aTankModel;






@end
