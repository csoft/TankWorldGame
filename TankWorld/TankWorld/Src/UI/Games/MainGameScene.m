//
//  MainGameScene.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "MainGameScene.h"
#import "ControlMainLayer.h"
#import "MapMainLayer.h"
//#import "SpriteMainLayer.h"


@implementation MainGameScene

+ (CCScene *) scene
{
    CCScene * mainScene = [CCScene node];
    
    MainGameScene * mgc = [MainGameScene node];
    
    [mainScene addChild:mgc];
    
    return mainScene;
}

- (void) addMapLayer
{
    MapMainLayer * mmlayer = [MapMainLayer node];
    [self addChild:mmlayer];
}

//- (void) addSpriteLayer
//{
//    SpriteMainLayer * smlayer= [SpriteMainLayer node];
//    [self addChild:smlayer];
//}

- (void) addControlLayer
{
    ControlMainLayer * cmLayer = [ControlMainLayer node];
    [self addChild: cmLayer];
}


- (id) init
{
    if(self = [super init])
    {
        [self addMapLayer];
        //[self addSpriteLayer];
        [self addControlLayer];
    }
    return self;
}

@end
