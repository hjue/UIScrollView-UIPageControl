//
//  HJViewController.h
//  UIScrollView-UIPageControl
//
//  Created by Yu Hao on 12-7-20.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJScrollView;


@interface HJViewController : UIViewController <UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    HJScrollView *scrollView;
}

//@property (nonatomic, strong)   HJScrollView *scrollView;

@end
