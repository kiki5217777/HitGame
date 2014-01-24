//
//  Box.h
//  HitGame
//
//  Created by kiki Huang on 14/1/20.
//  Copyright (c) 2014年 kiki Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Constants.h"

@interface Box : CCSprite{
    
}
@property (retain,nonatomic) NSMutableArray *spriteNum;
@property (retain,nonatomic) CCSprite *headSprite;
-(void)createSprite:(int)count;
-(void)removeChildren;
-(void)releaseAllObject;
@end
