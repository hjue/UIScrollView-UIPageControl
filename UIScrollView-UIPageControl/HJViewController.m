//
//  HJViewController.m
//  UIScrollView-UIPageControl
//
//  Created by Yu Hao on 12-7-20.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import "HJViewController.h"


@interface HJViewController ()
{
    BOOL pageControlBeingUsed;
}
@end

@implementation HJViewController
@synthesize scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)createView
{
    pageControlBeingUsed = NO;
    int numberOfPages = 3;
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, 320, 424);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*numberOfPages, scrollView.frame.size.height);
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake(0, 424, 320, 36);
    pageControl.currentPage = 0;
    pageControl.numberOfPages = numberOfPages;
    
    for (int i=0; i<numberOfPages; i++) {
        CGRect frame;
        frame.origin.x = scrollView.frame.size.width*i;
        frame.origin.y = 0;
        frame.size = scrollView.frame.size;
        
        UILabel *textView = [[UILabel alloc]initWithFrame:frame];
        textView.text = [NSString stringWithFormat:@"Page %d",i+1];
        textView.font = [UIFont systemFontOfSize:38];
        textView.textColor = [UIColor blackColor]; 
        textView.backgroundColor = [UIColor whiteColor];
        textView.textAlignment = UITextAlignmentCenter;
        [scrollView addSubview:textView];
        textView = nil;
    }
    scrollView.delegate = self;            
    
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    pageControl.userInteractionEnabled= YES;
    [self.view addSubview:pageControl];
    [self.view addSubview:scrollView];    
}

-(void) changePage:(id)sender
{
    pageControlBeingUsed = YES;
    CGRect frame ;
    frame.origin.x = scrollView.frame.size.width*pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = scrollView.frame.size;
    [scrollView scrollRectToVisible:frame animated:YES];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 
    
    if (!scrollView.dragging) 
    {
        //[self.nextResponder touchesEnded: touches withEvent:event]; 
        // Detect touch anywhere
        UITouch *touch = [touches anyObject];
        NSLog(@"touch!");
        switch ([touch tapCount]) 
        {
            case 1:
                [self performSelector:@selector(oneTap) withObject:nil afterDelay:.5];
                break;
                
            case 2:
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(oneTap) object:nil];
                [self performSelector:@selector(twoTaps) withObject:nil afterDelay:.5];
                break;
                
            case 3:
                [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(twoTaps) object:nil];
                [self performSelector:@selector(threeTaps) withObject:nil afterDelay:.5];
                break;
                
            default:
                break;
        }        
    }
    else
    {
        [super touchesEnded: touches withEvent: event];
        
    }
    
}


- (void)viewDidLoad
{
        
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createView];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    if(!pageControlBeingUsed)
    {
        CGFloat width = scrollView.frame.size.width;
        int page = floor((scrollView.contentOffset.x-width/2)/width)+1;
        pageControl.currentPage = page;
    }

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    scrollView = nil;
    pageControl = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
