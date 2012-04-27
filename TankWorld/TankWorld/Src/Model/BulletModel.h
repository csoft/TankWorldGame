//
//  BulletModel.h
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-15.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BulletModel : NSObject
{
    NSInteger   _harmValue;//此炮弹的杀伤力,负值代表是维修车
    
    //此炮弹的生命值，代表子弹能打出多远，当子弹打中障碍物或者对方或者子弹移动的距离大于等于这个生命值后，自曝值为0，此值大于视野
    NSUInteger  _liftValue;
    
    CGPoint     _position;//炮弹当前的位置，是相对位置
    
    CGFloat     _angle;//此炮弹移动的角度
    
    CGFloat     _moveSpeed;//此炮弹移动的速度
    
    CGSize      _bulletSize;//此炮弹的大小
}
@property(nonatomic,assign)NSInteger    harmValue;
@property(nonatomic,assign)NSUInteger    liftValue;
@property(nonatomic,assign)CGPoint      position;
@property(nonatomic,assign)CGFloat      angle;
@property(nonatomic,assign)CGFloat      moveSpeed;
@property(nonatomic,assign)CGSize       bulletSize;


@end
