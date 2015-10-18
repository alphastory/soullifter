//
//  BackArrowView.m
//  The Soul Lifter
//
//  Created by Kyle Sebestyen on 9/29/15.
//  Copyright © 2015 Planet Soul. All rights reserved.
//

#import "BackArrowView.h"

@implementation BackArrowView

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextClearRect(ctx, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, rect.size.width, 0);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height/2);
    CGPathAddLineToPoint(path, nil, rect.size.width, rect.size.height);
    
//    CGContextSetFillColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    
    CGContextAddPath(ctx, path);
    
    CGContextStrokePath(ctx);
}

@end
