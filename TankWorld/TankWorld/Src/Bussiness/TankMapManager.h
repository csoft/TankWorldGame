//
//  TankMapManager.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-24.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface TankMapManager : NSObject
{
    CCTMXTiledMap * _gameMap;//地图
    CCTMXLayer    * _groundLayer;//背景层
    
    
    
    CGSize _tileSize;//瓦片的大小
    
    CGSize _screenSize;//屏幕大小
    
    CGPoint _screenCenter;//屏幕中心点
    
    //自己坦克默认位置集合
    NSMutableArray * _meTankDefaultPositionArray;
    
    //电脑坦克默认位置集合
    NSMutableArray * _npcTankDefaultPositionArray;
    
    
    //可运动的最小区域值和最大区域值
    CGPoint playableAreaMin;
    CGPoint playableAreaMax;
    
}
@property (nonatomic,assign)CGSize tileSize;
@property (nonatomic,assign)CGSize screenSize;
@property (nonatomic,readonly,retain)NSMutableArray * meTankDefaultPositionArray;
@property (nonatomic,readonly,retain)NSMutableArray * npcTankDefaultPositionArray;
@property (nonatomic,readonly,retain)CCTMXTiledMap * gameMap;

+ (TankMapManager *)shareTankMapManager;


//从屏幕上的x，y 获取对一个地图上的X，Y
- (CGPoint)tilePositionFromScreenPosition:(CGPoint)aScreenPosition;

//根据地图上的X，y，获取屏幕上对应的X，y
- (CGPoint)screenPositionFromTilePosition:(CGPoint)aTilePosition;

//移动地图上的一个点到到屏幕中心
- (void) moveTilePositionToScreenCenter:(CGPoint)aTilePosition;

//判断指定的地图位置坦克是否可以到达
- (BOOL)canTankGotoTilePosition:(CGPoint)aTilePosition;

//判断坦克炮弹是否可以到达指定的地图中的点
- (BOOL)canTankBulletGotoTilePosition:(CGPoint)aTilePosition;


@end