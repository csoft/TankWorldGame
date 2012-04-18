//
//  MainGameScene.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainGameScene : CCLayer {
    
    //可运动的最小区域值和最大区域值
    CGPoint playableAreaMin, playableAreaMax;
    
}

+ (CCScene *) scene;

@end
