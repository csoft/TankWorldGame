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


@end
