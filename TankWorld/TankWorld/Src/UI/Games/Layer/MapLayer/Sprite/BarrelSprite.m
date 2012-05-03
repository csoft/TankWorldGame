//
//  BarrelSprite.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright 2012年 C-SOFT. All rights reserved.
//

#import "BarrelSprite.h"
#import "BarrelModel.h"

@implementation BarrelSprite
@synthesize barrelModel = _barrelModel;

+ (BarrelSprite *)barrelSpriteWithBarrelModel:(BarrelModel *)aBarrelModel
{
   BarrelSprite *bs = [[BarrelSprite alloc] initWithFile:@"worldmap.jpg" 
                                                    rect:CGRectMake(0, 0, 20, 20)];
    bs.barrelModel = aBarrelModel;
    
    return [bs autorelease];
}

@end
