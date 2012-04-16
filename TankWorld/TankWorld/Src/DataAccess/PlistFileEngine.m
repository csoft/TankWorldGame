//
//  PlistFileEngine.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-16.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "PlistFileEngine.h"

@implementation PlistFileEngine


+ (PlistFileEngine *) sharePlistFileEngine
{
    static PlistFileEngine * shareEngin = nil;
    
    if(shareEngin) return shareEngin;
    
    shareEngin = [[PlistFileEngine alloc] init];
    
    return shareEngin;
    
}

@end
