//
//  HJViewController.h
//  UIScrollView-UIPageControl
//
//  Created by Yu Hao on 12-7-20.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJViewController : UIViewController <UIScrollViewDelegate>
{
    UIPageControl *pageControl;
    UIScrollView* scrollView;
}

@property (nonatomic, strong)   UIScrollView* scrollView;

@end
