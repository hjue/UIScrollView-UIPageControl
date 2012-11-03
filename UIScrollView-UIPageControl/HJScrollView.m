//
//  HJScrollView.m
//  UIScrollView-UIPageControl
//
//  Created by Yu Hao on 12-7-21.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import "HJScrollView.h"

@implementation HJScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

/*
 iOS5下必须重写此方法，否则在touchesEnded里nextResponder将不能传递到ViewController
*/
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.nextResponder touchesBegan: touches withEvent:event]; 
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    // If not dragging, send event to next responder
    if (!self.dragging) 
        [self.nextResponder touchesEnded: touches withEvent:event]; 
    else
        [super touchesEnded: touches withEvent: event];
}
@end
