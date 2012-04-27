//
//  BulletModelManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-27.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "BulletModelManager.h"

@implementation BulletModelManager


+ (BulletModelManager *)shareBulletModelManager
{
    static BulletModelManager * shareManager = nil;
    
    if(shareManager){return shareManager;}
    
    shareManager = [[BulletModelManager alloc] init];
    
    return shareManager;

}

@end
