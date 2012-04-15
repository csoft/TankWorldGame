//
//  RadarModel.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadarModel : NSObject
{
    CGFloat         _fieldOfView;//此雷达的可视范围半径，以所属的坦克为圆中心点
    
}
@property(nonatomic,assign)CGFloat         fieldOfView;

@end
