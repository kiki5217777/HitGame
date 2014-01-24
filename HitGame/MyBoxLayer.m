//
//  MyBoxLayer.m
//  HitGame
//
//  Created by kiki Huang on 14/1/20.
//  Copyright 2014年 kiki Huang. All rights reserved.
//

#import "MyBoxLayer.h"


@implementation MyBoxLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MyBoxLayer *layer = [MyBoxLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id)init{
    if (self = [super init]) {
        
        delegate = (AppController *)[[UIApplication sharedApplication] delegate];
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        tap.numberOfTapsRequired = 1;
        
    }
    return self;
}

-(void)onEnterTransitionDidFinish{
    [super onEnterTransitionDidFinish];
    
    [delegate.navController.view addGestureRecognizer:tap];
    
    [self disableTapped];
    
    winSize = [[CCDirector sharedDirector]winSize];
    posX = winSize.width/2;
    pos1X = winSize.width+20;
    pos2X = -winSize.width/2;
    posY = winSize.height/2-30;
    pos1Y = winSize.height-55;
    
//    NSLog(@"onEnterTransitionDidFinish");
    hitBtn = [[CCSprite alloc]initWithFile:@"HITME.jpeg"];
    hitBtn.position = ccp(100, 100);
    [self addChild:hitBtn];
    
    nextBtn = [[CCSprite alloc]initWithFile:@"NEXT.jpeg"];
    nextBtn.position = ccp(250, 100);
    [self addChild:nextBtn];
    
    pauseBtn = [[CCSprite alloc]initWithFile:@"PAUSE.jpeg"];
    pauseBtn.scale = 0.35;
    pauseBtn.position = ccp(winSize.width-40, pos1Y);
    [self addChild:pauseBtn];
    
    
    
    [self randomBoxNumber];
    box = [[Box alloc]init];
    [box createSprite:random];
    box.position = ccp(posX,posY);
    [self addChild:box];
    box.visible = NO;
    
    spriteCount = box.spriteNum.count;
//    NSLog(@"%d",spriteCount);
    
    [self randomBoxNumber];
    box1 = [[Box alloc]init];
    [box1 createSprite:random];
    box1.position = ccp(pos1X, posY);
    [self addChild:box1];
    box1.visible = NO;
    
    errorSprite = [[CCSprite alloc]initWithFile:@"ANGRY.jpeg"];
    errorSprite.position = ccp(pos2X, posY);
    [self addChild:errorSprite];
    
    winSizeX=winSize.width;
    
    optionImage = [[OptionImage alloc]initWithFile:@"ErrorBackground.jpg"];
//    NSLog(@"errorimg %f",errorImage.contentSize.height);
    
    optionImage.position = ccp(posX , winSizeX+optionImage.contentSize.height);
    [self addChild:optionImage];
//    gameTime = 0.0;
    
    timerLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%.2f",gameTime] fontName:@"Marker Felt" fontSize:30];
    timerLabel.position =  ccp( posX , pos1Y);
    [self addChild: timerLabel];
    timerLabel.visible = NO;
    
    countNumber = missionNumber;
    
    numLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",countNumber] fontName:@"Marker Felt" fontSize:28];
    numLabel.position = ccp(30, pos1Y);
    [self addChild:numLabel];
    numLabel.visible = YES;
    
    [self countDownAnimation];
    
}
-(void)onExit{
    
    [delegate.navController.view removeGestureRecognizer:tap];
    [self removeAllChildrenWithCleanup:YES];
    [self unschedule:@selector(timerUpdate:)];
    [box releaseAllObject];
    [box1 releaseAllObject];
    [optionImage releaseAllObject];
    
    [pauseBtn release];
    [hitBtn release];
    [nextBtn release];
    [errorSprite release];
    [countNum1 release];
    [countNum2 release];
    [countNum3 release];
    [box release];
    [box1 release];
    [optionImage release];
    [tap release];
    
    pauseBtn = nil;
    hitBtn = nil;
    nextBtn = nil;
    errorSprite = nil;
    countNum1 = nil;
    countNum2 = nil;
    countNum3 = nil;
    box = nil;
    box1 = nil;
    tap = nil;
    optionImage = nil;
    [super onExit];
}
-(void)dealloc{
    
//    NSLog(@"dealloc");
    [delegate.navController.view removeGestureRecognizer:tap];
    [self removeAllChildrenWithCleanup:YES];
    [self unschedule:@selector(timerUpdate:)];
    [box releaseAllObject];
    [box1 releaseAllObject];
    [optionImage releaseAllObject];
    
    [pauseBtn release];
    [hitBtn release];
    [nextBtn release];
    [errorSprite release];
    [countNum1 release];
    [countNum2 release];
    [countNum3 release];
    [box release];
    [box1 release];
    [optionImage release];
    [tap release];
    
    pauseBtn = nil;
    hitBtn = nil;
    nextBtn = nil;
    errorSprite = nil;
    countNum1 = nil;
    countNum2 = nil;
    countNum3 = nil;
    box = nil;
    box1 = nil;
    tap = nil;
    optionImage = nil;
    [super dealloc];
}

-(void)timerUpdate:(ccTime)dt{
    
    if (!disableGameTimer) {
        gameTime +=dt;
        [timerLabel setString:[NSString stringWithFormat:@"%.2f",gameTime]];
        
    }else{
        [self unschedule:@selector(timerUpdate:)];
    }
}
-(void)randomBoxNumber{
    random = arc4random()%6+1;
}
-(void)countDownAnimation{
    
    countNum1 = [[CCSprite alloc]initWithFile:@"Num3.jpeg"];
    countNum1.position = ccp(posX , winSize.height/2);
    [self addChild:countNum1];

    id actionEnlarge = [CCScaleTo actionWithDuration:0.5 scale:2];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:0.0];
//    id actionRemove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSelfFromScene)];
    id actionFinished = [CCCallFuncN actionWithTarget:self selector:@selector(countToTwo)];
    [countNum1 runAction:[CCSequence actions:actionEnlarge,fadeOut,actionFinished,nil]];
    
}
-(void)countToTwo{
    
    countNum2 = [[CCSprite alloc]initWithFile:@"Num2.jpeg"];
    countNum2.position = ccp(posX, winSize.height/2);
    [self addChild:countNum2];
    
    id actionEnlarge = [CCScaleTo actionWithDuration:0.5 scale:2];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:0.0];
//    id actionRemove = [CCCallFuncN actionWithTarget:self selector:@selector(removeSelfFromScene)];
    id actionFinished = [CCCallFuncN actionWithTarget:self selector:@selector(countToOne)];
    [countNum2 runAction:[CCSequence actions:actionEnlarge,fadeOut,actionFinished,nil]];

}
-(void)countToOne{
    
    countNum3= [[CCSprite alloc]initWithFile:@"Num1.jpeg"];
    countNum3.position = ccp(posX, winSize.height/2);
    [self addChild:countNum3];
    
    id actionEnlarge = [CCScaleTo actionWithDuration:0.5 scale:2];
    id actionChangeToScene = [CCCallFuncN actionWithTarget:self selector:@selector(sceneAnimation)];
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.5 opacity:0.0];
    id actionRemove = [CCCallFuncN actionWithTarget:self selector:@selector(removeObjectsFromScene)];
    [countNum3 runAction:[CCSequence actions:actionEnlarge,fadeOut,actionRemove,actionChangeToScene, nil]];
}

-(void)removeObjectsFromScene{
    
    [self removeChild:countNum1 cleanup:YES];
    [self removeChild:countNum2 cleanup:YES];
    [self removeChild:countNum3 cleanup:YES];
    
}
-(void)resetScene{
    
    [optionImage removeChildren];
    
    [self disableTapped];
    
    box.visible = NO;
    [self randomBoxNumber];
    [box createSprite:random];
    box.position = ccp(posX,posY);
    
    spriteCount = box.spriteNum.count;
//    NSLog(@"%d",spriteCount);
    
    box1.visible = NO;
    [self randomBoxNumber];
    [box1 createSprite:random];
    box1.position = ccp(pos1X, posY);
    
    countNumber=missionNumber;
    [numLabel setString:[NSString stringWithFormat:@"%d",countNumber]];
    numLabel.visible = YES;
//    NSLog(@"%d",[box1.spriteNum count]);
    [self countDownAnimation];

}
-(void)sceneAnimation{
    
    box.visible = YES;
    box1.visible = YES;
    
    
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:0.05 opacity:0.0];
    CCFadeTo *fadeIn = [CCFadeTo actionWithDuration:0.05 opacity:1.0];
    id actionFinished = [CCCallFuncN actionWithTarget:self selector:@selector(enableTapped)];
    [box runAction:[CCSequence actions:fadeOut,fadeIn, nil]];
    [box1 runAction:[CCSequence actions:fadeOut,fadeIn,actionFinished, nil]];
    
}
-(void)disableTapped{
    
    disableHitBtnTapped = YES;
    disableNextBtnTapped = YES;
    disableGameTimer = YES;
    disableGamePause = YES;
}
-(void)enableTapped{
    
    disableHitBtnTapped = NO;
    disableNextBtnTapped = NO;
    disableGameTimer = NO;
    disableGamePause = NO;
    
    gameTime = 0.0;
    [self schedule:@selector(timerUpdate:) interval:0.01];
    timerLabel.visible = YES;
    
}

-(void)handleTap:(UITapGestureRecognizer *)recognizer{
    
    CGPoint touchLocation = [recognizer locationInView:recognizer.view];
    touchLocation = [[CCDirector sharedDirector] convertToGL:touchLocation];
    
    if (CGRectContainsPoint(hitBtn.boundingBox, touchLocation) && !disableHitBtnTapped) {
//        NSLog(@"hit");
        [self hitSpriteHandler];
        
    }else if(CGRectContainsPoint(nextBtn.boundingBox, touchLocation) && !disableNextBtnTapped){
//        NSLog(@"next");
        [self nextSpriteMovement];
    }else if (CGRectContainsPoint(optionImage.playAgainBtn.boundingBox, touchLocation)){
//        NSLog(@"again");
        [self playAgain];
        
    }else if (CGRectContainsPoint(optionImage.exitBtn.boundingBox, touchLocation)){
//        NSLog(@"exit");
        [[CCDirector sharedDirector]replaceScene:[HelloWorldLayer scene]];
    }else if (CGRectContainsPoint(pauseBtn.boundingBox, touchLocation) && !disableGamePause){
        [self gamePuase];
    }
}

-(void)hitSpriteHandler{
//    NSLog(@"hitsprite count %d",spriteCount);
    if (spriteCount>0) {
    
        if (box.position.x == posX) {
            CCSprite *hitsprite = [box.spriteNum objectAtIndex:0];
//            NSLog(@"hit posX: %f posY %f",hitsprite.position.x,hitsprite.position.y);
            [self HitAnimation:hitsprite];
            
        }
        else{
            CCSprite *hitsprite = [box1.spriteNum objectAtIndex:0];
//            NSLog(@"hit posX: %f posY %f",hitsprite.position.x,hitsprite.position.y);
            [self HitAnimation:hitsprite];
        }
    
    }else{
//        NSLog(@"hit error");
        disableHitBtnTapped = YES;
        disableNextBtnTapped = YES;
        disableGameTimer = YES;
        if (box.position.x == posX) {
//            NSLog(@" box %d",[box.spriteNum count]);
            [self HitErrorAnimation:box.headSprite];
           
            
        }
        else{
//            NSLog(@" box1 %d",[box1.spriteNum count]);
            [self HitErrorAnimation:box1.headSprite];
            
        }
        
        id actionMoveErrorSprite = [CCMoveTo actionWithDuration:0.05 position:ccp(posX, posY)];
        id actionMoveErrorDown = [CCCallFuncN actionWithTarget:self selector:@selector(errorSpriteMoveFinished)];
        [errorSprite runAction:[CCSequence actions:actionMoveErrorSprite,actionMoveErrorDown, nil]];
    
    }

    
}
-(void)HitAnimation:(CCSprite *)sprite{
    
    id actionMove = [CCMoveBy actionWithDuration:0.05 position:ccp(-winSizeX,0)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished)];
    
    [sprite runAction:[CCSequence actions:actionMove ,actionMoveDone,nil]];
    sprite =nil;
}

-(void)HitErrorAnimation:(CCSprite *)sprite{
    
    id actionMove = [CCMoveBy actionWithDuration:0.05 position:ccp(-winSizeX,0)];
    [sprite runAction:actionMove];
}

-(void)NextAnimation:(CCSprite *)sprite{
//    countNumber--;
//    NSLog(@"countNumber %d",countNumber);
//    [numLabel setString:[NSString stringWithFormat:@"%d",countNumber]];
    
    id actionMove = [CCMoveBy actionWithDuration:0.05 position:ccp(-winSizeX,0)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self selector:@selector(headSpriteMoveFinished)];
    [sprite runAction:[CCSequence actions:actionMove,actionMoveDone, nil]];
}

-(void)NextErrorAnimation:(CCSprite *)sprite{
    id actionJumpUp = [CCMoveBy actionWithDuration:0.05 position:ccp(0,jumpAnimateHeihgt)];
    id actionJumpDown = [CCMoveBy actionWithDuration:0.05 position:ccp(0,-jumpAnimateHeihgt)];
    [sprite runAction:[CCSequence actions:actionJumpUp,actionJumpDown, nil]];
}

-(void)nextSpriteMovement{
    if (spriteCount==0) {
        
        if (box.position.x == posX) {
//            NSLog(@" ***box %d",[box.spriteNum count]);
            [self NextAnimation:box.headSprite];
        }
        else{
//            NSLog(@" ***box1 %d",[box1.spriteNum count]);
            [self NextAnimation:box1.headSprite];
        }
        
    }else{
//        NSLog(@"next error");
        if (box.position.x == posX) {
            [self NextErrorAnimation:box.headSprite];
        }else{
            [self NextErrorAnimation:box1.headSprite];
        }
    }
}
-(void)headSpriteMoveFinished{
    countNumber--;
    NSLog(@"countNumber %d",countNumber);
    [numLabel setString:[NSString stringWithFormat:@"%d",countNumber]];
    
    if (countNumber>1) {
        
        
        
        if (box.position.x == posX) {
            
            
            
            box1.position = ccp(posX, posY);
            spriteCount = [box1.spriteNum count];
            
            
//            if (countNumber>=2) {
                [box removeChildren];
                [self randomBoxNumber];
                [box createSprite:random];
                box.position = ccp(pos1X, posY);
//            }
            
        }else{
            //        NSLog(@"box1 ");
            
            box.position = ccp(posX, posY);
            spriteCount = [box.spriteNum count];
            
//            if (countNumber>=2) {
                [box1 removeChildren];
                [self randomBoxNumber];
                [box1 createSprite:random];
                box1.position = ccp(pos1X, posY);
//            }
            
        }
    }
    if(countNumber ==1){
        if (box.position.x==posX) {
            box.visible = NO;
            
            box1.position = ccp(posX, posY);
            spriteCount = [box1.spriteNum count];
            
            
        }else{
            box1.visible = NO;
            
            box.position = ccp(posX, posY);
            spriteCount = [box.spriteNum count];
            
            
        }
        
    }
    if (countNumber<=0) {
        [self unschedule:@selector(timerUpdate)];
        [optionImage addResultTimeLabel:gameTime];
        [self isFinishMission];
    }
    
    
    
    
    
}
-(void)spriteMoveFinished{
    
    if (box.position.x == posX) {
        if ([box.spriteNum count]>0) {
            CCSprite *spirte=[box.spriteNum objectAtIndex:0] ;
            [box removeChild:spirte cleanup:YES];
            [box.spriteNum removeObject:spirte];
            spriteCount = [box.spriteNum count];
            spirte = nil;
            //        NSLog(@"box rest %d",spriteCount);
            
            for (CCSprite *spirte in box.spriteNum) {
                id actionDrop = [CCMoveBy actionWithDuration:0.05 position:ccp(0,-spirte.contentSize.height)];
                [spirte runAction:actionDrop];
                spirte = nil;
            }
            id actionDrop = [CCMoveBy actionWithDuration:0.05 position:ccp(0,-spriteHeight)];
            [box.headSprite runAction:actionDrop];

        }
           }
    else{
        if ([box1.spriteNum count]>0) {
            CCSprite *spirte=[box1.spriteNum objectAtIndex:0];
            [box1 removeChild:spirte cleanup:YES];
            [box1.spriteNum removeObject:spirte];
            spriteCount = [box1.spriteNum count];
            spirte = nil;
            //        NSLog(@"box1 rest%d",spriteCount);
            
            for (CCSprite *spirte in box1.spriteNum) {
                id actionDrop = [CCMoveBy actionWithDuration:0.05 position:ccp(0,-spirte.contentSize.height)];
                [spirte runAction:actionDrop];
                spirte = nil;
            }
            id actionDrop = [CCMoveBy actionWithDuration:0.05 position:ccp(0,-spriteHeight)];
            [box1.headSprite runAction:actionDrop];

        }
    }
    
}
-(void)errorSpriteMoveFinished{
    [self schedule:@selector(showOptionImage:) interval:1.0 repeat:1 delay:0.0];
}
-(void)showOptionImage:(ccTime *)dt{
    timerLabel.visible = NO;
    numLabel.visible = NO;
    if (disableGamePause) {
        [optionImage addBtnWithImageName:@"BACK.jpeg"];
    }else
        [optionImage addBtnWithImageName:@"AGAIN.jpeg"];
    
    id actionShowErrorImg = [CCMoveTo actionWithDuration:0.5 position:ccp(posX, winSize.height/2)];
    
    id actionRestScene = [CCCallFuncN actionWithTarget:self selector:@selector(cleanUpScene)];
    [optionImage runAction:[CCSequence actions:actionRestScene,actionShowErrorImg, nil]];
    
}
-(void)cleanUpScene{
    
    if (!disableGamePause) {
        
        [box removeChildren];
        [box1 removeChildren];
        errorSprite.position = ccp(pos2X, posY);
    }else{
        box.visible = NO;
        box1.visible = NO;
    }
}
-(void)playAgain{
    CCFadeTo *fadeOut = [CCFadeTo actionWithDuration:1.0 opacity:255];
    
    id actionMoveErrorImg = [CCMoveTo actionWithDuration:0.5 position:ccp(posX, winSize.height+optionImage.contentSize.height)];
    id actionMoveErrorDown = [CCCallFuncN actionWithTarget:self selector:@selector(resetScene)];
    id actionSceneAnimation = [CCCallFuncN actionWithTarget:self selector:@selector(sceneAnimation)];
    
    if (disableGamePause) {
        [optionImage runAction:[CCSequence actions:fadeOut,actionMoveErrorImg,actionSceneAnimation, nil]];
        
    }else{
        [optionImage runAction:[CCSequence actions:fadeOut,actionMoveErrorImg,actionMoveErrorDown, nil]];
    }
    
}
-(void)gamePuase{
    [self disableTapped];
    [self unschedule:@selector(timerUpdate)];
    [self errorSpriteMoveFinished];
}
-(void)isFinishMission{
    NSLog(@"finish");
    [self errorSpriteMoveFinished];

}
@end
