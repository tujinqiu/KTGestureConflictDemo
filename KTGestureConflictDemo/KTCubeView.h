//
//  KTCubeView.h
//  OV3D
//
//  Created by kevin.tu on 16/4/21.
//  Copyright © 2016年 ov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTCubeView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;
- (void)changeColor:(UIColor *)color;

@end
