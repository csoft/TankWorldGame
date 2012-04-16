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

@interface ControlMainLayer : CCLayer 
{
    
    id<MapMainLayerDelegate>        _mapMainLayerDelegate;//地图层委托，用来回调坦克移动和发射炮弹
    
}
@property(nonatomic,assign)id<MapMainLayerDelegate>         mapMainLayerDelegate;


@end
