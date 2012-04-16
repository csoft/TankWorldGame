//
//  BarrelSprite.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BarrelModel;
@interface BarrelSprite : CCSprite 
{
    BarrelModel *       _barrelModel;
    
}
@property(nonatomic,retain)BarrelModel *       barrelModel;
@end
