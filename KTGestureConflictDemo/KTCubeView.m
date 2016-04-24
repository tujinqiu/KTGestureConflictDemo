//
//  KTCubeView.m
//  OV3D
//
//  Created by kevin.tu on 16/4/21.
//  Copyright © 2016年 ov. All rights reserved.
//

#import "KTCubeView.h"

typedef struct KTCubeParam
{
    CGFloat p1;
    CGFloat p2;
    CGFloat p3;
    CGFloat p4;
    CGFloat p5;
    CGFloat p6;
    CGFloat p7;
}KTCubeParam;

static __inline__ KTCubeParam KTCubeParamMake(CGFloat p1, CGFloat p2, CGFloat p3, CGFloat p4, CGFloat p5, CGFloat p6, CGFloat p7)
{
    KTCubeParam param;
    param.p1 = p1;
    param.p2 = p2;
    param.p3 = p3;
    param.p4 = p4;
    param.p5 = p5;
    param.p6 = p6;
    param.p7 = p7;
    
    return param;
}

@interface KTCubeView ()

@property (nonatomic, copy) NSArray *gradientLayers;

@end

@implementation KTCubeView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    if (self = [super initWithFrame:frame])
    {
        [self setupCubeWithColor:color];
    }
    
    return self;
}

- (void)changeColor:(UIColor *)color
{
    for (CAGradientLayer *layer in _gradientLayers)
    {
        layer.colors = @[(__bridge id)color.CGColor, (__bridge id)[UIColor blackColor].CGColor];
    }
}

- (void)setupCubeWithColor:(UIColor *)color;
{
    CGFloat width = self.frame.size.width;
    CAGradientLayer *layer1 = [self addLayerWithColor:color param:KTCubeParamMake(0.0, 0.0, width / 2.0, 0.0, 0.0, 0.0, 0.0)];
    CAGradientLayer *layer2 = [self addLayerWithColor:color param:KTCubeParamMake(0.0, 0.0, -width / 2.0, M_PI, 0.0, 0.0, 0.0)];
    CAGradientLayer *layer3 = [self addLayerWithColor:color param:KTCubeParamMake(-width / 2.0, 0.0, 0.0, -M_PI_2, 0.0, 1.0, 0.0)];
    CAGradientLayer *layer4 = [self addLayerWithColor:color param:KTCubeParamMake(width / 2.0, 0.0, 0.0, M_PI_2, 0.0, 1.0, 0.0)];
    CAGradientLayer *layer5 = [self addLayerWithColor:color param:KTCubeParamMake(0.0, -width / 2.0, 0.0, -M_PI_2, 1.0, 0.0, 0.0)];
    CAGradientLayer *layer6 = [self addLayerWithColor:color param:KTCubeParamMake(0.0, width / 2.0, 0.0, M_PI_2, 1.0, 0.0, 0.0)];
    _gradientLayers = [NSArray arrayWithObjects:layer1, layer2, layer3, layer4, layer5, layer6, nil];
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = -1.0 / 700.0;
    trans = CATransform3DRotate(trans, M_PI / 9.0, 1.0, 0.0, 0.0);
    self.layer.sublayerTransform = trans;
}

- (CAGradientLayer *)addLayerWithColor:(UIColor *)color param:(KTCubeParam)param
{
    CGRect bounds = self.bounds;
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds = CGRectMake(0.0, 0.0, bounds.size.width, bounds.size.height);
    layer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    layer.colors = @[(__bridge id)color.CGColor, (__bridge id)[UIColor blackColor].CGColor];
    layer.locations = @[@0.0, @1.0];
    layer.startPoint = CGPointMake(0.0, 0.0);
    layer.endPoint = CGPointMake(0.0, 1.0);
    CATransform3D transform = CATransform3DMakeTranslation(param.p1, param.p2, param.p3);
    transform = CATransform3DRotate(transform, param.p4, param.p5, param.p6, param.p7);
    layer.transform = transform;
    [self.layer addSublayer:layer];
    
    return layer;
}

@end
