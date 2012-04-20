//
//  MapMainLayer.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "MapMainLayer.h"
#import "TankWorldTypeDef.h"
#import "TankSprite.h"
#import "TankModel.h"
#import "BulletModel.h"
#import "RadarModel.h"
#import "BarrelModel.h"
#import "BulletSprite.h"
#import "RadarSprite.h"
#import "BarrelSprite.h"

@implementation MapMainLayer

#pragma mark -
#pragma mark private method

//根据触摸点转换成坐标点
-(CGPoint) locationFromTouch:(UITouch*)touch
{
	CGPoint touchLocation = [touch locationInView: [touch view]];
	return [[CCDirector sharedDirector] convertToGL:touchLocation];
}

//根据触摸点转换成坐标点
-(CGPoint) locationFromTouches:(NSSet*)touches
{
	return [self locationFromTouch:[touches anyObject]];
}

//根据坐标点返回地图的x,y值
-(CGPoint) tilePosFromLocation:(CGPoint)location tileMap:(CCTMXTiledMap*)tileMap
{
	//求出相对位置
    CGPoint pos = ccpSub(location, tileMap.position);
	
	float halfMapWidth = tileMap.mapSize.width * 0.5f;
	float mapHeight = tileMap.mapSize.height;
	float tileWidth = tileMap.tileSize.width;
	float tileHeight = tileMap.tileSize.height;
	
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
	
	CCLOG(@"touch at (%.0f, %.0f) is at tileCoord (%i, %i)", location.x, location.y, (int)pos.x, (int)pos.y);
	
	return pos;
}


//根据坐标位置移动地图
-(void) centerTileMapOnTileCoord:(CGPoint)tilePos tileMap:(CCTMXTiledMap*)tileMap
{
	
    //地图的中心点
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
	CGPoint screenCenter = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
	
	//获取背景层
	CCTMXLayer* layer = [tileMap layerNamed:@"Ground"];
	NSAssert(layer != nil, @"Ground layer not found!");
	
	// internally tile Y coordinates seem to be off by 1, this fixes the returned pixel coordinates
	tilePos.y -= 1;
	
	// get the pixel coordinates for a tile at these coordinates
	CGPoint scrollPosition = [layer positionAt:tilePos];
	// negate the position for scrolling
	scrollPosition = ccpMult(scrollPosition, -1);
	// add offset to screen center
	scrollPosition = ccpAdd(scrollPosition, screenCenter);
	
	CCLOG(@"tilePos: (%i, %i) moveTo: (%.0f, %.0f)", (int)tilePos.x, (int)tilePos.y, scrollPosition.x, scrollPosition.y);
	
	CCAction* move = [CCMoveTo actionWithDuration:0.2f position:scrollPosition];
	[tileMap stopAllActions];
	[tileMap runAction:move];
}


- (id) init
{
    if(self = [super init])
    {        
        //加载地图
        gameMap = [CCTMXTiledMap tiledMapWithTMXFile:@"defaultTileMap.tmx"];
        [self addChild:gameMap z:0 tag:kTileMapLevelDefault];
        
        //TODO: 此位置要动态获取，使自己的坦克放在指定的位置
		gameMap.position = CGPointMake(-1000, -600);
        
        
		self.isTouchEnabled = YES;
		const int borderSize = 10;
		playableAreaMin = CGPointMake(borderSize, borderSize);
		playableAreaMax = CGPointMake(gameMap.mapSize.width - 1 - borderSize, gameMap.mapSize.height - 1 - borderSize);
        
        meTank = [TankSprite tankSpriteWithTankModelType:kTankModelTypeDefault];
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        CGPoint screenCenter = CGPointMake(screenSize.width * 0.5f, screenSize.height * 0.5f);
        meTank.position =screenCenter;//自己的坦克固定显示在屏幕中间
        meTank.tankModel.name = @"me";
        [self addChild:meTank z:0 tag:2];
        
        
		//添加电脑坦克，以及联网情况下对方的坦克
        TankSprite * npcTank = [TankSprite tankSpriteWithTankModelType:kTankModelTypeDefault];
        //npcTank.position = CGPointMake(1000, 500);//此位置是相对于地图的位置
        npcTank.tankModel.name = @"npc1";
        [otherTanks addObject:npcTank];
        [gameMap addChild:npcTank];
        
        
        CCTMXLayer* groundLayer = [gameMap layerNamed:@"Ground"];
        CGPoint tankPos = [groundLayer positionAt:CGPointMake(10,10)];
        npcTank.position = tankPos;
        
        //获取坦克默认放置的位置
        CCTMXLayer* tankPositionLayer = [gameMap layerNamed:@"TankPosition"];
        NSDictionary * dic = [tankPositionLayer properties];
        
        //获取自己的坦克可以放置的位置
        NSInteger meTank_map_x = [[dic objectForKey:@"MeTank_x"] intValue];
        NSInteger meTank_map_y = [[dic objectForKey:@"MeTank_y"] intValue];
        
        
        
        
        
        
        
        npcTank = [TankSprite tankSpriteWithTankModelType:kTankModelTypeDefault];
        npcTank.position = CGPointMake(1080, 580);//此位置是相对于地图的位置
        npcTank.tankModel.name = @"npc2";
        [otherTanks addObject:npcTank];
        [gameMap addChild:npcTank];
        
        npcTank = [TankSprite tankSpriteWithTankModelType:kTankModelTypeDefault];
        npcTank.position = CGPointMake(1200, 600);//此位置是相对于地图的位置
        npcTank.tankModel.name = @"npc3";
        [otherTanks addObject:npcTank];
        [gameMap addChild:npcTank];
        
    }
    return self;
}


#pragma -
#pragma MapMainLayerDelegate

//坦克根据指定角度移动，移动成功返回YES，失败NO
- (BOOL) tankMoveWithAngle:(CGFloat) angle
{
    return [meTank moveWithAngle:angle];
}


//坦克根据发射类型发射炮弹，发射成功返回YES，否则NO，返回失败的原因可能是炮弹不足
- (BOOL) tankFireWithTankFireType:(TankFireType) fireType
{
    return YES;
}


#pragma mark -
#pragma mark Touches Event

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CCNode* node = [self getChildByTag:kTileMapLevelDefault];
	NSAssert([node isKindOfClass:[CCTMXTiledMap class]], @"not a CCTMXTiledMap");
	CCTMXTiledMap* tileMap = (CCTMXTiledMap*)node;
    
	CGPoint touchLocation = [self locationFromTouches:touches];
	CGPoint tilePos = [self tilePosFromLocation:touchLocation tileMap:tileMap];
    
	// move tilemap so that touched tiles is at center of screen
	[self centerTileMapOnTileCoord:tilePos tileMap:tileMap];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}





@end
