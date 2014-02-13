//
//  MyBoxLayer.h
//  HitGame
//
//  Created by kiki Huang on 14/1/20.
//  Copyright 2014年 kiki Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box.h"
#import "OptionImage.h"
#import "AppDelegate.h"
#import "HelloWorldLayer.h"
#import "Constants.h"
#define missionNumber 3

@interface MyBoxLayer : CCLayer {
    
    AppController *delegate;
    CCSprite *hitBtn,*nextBtn,*pauseBtn,*errorSprite,*countNum1,*countNum2,*countNum3;
    Box *box,*box1;
    OptionImage *optionImage;
    CCLabelTTF *timerLabel,*numLabel;
    int spriteCount,posX,pos1X,pos2X,posY,pos1Y,pos2Y,random,winSizeX,countNumber;
    BOOL disableHitBtnTapped,disableNextBtnTapped,disableGameTimer,disableGamePauseTapped,isPause,disablePlayAgainTapped,disableExitTapped;
    
    CGFloat gameTime;
    CGSize winSize;
    UITapGestureRecognizer *tap;
    NSMutableArray *tapObjectArray;
    
}
+(CCScene *)scene;

@end
