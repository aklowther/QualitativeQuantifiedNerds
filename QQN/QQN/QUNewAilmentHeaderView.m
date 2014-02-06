//
//  QUNewAilmentHeaderView.m
//  QQN
//
//  Created by Adam Lowther on 2/6/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUNewAilmentHeaderView.h"

@implementation QUNewAilmentHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //// Bezier 2 Drawing
    UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
    [bezier2Path moveToPoint: CGPointMake(15.5, 27.76)];
    [bezier2Path addLineToPoint: CGPointMake(40.5, 27.5)];
    [bezier2Path addLineToPoint: CGPointMake(27.59, 38.5)];
    [bezier2Path addLineToPoint: CGPointMake(15.5, 27.76)];
    [bezier2Path closePath];
    [[UIColor grayColor] setFill];
    [bezier2Path fill];
    [[UIColor blackColor] setStroke];
    bezier2Path.lineWidth = 1;
    [bezier2Path stroke];
    
    
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(51.5, 27.76)];
    [bezierPath addLineToPoint: CGPointMake(76.5, 27.5)];
    [bezierPath addLineToPoint: CGPointMake(63.59, 38.5)];
    [bezierPath addLineToPoint: CGPointMake(51.5, 27.76)];
    [bezierPath closePath];
    [[UIColor grayColor] setFill];
    [bezierPath fill];
    [[UIColor blackColor] setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    
    //// Bezier 3 Drawing
    UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
    [bezier3Path moveToPoint: CGPointMake(87.5, 27.76)];
    [bezier3Path addLineToPoint: CGPointMake(112.5, 27.5)];
    [bezier3Path addLineToPoint: CGPointMake(99.59, 38.5)];
    [bezier3Path addLineToPoint: CGPointMake(87.5, 27.76)];
    [bezier3Path closePath];
    [[UIColor grayColor] setFill];
    [bezier3Path fill];
    [[UIColor blackColor] setStroke];
    bezier3Path.lineWidth = 1;
    [bezier3Path stroke];
    
    
    //// Bezier 4 Drawing
    UIBezierPath* bezier4Path = [UIBezierPath bezierPath];
    [bezier4Path moveToPoint: CGPointMake(123.5, 27.76)];
    [bezier4Path addLineToPoint: CGPointMake(148.5, 27.5)];
    [bezier4Path addLineToPoint: CGPointMake(135.59, 38.5)];
    [bezier4Path addLineToPoint: CGPointMake(123.5, 27.76)];
    [bezier4Path closePath];
    [[UIColor grayColor] setFill];
    [bezier4Path fill];
    [[UIColor blackColor] setStroke];
    bezier4Path.lineWidth = 1;
    [bezier4Path stroke];
    
    
    //// Bezier 5 Drawing
    UIBezierPath* bezier5Path = [UIBezierPath bezierPath];
    [bezier5Path moveToPoint: CGPointMake(160.5, 27.76)];
    [bezier5Path addLineToPoint: CGPointMake(185.5, 27.5)];
    [bezier5Path addLineToPoint: CGPointMake(172.59, 38.5)];
    [bezier5Path addLineToPoint: CGPointMake(160.5, 27.76)];
    [bezier5Path closePath];
    [[UIColor grayColor] setFill];
    [bezier5Path fill];
    [[UIColor blackColor] setStroke];
    bezier5Path.lineWidth = 1;
    [bezier5Path stroke];
    
    
    //// Bezier 6 Drawing
    UIBezierPath* bezier6Path = [UIBezierPath bezierPath];
    [bezier6Path moveToPoint: CGPointMake(196.5, 27.76)];
    [bezier6Path addLineToPoint: CGPointMake(221.5, 27.5)];
    [bezier6Path addLineToPoint: CGPointMake(208.59, 38.5)];
    [bezier6Path addLineToPoint: CGPointMake(196.5, 27.76)];
    [bezier6Path closePath];
    [[UIColor grayColor] setFill];
    [bezier6Path fill];
    [[UIColor blackColor] setStroke];
    bezier6Path.lineWidth = 1;
    [bezier6Path stroke];
    
    
    //// headerViewText Drawing
    CGRect headerViewTextRect = CGRectMake(10, 4, 222, 20);
    [[UIColor blackColor] setFill];
    [self.headerViewTextContent drawInRect: headerViewTextRect withFont: [UIFont systemFontOfSize: [UIFont systemFontSize]] lineBreakMode: NSLineBreakByWordWrapping alignment: NSTextAlignmentCenter];
}


@end
