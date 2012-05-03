//
//  GameConfig.h
//  test
//
//  Created by 学宝 陈 on 12-4-14.
//  Copyright C—SOFT 2012年. All rights reserved.
//

#ifndef __GAME_CONFIG_H
#define __GAME_CONFIG_H

#pragma mark -
#pragma mark 定义宏接口
#define changeDegreesToAngle(degrees)   -(45+(degrees))*(M_PI/180)




#pragma mark -
#pragma mark 定义精灵更新时间

#define SPRITE_UPDATE_TIME 1.0/30

#define TANK_MAP_UPDATE_TIME 1.0/30




#pragma mark -
#pragma mark 定义精灵在地图上的Z轴位置

//坦克
#define TANK_Z_INDEX     100

//炮弹
#define BULLET_Z_INDEX   200

//炮弹爆炸
#define BULLET_EXPLOED_Z_INDEX  201

//炮筒
#define BARREL_Z_INDEX  202

//雷达
#define RADAR_Z_INDEX   900

//可遮挡坦克的障碍物
#define BARRIER_Z_INDEX   300

//普通砖块
#define NORMAL_TILE_Z_INDEX  50






#pragma mark -

//
// Supported Autorotations:
//		None,
//		UIViewController,
//		CCDirector
//
#define kGameAutorotationNone 0
#define kGameAutorotationCCDirector 1
#define kGameAutorotationUIViewController 2

//
// Define here the type of autorotation that you want for your game
//

// 3rd generation and newer devices: Rotate using UIViewController. Rotation should be supported on iPad apps.
// TIP:
// To improve the performance, you should set this value to "kGameAutorotationNone" or "kGameAutorotationCCDirector"
#if defined(__ARM_NEON__) || TARGET_IPHONE_SIMULATOR
#define GAME_AUTOROTATION kGameAutorotationUIViewController

// ARMv6 (1st and 2nd generation devices): Don't rotate. It is very expensive
#elif __arm__
#define GAME_AUTOROTATION kGameAutorotationNone


// Ignore this value on Mac
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)

#else
#error(unknown architecture)
#endif

#endif // __GAME_CONFIG_H

