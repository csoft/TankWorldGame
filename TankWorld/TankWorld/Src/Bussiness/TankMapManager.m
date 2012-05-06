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
@synthesize gameMap=_gameMap;
@synthesize screenSize=_screenSize;

#pragma mark -
#pragma mark 内部接口


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

- (void)setScreenSize:(CGSize)screenSize
{
    _screenSize = screenSize;
    _screenCenter = CGPointMake(_screenSize.width * 0.5f, _screenSize.height * 0.5f);
}

#pragma mark -
#pragma mark 初始化以及释放


+ (TankMapManager *)shareTankMapManager
{
    static TankMapManager * shareMapManager = nil;
    
    if(shareMapManager){return shareMapManager;}
    
    shareMapManager = [[TankMapManager alloc] init];
    
    return shareMapManager;
}

- (id) init
{
    if(self = [super init])
    {
        _gameMap = [[CCTMXTiledMap tiledMapWithTMXFile:@"defaultTileMap.tmx"] retain];
        
        _groundLayer = [[_gameMap layerNamed:@"Ground"] retain];
        NSAssert(_groundLayer != nil, @"Ground layer not found!");
        
        const int borderSize = 10;
		playableAreaMin = CGPointMake(borderSize, borderSize);
		playableAreaMax = CGPointMake(_gameMap.mapSize.width - 1 - borderSize, _gameMap.mapSize.height - 1 - borderSize);
        
        
        //获取坦克默认放置的位置地图层
        CCTMXLayer* tankPositionLayer = [_gameMap layerNamed:@"TankPosition"];
        
        //初始化坦克位置
        [self setupTankPositionWithTankPositionMap:(NSDictionary*)[tankPositionLayer properties]];
    }
    
    return self;
}

- (void)dealloc
{
    [_gameMap release];
    [_groundLayer release];
    [_meTankDefaultPositionArray release];
    [_npcTankDefaultPositionArray release];
    [super dealloc];
}



#pragma mark -
#pragma mark 外部接口


//从屏幕上的x，y 获取对一个地图上的X，Y
- (CGPoint)tilePositionFromScreenPosition:(CGPoint)aScreenPosition
{
    //求出相对位置
    CGPoint pos = ccpSub(aScreenPosition, _gameMap.position);
	
	float halfMapWidth = _gameMap.mapSize.width * 0.5f;
	float mapHeight = _gameMap.mapSize.height;
	float tileWidth = _gameMap.tileSize.width;
	float tileHeight = _gameMap.tileSize.height;
	
    //根据当前的位置求出对应tile的x,y值
	CGPoint tilePosDiv = CGPointMake(pos.x / tileWidth, pos.y / tileHeight);
	float mapHeightDiff = mapHeight - tilePosDiv.y;
    
	float posX = (int)(mapHeightDiff + tilePosDiv.x - halfMapWidth);
	float posY = (int)(mapHeightDiff - tilePosDiv.x + halfMapWidth);
    
	//地图边界检测
	posX = MAX(playableAreaMin.x, posX);
	posX = MIN(playableAreaMax.x, posX);
    
	posY = MAX(playableAreaMin.y, posY);
	posY = MIN(playableAreaMax.y, posY);
	
	pos = CGPointMake(posX, posY);
	
	CCLOG(@"Screen Position at (%.0f, %.0f)---TilePosition (%i, %i)", 
          aScreenPosition.x, aScreenPosition.y, (int)pos.x, (int)pos.y);
	
	return pos;
    
    
}

//根据地图上的X，y，获取屏幕上对应的X，y
- (CGPoint)screenPositionFromTilePosition:(CGPoint)aTilePosition
{
    
    aTilePosition.y -= 1;//地图y偏移1才能准确
    
    CGPoint tankWinPos = [_groundLayer positionAt:aTilePosition];
    return tankWinPos;
}


//移动地图上的一个点到到屏幕中心
- (void) moveTilePositionToScreenCenter:(CGPoint)aTilePosition
{
	
	// internally tile Y coordinates seem to be off by 1, this fixes the returned pixel coordinates
	aTilePosition.y -= 1;
	
	// get the pixel coordinates for a tile at these coordinates
	CGPoint scrollPosition = [_groundLayer positionAt:aTilePosition];
    
	// negate the position for scrolling
	scrollPosition = ccpMult(scrollPosition, -1);
    
	// add offset to screen center
	scrollPosition = ccpAdd(scrollPosition, _screenCenter);
	
	CCLOG(@"TilePosition: (%i, %i) moveTo: (%.0f, %.0f)", 
          (int)aTilePosition.x, (int)aTilePosition.y, scrollPosition.x, scrollPosition.y);

    _gameMap.position = scrollPosition;
	
//	CCAction* move = [CCMoveTo actionWithDuration:0.2f position:scrollPosition];
//	[tileMap stopAllActions];
//	[tileMap runAction:move];
}


//判断指定的地图位置坦克是否可以到达
- (BOOL)canTankGotoTilePosition:(CGPoint)aTilePosition
{
    return YES;
}

//判断坦克炮弹是否可以到达指定的地图中的点
- (BOOL)canTankBulletGotoTilePosition:(CGPoint)aTilePosition
{
    return YES;
}



@end


