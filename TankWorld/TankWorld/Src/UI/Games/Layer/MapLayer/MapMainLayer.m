//
//  MapMainLayer.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "MapMainLayer.h"


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

@end
