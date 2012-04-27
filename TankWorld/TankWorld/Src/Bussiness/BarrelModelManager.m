//
//  BarrelModelManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-27.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "BarrelModelManager.h"

@implementation BarrelModelManager


+ (BarrelModelManager *)shareBarrelModelManager
{
    static BarrelModelManager * shareManager = nil;
    
    if(shareManager){return shareManager;}
    
    shareManager = [[BarrelModelManager alloc] init];
    
    return shareManager;
}


@end
