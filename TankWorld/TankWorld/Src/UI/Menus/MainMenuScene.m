//
//  MainMenuScene.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "MainMenuScene.h"
#import "MainGameScene.h"

@implementation MainMenuScene

+ (CCScene *)scene
{
    CCScene * mainScene = [CCScene node];
    
    MainMenuScene * layer = [MainMenuScene node];
    [mainScene addChild:layer];
    
    return mainScene;
}


//创建新游戏
- (void) newGame
{
    [[CCDirector sharedDirector] replaceScene:[MainGameScene scene]];
}

//退出
- (void) endGame
{
    [[CCDirector sharedDirector] end];
}



- (void) drawMenu
{
    [CCMenuItemFont setFontSize:72];
    CCMenuItem * miTitle = [CCMenuItemFont itemFromString:@"Tank World"];
    [miTitle setIsEnabled:NO];
    
    [CCMenuItemFont setFontSize:32];
    
    CCMenuItem * miNewGame = [CCMenuItemFont itemFromString:NSLocalizedString(@"New Game", @"新游戏") 
                                                     target:self 
                                                   selector:@selector(newGame)];
    
    
    CCMenuItem * miEndGame = [CCMenuItemFont itemFromString:NSLocalizedString(@"End Game", @"结束游戏") 
                                                     target:self 
                                                   selector:@selector(endGame)];
    
    CCMenu * mainMenu = [CCMenu menuWithItems:miTitle,miNewGame,miEndGame,nil];
    [mainMenu alignItemsVertically];
    
    [self addChild:mainMenu];
    
    
}


- (id) init
{
    if(self = [super init])
    {
        [self drawMenu];
    }
    return self;
}

@end
