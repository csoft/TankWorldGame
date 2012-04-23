//
//  TankMapManager.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-24.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TankMapManager : NSObject
{
    CGSize _tileSize;//瓦片的大小
    
    //自己坦克默认位置集合
    NSMutableArray * _meTankDefaultPositionArray;
    
    //电脑坦克默认位置集合
    NSMutableArray * _npcTankDefaultPositionArray;
    
    
}
@property (nonatomic,assign)CGSize tileSize;
@property (nonatomic,readonly,retain)NSMutableArray * meTankDefaultPositionArray;
@property (nonatomic,readonly,retain)NSMutableArray * npcTankDefaultPositionArray;

+ (TankMapManager *)shareTankMapManager;



//根据坦克位置地图的属性字典，初始化自己和电脑坦克位置
- (void) setupTankPositionWithTankPositionMap:(NSDictionary *) tankPositionMapProperties;



@end