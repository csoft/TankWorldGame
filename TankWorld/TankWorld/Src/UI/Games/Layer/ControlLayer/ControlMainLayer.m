//
//  ControlMainLayer.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "ControlMainLayer.h"
#import "TankWorldConfig.h"

@interface ControlMainLayer (PrivateMethods)
-(void) addFireButton;
-(void) addJoystick;
@end


@implementation ControlMainLayer
@synthesize controllerLayerDelegate = _controllerLayerDelegate;

-(id) init
{
	if ((self = [super init]))
	{
		[self addFireButton];
		[self addJoystick];
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) dealloc
{
    _controllerLayerDelegate = nil;
	[super dealloc];
}

-(void) addFireButton
{
	float buttonRadius = 50;
	CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
	fireButton = [SneakyButton button];
	fireButton.isHoldable = YES;
	
	SneakyButtonSkinnedBase* skinFireButton = [SneakyButtonSkinnedBase skinnedButton];
	skinFireButton.position = CGPointMake(screenSize.width - buttonRadius * 1.5f, buttonRadius * 1.5f);
	skinFireButton.defaultSprite = [CCSprite spriteWithFile:@"fire.png"];//[CCSprite spriteWithSpriteFrameName:@"button-default.png"];
	skinFireButton.pressSprite = [CCSprite spriteWithFile:@"fire.png"];//[CCSprite spriteWithSpriteFrameName:@"button-pressed.png"];
	skinFireButton.button = fireButton;
	[self addChild:skinFireButton];
}

-(void) addJoystick
{
	float stickRadius = 50;
    
	joystick = [SneakyJoystick joystickWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
	joystick.autoCenter = YES;
	
	// Now with fewer directions
	joystick.isDPad = YES;
	joystick.numberOfDirections = 8;
	
	SneakyJoystickSkinnedBase* skinStick = [SneakyJoystickSkinnedBase skinnedJoystick];
	skinStick.position = CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
	skinStick.backgroundSprite = [CCSprite spriteWithFile:@"fire.png"];//[CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
	skinStick.backgroundSprite.color = ccMAGENTA;
	skinStick.thumbSprite = [CCSprite spriteWithFile:@"fire.png"];//[CCSprite spriteWithSpriteFrameName:@"button-disabled.png"];
	skinStick.thumbSprite.scale = 0.5f;
	skinStick.joystick = joystick;
	[self addChild:skinStick];
}

-(void) update:(ccTime)delta
{
	totalTime += delta;
    
	// Continuous fire
	if (fireButton.active && totalTime > nextShotTime)
	{
		nextShotTime = totalTime + 0.5f;
        
        [_controllerLayerDelegate tankFireWithTankFireType:kTankFireTypeDefault];
		//GameScene* game = [GameScene sharedGameScene];
		//[game shootBulletFromShip:[game defaultShip]];
	}
	
	// Allow faster shooting by quickly tapping the fire button.
	if (fireButton.active == NO)
	{
		nextShotTime = 0;
	}
	// Moving the ship with the thumbstick.
	//GameScene* game = [GameScene sharedGameScene];
	//Ship* ship = [game defaultShip];
	
	CGPoint velocity = ccpMult(joystick.velocity, 200);
	if (velocity.x != 0 && velocity.y != 0)
	{
        CCLOG(@"%@", @"_controllerLayerDelegate tankMoveWithAngle:joystick.degrees");
        [_controllerLayerDelegate tankMoveWithAngle:changeDegreesToAngle(joystick.degrees)];
		//ship.position = CGPointMake(ship.position.x + velocity.x * delta, ship.position.y + velocity.y * delta);
	}
    
}

@end
