//
//  KTTableViewCell.m
//  KTGestureConflictDemo
//
//  Created by kevin.tu on 16/4/21.
//  Copyright © 2016年 ovwhkevin0461. All rights reserved.
//

#import "KTTableViewCell.h"
#import "KTCubeView.h"

@interface KTTableViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) KTCubeView *cubeView;
@property (nonatomic, assign) CGPoint prePoint;
@property (nonatomic, assign) CGSize screenSize;

@end

@implementation KTTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.screenSize = [UIScreen mainScreen].bounds.size;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithColor:(UIColor *)color
{
    if (!self.cubeView)
    {
        CGSize size = [UIScreen mainScreen].bounds.size;
        size.height -= 64.0;
        CGRect frame = CGRectMake((size.width - 200.0) / 2.0, (size.height - 200.0) / 2.0, 200.0, 200.0);
        self.cubeView = [[KTCubeView alloc] initWithFrame:frame color:color];
        [self.contentView addSubview:self.cubeView];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.delegate = self;
        [self.contentView addGestureRecognizer:pan];
    }
    else
    {
        [self.cubeView changeColor:color];
    }
}

- (void)handlePan:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:self];
    switch (pan.state)
    {
        case UIGestureRecognizerStateBegan:
            self.prePoint = point;
            break;
            
        case UIGestureRecognizerStateChanged:
            [self changeCubeWithPoint:point prePoint:self.prePoint screenSize:self.screenSize];
            self.prePoint = point;
            break;
            
        default:
            break;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]])
    {
        switch (gestureRecognizer.state)
        {
            case UIGestureRecognizerStateBegan:
            {
                UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
                CGPoint velocity = [pan velocityInView:self];
                CGFloat Vx = fabs(velocity.x);
                CGFloat Vy = fabs(velocity.y);
                
                return !(Vx > Vy - 50.0 || Vy < 400.0 || Vx > 500.0);
            }
                break;
                
            case UIGestureRecognizerStateChanged:
                return NO;
                break;
                
            default:
                break;
        }
    }
    
    return YES;
}

- (void)changeCubeWithPoint:(CGPoint)point prePoint:(CGPoint)prePoint screenSize:(CGSize)screenSize
{
    CGFloat angle = (point.x - prePoint.x) / screenSize.width * 2.0 * M_PI;
    CATransform3D trans = self.cubeView.layer.sublayerTransform;
    self.cubeView.layer.sublayerTransform = CATransform3DRotate(trans, angle, 0.0, 1.0, 0.0);
}

@end
