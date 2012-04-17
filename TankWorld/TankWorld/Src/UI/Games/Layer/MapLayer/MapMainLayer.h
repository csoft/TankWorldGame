//
//  MapMainLayer.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TankWorldProtocol.h"

@class TankSprite;
@interface MapMainLayer : CCLayer<MapMainLayerDelegate> 
{
    
    CCTMXTiledMap *gameMap;//游戏地图
    
    TankSprite * meTank;//自己控制的坦克
    
}




@end
