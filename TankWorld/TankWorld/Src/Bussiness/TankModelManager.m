//
//  TankModelManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "TankModelManager.h"
#import "TankModel.h"


@implementation TankModelManager

+ (TankModelManager *)shareTankModelManager
{
    static TankModelManager * shareModelManager = nil;
    
    if(shareModelManager){return shareModelManager;}
    
    shareModelManager = [[TankModelManager alloc] init];
    
    return shareModelManager;
}

- (TankModel *) tankModelWithTankType:(TankModelType)tankType
{
    TankModel * tm = [[TankModel alloc] init];
    tm.tankType = tankType;
    
}


@end
