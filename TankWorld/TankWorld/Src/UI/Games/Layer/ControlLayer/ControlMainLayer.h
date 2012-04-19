//
//  ControlMainLayer.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TankWorldProtocol.h"

// SneakyInput headers
#import "ColoredCircleSprite.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedBase.h"

#import "SneakyExtensions.h"

@interface ControlMainLayer : CCLayer 
{
    SneakyButton* fireButton;
	SneakyJoystick* joystick;
	
	ccTime totalTime;
	ccTime nextShotTime;
    
    id<MapMainLayerDelegate>        _mapMainLayerDelegate;//地图层委托，用来回调坦克移动和发射炮弹
    
}
@property(nonatomic,assign)id<MapMainLayerDelegate>         mapMainLayerDelegate;


@end
