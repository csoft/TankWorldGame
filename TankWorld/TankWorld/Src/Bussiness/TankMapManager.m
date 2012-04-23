//
//  TankMapManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-24.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "TankMapManager.h"

@implementation TankMapManager
@synthesize tileSize=_tileSize;
@synthesize meTankDefaultPositionArray=_meTankDefaultPositionArray;
@synthesize npcTankDefaultPositionArray=_npcTankDefaultPositionArray;

+ (TankMapManager *)shareTankMapManager
{
    static TankMapManager * shareMapManager = nil;
    
    if(shareMapManager){return shareMapManager;}
    
    shareMapManager = [[TankMapManager alloc] init];
    
    return shareMapManager;
}



//根据坦克位置地图的属性字典，初始化自己和电脑坦克位置
- (void) setupTankPositionWithTankPositionMap:(NSDictionary *) tankPositionMapProperties
{
    
    //获取自己的坦克可以放置的位置
    NSInteger meTankNumber = [[tankPositionMapProperties objectForKey:@"MeTankNumber"] intValue];
    NSAssert(meTankNumber > 0,@"自己坦克数量不能少于0");
    
    if(!_meTankDefaultPositionArray)
    {
        _meTankDefaultPositionArray = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    [_meTankDefaultPositionArray removeAllObjects];
    
    for(int i = 1;i <= meTankNumber;i++)
    {
        NSString * meTank_x = [NSString stringWithFormat:@"MeTank_x%d",i];
        NSString * meTank_y = [NSString stringWithFormat:@"MeTank_y%d",i];
        
        CGPoint meTankPoint = CGPointMake([[tankPositionMapProperties objectForKey:meTank_x] intValue],
                                          [[tankPositionMapProperties objectForKey:meTank_y] intValue]);
        
        [_meTankDefaultPositionArray addObject:[NSValue valueWithCGPoint:meTankPoint]];
        
    }
    
    //获取电脑坦克可以放置的位置
    
    NSInteger npcTankNumber = [[tankPositionMapProperties objectForKey:@"NPCTankNumber"] intValue];
    
    if(!_npcTankDefaultPositionArray)
    {
        _npcTankDefaultPositionArray = [[NSMutableArray alloc] initWithCapacity:8];
    }
    
    [_npcTankDefaultPositionArray removeAllObjects];
    
    for(int i = 1;i <= npcTankNumber;i++)
    {
        NSString * npcTank_x = [NSString stringWithFormat:@"NPCTank_x%d",i];
        NSString * npcTank_y = [NSString stringWithFormat:@"NPCTank_y%d",i];
        
        CGPoint npcTankPoint = CGPointMake([[tankPositionMapProperties objectForKey:npcTank_x] intValue],
                                           [[tankPositionMapProperties objectForKey:npcTank_y] intValue]);
        
        [_npcTankDefaultPositionArray addObject:[NSValue valueWithCGPoint:npcTankPoint]];
        
    }
    
    
    
}



@end


