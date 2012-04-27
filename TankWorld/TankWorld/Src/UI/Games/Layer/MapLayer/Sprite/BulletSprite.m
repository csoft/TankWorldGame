//
//  BulletSprite.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "BulletSprite.h"
#import "TankWorldConfig.h"

@implementation BulletSprite
@synthesize bulletModel = _bulletModel;
//
//- (id)init
//{
//    if(self = [super init])
//    {
//        [self schedule:@selector(updateTheBullet:) interval:SPRITE_UPDATE_TIME]
//    }
//    
//    return self;
//}

- (void)dealloc
{
    [_bulletModel release];
    [super dealloc];
}


//- (void) updateTheBullet:(ccTime)time
//{
//    
//}



@end
