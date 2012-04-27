//
//  RadarModelManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-27.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "RadarModelManager.h"

@implementation RadarModelManager

+ (RadarModelManager *)shareRadarModelManager
{
    static RadarModelManager * shareManager = nil;
    
    if(shareManager){return shareManager;}
    
    shareManager = [[RadarModelManager alloc] init];
    
    return shareManager;

}

@end
