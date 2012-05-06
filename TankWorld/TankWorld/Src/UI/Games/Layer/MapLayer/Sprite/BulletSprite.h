//
//  BulletSprite.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TankWorldProtocol.h"
#import "TankMapManager.h"

@class BulletModel;
@interface BulletSprite : CCSprite 
{
    BulletModel *       _bulletModel;//炮弹数据实体
    
    id<SpriteDelegate>   _delegate;//精灵委托
    
    CCSprite * _explodeSprite;//爆炸精灵
    
    TankMapManager * mapManager;
}
@property(nonatomic,retain)BulletModel *       bulletModel;
@property(nonatomic,assign)id<SpriteDelegate>   delegate;
@property(nonatomic,retain)CCSprite * explodeSprite;

+ (BulletSprite *)bulletSpriteWithBulletModel:(BulletModel *)aBulletModel;

- (void) fire;

@end
