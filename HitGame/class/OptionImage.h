//
//  ErrorImage.h
//  HitGame
//
//  Created by kiki Huang on 14/1/22.
//  Copyright 2014年 kiki Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface OptionImage : CCSprite {
    
}
@property (strong,nonatomic)CCSprite *playAgainBtn;
@property (strong,nonatomic)CCSprite *exitBtn;
@property (strong,nonatomic)CCLabelTTF *resultTime;
-(void)addBtnWithImageName:(NSString *)name;
-(void)addResultTimeLabel:(CGFloat)time;
-(void)removeChildren;
-(void)releaseAllObject;
@end
