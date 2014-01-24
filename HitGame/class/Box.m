//
//  Box.m
//  HitGame
//
//  Created by kiki Huang on 14/1/20.
//  Copyright (c) 2014年 kiki Huang. All rights reserved.
//

#import "Box.h"

@implementation Box

-(id)init{

    if (self = [super init]) {
        self.spriteNum = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)createSprite:(int)count{
    self.headSprite = [[CCSprite alloc]initWithFile:@"取消叫車按鈕@2x.png"];
    
    for (int i=0; i<count; i++) {
        
        CCSprite *sprite=[[CCSprite alloc]initWithFile:@"blueButton@2x.png"];
        [self.spriteNum addObject:sprite];
        
        sprite.position = CGPointMake(0, i*sprite.contentSize.height);
        [self addChild:sprite];
        
        sprite=nil;
    }
    
    self.headSprite.position = CGPointMake(0, count*spriteHeight);
    [self addChild:self.headSprite];
}
-(void)removeChildren{
    [self removeAllChildrenWithCleanup:YES];
    [self.spriteNum removeAllObjects];
//    NSLog(@"box spriteNum %d",[self.spriteNum count]);
    
}
-(void)releaseAllObject{
    
    [self removeAllChildrenWithCleanup:YES];
    [self.spriteNum removeAllObjects];
    self.spriteNum = nil;
    self.headSprite = nil;
    
}
@end
