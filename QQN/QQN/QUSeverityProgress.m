//
//  QUSeverityProgress.m
//  QQN
//
//  Created by Adam Lowther on 2/4/14.
//  Copyright (c) 2014 Adam Lowther. All rights reserved.
//

#import "QUSeverityProgress.h"

@implementation QUSeverityProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setGradientColors:@[//HexToUIColor(0x00FF00),
                                  //HexToUIColor(0x12FF00),
                                  //HexToUIColor(0x24FF00),
                                  HexToUIColor(0x35FF00),
                                  HexToUIColor(0x47FF00),
                                  HexToUIColor(0x58FF00),
                                  HexToUIColor(0x6AFF00),
                                  HexToUIColor(0x7CFF00),
                                  HexToUIColor(0x8DFF00),
                                  HexToUIColor(0x9FFF00),
                                  HexToUIColor(0xB0FF00),
                                  HexToUIColor(0xC2FF00),
                                  HexToUIColor(0xD4FF00),
                                  HexToUIColor(0xE5FF00),
                                  HexToUIColor(0xF7FF00),
                                  HexToUIColor(0xFFF600),
                                  HexToUIColor(0xFFE400),
                                  HexToUIColor(0xFFD300),
                                  HexToUIColor(0xFFC100),
                                  HexToUIColor(0xFFAF00),
                                  HexToUIColor(0xFF9E00),
                                  HexToUIColor(0xFF8C00),
                                  HexToUIColor(0xFF7B00),
                                  HexToUIColor(0xFF6900),
                                  HexToUIColor(0xFF5700),
                                  HexToUIColor(0xFF4600),
                                  HexToUIColor(0xFF3400),
                                  HexToUIColor(0xFF1100),
                                  HexToUIColor(0xFF2300),
                                  HexToUIColor(0xFF0000)]];
    }
    return self;
}

//-(id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//
//        
////        [self addSliderToView];
//        [self setNeedsDisplay];
//    }
//    return self;
//}

-(void)addSliderToView
{
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.center.y, self.frame.size.width, self.frame.size.height/2.0f);
    self.progressSlider = [[UISlider alloc] initWithFrame:newFrame];
    [self.progressSlider setMinimumValue:0.0f];
    [self.progressSlider setMaximumValue:1.0f];
    [self.progressSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.progressSlider setOpaque:YES];
    [self addSubview:self.progressSlider];
}

-(void)setProgress:(float)progress
{
    [self setGradientColors:@[//HexToUIColor(0x00FF00),
                              //HexToUIColor(0x12FF00),
                              //HexToUIColor(0x24FF00),
                              HexToUIColor(0x35FF00),
                              HexToUIColor(0x47FF00),
                              HexToUIColor(0x58FF00),
                              HexToUIColor(0x6AFF00),
                              HexToUIColor(0x7CFF00),
                              HexToUIColor(0x8DFF00),
                              HexToUIColor(0x9FFF00),
                              HexToUIColor(0xB0FF00),
                              HexToUIColor(0xC2FF00),
                              HexToUIColor(0xD4FF00),
                              HexToUIColor(0xE5FF00),
                              HexToUIColor(0xF7FF00),
                              HexToUIColor(0xFFF600),
                              HexToUIColor(0xFFE400),
                              HexToUIColor(0xFFD300),
                              HexToUIColor(0xFFC100),
                              HexToUIColor(0xFFAF00),
                              HexToUIColor(0xFF9E00),
                              HexToUIColor(0xFF8C00),
                              HexToUIColor(0xFF7B00),
                              HexToUIColor(0xFF6900),
                              HexToUIColor(0xFF5700),
                              HexToUIColor(0xFF4600),
                              HexToUIColor(0xFF3400),
                              HexToUIColor(0xFF1100),
                              HexToUIColor(0xFF2300),
                              HexToUIColor(0xFF0000)]];
    
    [super setProgress:progress];
//    [self.progressSlider setValue:progress];
}

-(void)sliderValueChanged:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    [self.progressSlider setValue:slider.value animated:YES];
    [self setProgress:slider.value];
    
}


@end
