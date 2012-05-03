//
//  BulletSprite.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "BulletSprite.h"
#import "TankWorldConfig.h"
#import "BulletModelManager.h"
#import "BulletModel.h"

@implementation BulletSprite
@synthesize bulletModel = _bulletModel;
@synthesize delegate = _delegate;
@synthesize explodeSprite=_explodeSprite;


- (id)init
{
    if(self = [super init])
    {
        _explodeSprite = [[CCSprite alloc]  initWithFile:@"exploBig.png" rect:CGRectMake(0, 0, 40, 40)];
        _explodeSprite.visible = NO;
        
    }
    
    return self;
}

+ (BulletSprite *)bulletSpriteWithBulletModel:(BulletModel *)aBulletModel
{
    BulletSprite * bs = [[BulletSprite alloc] initWithFile:@"bullet.PNG" rect:CGRectMake(0, 0, 16, 16)];
    bs.bulletModel = aBulletModel;
    
    return [bs autorelease];
}


- (void)dealloc
{
    [_bulletModel release];
    [_explodeSprite release];
    [super dealloc];
}

- (void) fire
{
    [self schedule:@selector(updateTheBullet:) interval:SPRITE_UPDATE_TIME];
}

- (void) updateTheBullet:(ccTime)time
{

    [[BulletModelManager shareBulletModelManager] moveForBulletModel:self.bulletModel];
    
    self.position = [self.delegate screenPositionWithTilePosition:self.bulletModel.position];
    
    
    
    if(self.bulletModel.liftValue <= 0)
    {//子弹生命结束，开始爆炸动画
        
        [self unschedule:@selector(updateTheBullet:)];
        
        _explodeSprite.position = self.position;
        self.visible = NO;
        CCAnimation *animation = [CCAnimation animation];
        
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"exploBig.png"];
        for(int i=0; i<14; i++)
        {
            CCSpriteFrame * spriteFrame = [CCSpriteFrame frameWithTexture:texture 
                                                                     rect:CGRectMake(i*40, 0, 40, 40)];
            [animation addFrame:spriteFrame];
        }
        
        
        id action = [CCAnimate actionWithAnimation:animation];
        ((CCAnimate*)action).duration = 0.1f;
        //id callfun = [CCCallFunc actionWithTarget:self selector:@selector(destroyBullet)];
        [self.explodeSprite runAction:[CCSequence actions:[CCShow action], action,[CCDelayTime actionWithDuration:0.2], [CCHide action],nil]];
        
    }
    else
    {//坦克的生命值大于0，可见
        self.visible = YES;
    }
    
}

- (void) destroyBullet
{
    
    //[self.bullet.explodeSprite removeFromParentAndCleanup:YES];
    //[self.bullet removeFromParentAndCleanup:YES];
    //self.tankModel.bullet = nil;
    //self.bullet = nil;
}


@end
