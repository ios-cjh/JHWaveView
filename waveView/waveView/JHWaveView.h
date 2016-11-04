//
//  JHWaveView.h
//  waveView
//
//  Created by cjj on 16/11/2.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHWaveView : UIView


@property (assign, nonatomic) CGFloat angularSpeed;
@property (assign, nonatomic) CGFloat waveSpeed;
@property (assign, nonatomic) NSTimeInterval waveTime;
@property (strong, nonatomic) UIColor *waveColor;


+(instancetype)addToView:(UIView *)view withFrame:(CGRect)frame;

-(BOOL)wave;
@end
