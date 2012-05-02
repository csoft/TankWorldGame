//
//  BulletModelManager.m
//  TankWorld
//
//  Created by 学宝 陈 on 12-4-27.
//  Copyright (c) 2012年 C-SOFT. All rights reserved.
//

#import "BulletModelManager.h"
#import "BulletModel.h"
#import "DDLog.h"

@implementation BulletModelManager


+ (BulletModelManager *)shareBulletModelManager
{
    static BulletModelManager * shareManager = nil;
    
    if(shareManager){return shareManager;}
    
    shareManager = [[BulletModelManager alloc] init];
    
    return shareManager;

}

//判断子弹是否能移动dx，dy的偏移量
- (BOOL) canMoveForBulletModel:(BulletModel *)aBulletModel dx:(CGFloat)dx dy:(CGFloat)dy
{
    //TODO: 判断坦克是否能从原来的位置移动指定偏移量到达目标位置
    
    return YES;
}

//炮弹在指定位置爆炸
- (BOOL) explodeForBulletModel:(BulletModel *)aBulletModel x:(CGFloat)x y:(CGFloat)y
{
    //TODO: 改变指定的地图的值
    
    return YES;
}

//移动炮弹
- (BOOL)moveForBulletModel:(BulletModel *)aBulletModel
{
    if(aBulletModel.liftValue > 0)
    {//炮弹的生命值大于0，可以继续移动
        
        //计算炮弹在下一帧将移动的距离
        CGFloat canMoveLen = aBulletModel.liftValue - aBulletModel.moveSpeed;
        if(canMoveLen >= 0)
        {//炮弹下一帧可以移动的距离大于0，说明可以移动指定速度的偏移量
            
            //分别计算x，y坐标的偏移量
            CGFloat dx = aBulletModel.moveSpeed*cos(aBulletModel.angle);
            CGFloat dy = aBulletModel.moveSpeed*sin(aBulletModel.angle);
            
            //计算原来的位置到偏移量之间的障碍物，是否可以通过
            BOOL isCanMove = [self canMoveForBulletModel:aBulletModel dx:dx dy:dy];

            //障碍物判断过后
            if(isCanMove)
            {//没有障碍物
                
                DDLogVerbose(@"moveForBulletModel--angle:%0.f old:(%.0f, %.0f) moved: (%.0f, %.0f)", 
                             aBulletModel.angle,aBulletModel.position.x,aBulletModel.position.y,dx,dy); 
                //原来的位置加上偏移量 得到目标位置
                aBulletModel.position = CGPointMake(aBulletModel.position.x+dx, aBulletModel.position.y+dy);
                
                //把炮弹的生命值减少移动的距离
                aBulletModel.liftValue -= aBulletModel.moveSpeed;
                
                return YES;
            }
            else
            {//有障碍物，不可以移动，直接使炮弹生命值为0，是炮弹爆炸
                
                aBulletModel.liftValue = 0;
                
                //如果障碍物是可以打掉的，在这里扩展
                [self explodeForBulletModel:aBulletModel x:aBulletModel.position.x+dx y:aBulletModel.position.y+dy];
                
                
                //操作完后返回不可移动标志
                return NO;
            }
            
            
        }
        else
        {//炮弹下一帧不能移动一个帧的速度距离了，只能移动一小段距离
            
            //分别计算x，y坐标的偏移量
            CGFloat dx = canMoveLen*cos(aBulletModel.angle);
            CGFloat dy = canMoveLen*sin(aBulletModel.angle);
            
            //计算原来的位置到偏移量之间的障碍物，是否可以通过
            BOOL isCanMove = [self canMoveForBulletModel:aBulletModel dx:dx dy:dy];
            
            //障碍物判断过后
            if(isCanMove)
            {//没有障碍物
                
                DDLogVerbose(@"moveForBulletModel--angle:%0.f old:(%.0f, %.0f) moved: (%.0f, %.0f)", 
                             aBulletModel.angle,aBulletModel.position.x,aBulletModel.position.y,dx,dy); 
                
                //原来的位置加上偏移量 得到目标位置
                aBulletModel.position = CGPointMake(aBulletModel.position.x+dx, aBulletModel.position.y+dy);
                
                //移动后，炮弹的生命值肯定为0
                aBulletModel.liftValue = 0;
                return YES;
            }
            else
            {//有障碍物，不可以移动，直接使炮弹生命值为0，是炮弹爆炸
                
                aBulletModel.liftValue = 0;
                
                //如果障碍物是可以打掉的，在这里扩展
                [self explodeForBulletModel:aBulletModel x:aBulletModel.position.x+dx y:aBulletModel.position.y+dy];
                
                
                //操作完后返回不可移动标志
                return NO;
            }
            
        }

    }
    else
    {//炮弹的生命值小于0，不可以移动
        aBulletModel.liftValue = 0;
        return NO;
    }
        
    return NO;
}

@end
