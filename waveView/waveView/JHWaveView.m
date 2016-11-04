//
//  JHWaveView.m
//  waveView
//
//  Created by cjj on 16/11/2.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "JHWaveView.h"

@interface JHWaveView()

// x的偏移量
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, strong) CAShapeLayer *waveShapeLayer;

// 定时器
@property(nonatomic, strong) CADisplayLink *waveDisplayLink;

@end

@implementation JHWaveView
+(instancetype)addToView:(UIView *)view withFrame:(CGRect)frame
{
    JHWaveView *waveView = [[self alloc] initWithFrame:frame];

//    waveView.backgroundColor = [UIColor yellowColor];
    [view addSubview:waveView];
    return waveView;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        // 设置基本属性
        [self setUpBasic];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置基本属性
        [self setUpBasic];
    }
    return self;
}
// 设置基本属性
-(void)setUpBasic
{
//    @property (assign, nonatomic) CGFloat angularSpeed;
//    @property (assign, nonatomic) CGFloat waveSpeed;
//    @property (assign, nonatomic) NSTimeInterval waveTime;
//    @property (strong, nonatomic) UIColor *waveColor;
    self.angularSpeed = 2.f;
    self.waveSpeed = 9.0f;
    self.waveColor = [UIColor whiteColor];
}

-(BOOL)wave
{
    self.waveShapeLayer = [CAShapeLayer layer];
    self.waveShapeLayer.fillColor = self.waveColor.CGColor;
    [self.layer addSublayer:self.waveShapeLayer];
    
    self.waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(currentWave)];
    
    [self.waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return YES;
}

-(void)currentWave
{
    self.offsetX = self.offsetX - self.waveSpeed;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, height);
    
    CGFloat y = 0.f;
    
//    正弦型函数解析式：y=Asin(ωx+φ)+b
//    各常数值对函数图像的影响：
//    φ：决定波形与X轴位置关系或横向移动距离（左加右减）
//    ω：决定周期（最小正周期T=2π/∣ω∣）
//    A：决定峰值（即纵向拉伸压缩的倍数）
//    b：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
    for (CGFloat x = 0.f; x <= width; x++) {
        y = height * sin(0.01 * (self.angularSpeed * x + self.offsetX));
        
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    CGPathAddLineToPoint(path, NULL, width, height);
    CGPathAddLineToPoint(path, NULL, 0, height);
    CGPathCloseSubpath(path);
    self.waveShapeLayer.path = path;
    CGPathRelease(path);
}

@end







