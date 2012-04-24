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


#pragma mark -
#pragma mark self cycle

+ (CCScene *) scene
{
    CCScene * mainScene = [CCScene node];
    
    MainGameScene * mgc = [MainGameScene node];
    
    [mainScene addChild:mgc];
    
    return mainScene;
}

- (void) addLayer
{
    MapMainLayer * mmlayer = [MapMainLayer node];
    [self addChild:mmlayer];
    
    ControlMainLayer * cmLayer = [ControlMainLayer node];
    cmLayer.controllerLayerDelegate = mmlayer;
    [self addChild: cmLayer];
    
}

- (id) init
{
    if(self = [super init])
    {
        [self addLayer];
    }
    return self;
}
 
@end
