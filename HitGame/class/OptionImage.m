//
//  ErrorImage.m
//  HitGame
//
//  Created by kiki Huang on 14/1/22.
//  Copyright 2014年 kiki Huang. All rights reserved.
//

#import "OptionImage.h"


@implementation OptionImage

-(id)init{
    
    if (self = [super init]) {
        
    }
    return self;
}
-(void)addBtnWithImageName:(NSString *)name{
    //modified 2014.02.05
    [self removeAllChildrenWithCleanup:YES];
    self.playAgainBtn = nil;
    self.exitBtn = nil;
    
    self.playAgainBtn = [[CCSprite alloc]initWithFile:name];
    self.playAgainBtn.position = ccp(self.contentSize.width/2-60, self.contentSize.height/2-90);
    
    [self addChild:self.playAgainBtn];
    
    self.exitBtn = [[CCSprite alloc]initWithFile:@"EXIT.jpeg"];
    self.exitBtn.position = ccp(self.contentSize.width/2+60, self.contentSize.height/2-90);
    [self addChild:self.exitBtn];
}
-(void)addResultTimeLabel:(CGFloat)time{
    self.resultTime = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"結果：%.2f 秒",time] fontName:@"Marker Felt" fontSize:36];
    self.resultTime.position = ccp(self.contentSize.width/2, self.contentSize.height/2+60);
    [self addChild:self.resultTime];
}
-(void)removeChildren{
    [self removeAllChildrenWithCleanup:YES];
}
-(void)releaseAllObject{
    [self removeAllChildrenWithCleanup:YES];
    self.playAgainBtn =nil;
    self.exitBtn=nil;
    
    if (self.resultTime!=nil) {
        self.resultTime = nil;
    }
}
@end
