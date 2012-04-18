//
//  MainGameScene.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "MainGameScene.h"
#import "ControlMainLayer.h"
#import "MapMainLayer.h"
//#import "SpriteMainLayer.h"


@implementation MainGameScene

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


#pragma mark -
#pragma mark self cycle

+ (CCScene *) scene
{
    CCScene * mainScene = [CCScene node];
    
    MainGameScene * mgc = [MainGameScene node];
    
    [mainScene addChild:mgc];
    
    return mainScene;
}

- (void) addLayer
{
    MapMainLayer * mmlayer = [MapMainLayer node];
    [self addChild:mmlayer];
    
    ControlMainLayer * cmLayer = [ControlMainLayer node];
    [self addChild: cmLayer];
    
}

- (id) init
{
    if(self = [super init])
    {
      
        CCTMXTiledMap* tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"isometric-with-border.tmx"];
		[self addChild:tileMap z:-1 tag:kTileMapLevelDefault];
		
        //设置地图的默认位置
		tileMap.position = CGPointMake(-500, -500);
		
		self.isTouchEnabled = YES;
		
		const int borderSize = 10;
		playableAreaMin = CGPointMake(borderSize, borderSize);
		playableAreaMax = CGPointMake(tileMap.mapSize.width - 1 - borderSize, tileMap.mapSize.height - 1 - borderSize);
    }
    return self;
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
