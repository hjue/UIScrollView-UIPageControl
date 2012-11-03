//
//  HJViewController.m
//  UIScrollView-UIPageControl
//
//  Created by Yu Hao on 12-7-20.
//  Copyright (c) 2012年 CSDN.net. All rights reserved.
//

#import "HJViewController.h"
#import "HJScrollView.h"

@interface HJViewController ()
{
    NSInteger currnetPage;
    NSInteger numberOfPages;
}
@end

@implementation HJViewController


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

    currnetPage = 0;
    numberOfPages = 3;
    
    scrollView = [[HJScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, 320, 424);
    scrollView.pagingEnabled = YES;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width*numberOfPages, scrollView.frame.size.height);
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    pageControl = [[UIPageControl alloc]init];
    pageControl.frame = CGRectMake(0, 424, 320, 36);
    pageControl.currentPage = currnetPage;
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
    
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    singleFingerTap.numberOfTapsRequired = 1;
    [scrollView addGestureRecognizer:singleFingerTap];
    
    singleFingerTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    singleFingerTap.numberOfTapsRequired = 2;
    [scrollView addGestureRecognizer:singleFingerTap];
    
        
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    pageControl.userInteractionEnabled= YES;
    [self.view addSubview:pageControl];
    [self.view addSubview:scrollView];    
}

-(void) changePage:(id)sender
{

    NSLog(@"page:%@,%d",sender,currnetPage);
    pageControl.currentPage = currnetPage;
    CGRect frame ;
    frame.origin.x = scrollView.frame.size.width * currnetPage;
    frame.origin.y = 0;
    frame.size = scrollView.frame.size;
    [scrollView scrollRectToVisible:frame animated:YES];
}


-(void)handleTap:(UIGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:sender.view.superview];
    if (point.x<scrollView.frame.size.width/2) {
        if (currnetPage>0)
        {
            currnetPage--;
            [self changePage:nil];
        }
    }else {
        if(currnetPage<(numberOfPages-1))
        {
            currnetPage++;
            [self changePage:nil];
            
        }
    }    
}

-(void)handleDoubleTap:(UIGestureRecognizer *)sender
{
    NSLog(@"Double Tap");
}

-(void) touchAction:(UITouch *)touch
{
    CGPoint point = [touch locationInView:self.view];
    NSLog(@"touch point:%f,%f",point.x,point.y);
    if (point.x<scrollView.frame.size.width/2) {
        if (pageControl.currentPage>=1)
        {
            pageControl.currentPage = pageControl.currentPage - 1;
            [self changePage:nil];
        }
    }else {
        if(pageControl.currentPage<pageControl.numberOfPages)
        {
            pageControl.currentPage = pageControl.currentPage + 1;
            [self changePage:nil];

        }
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event { 

        //[self.nextResponder touchesEnded: touches withEvent:event]; 
        // Detect touch anywhere
    
//    UITouch *touch = [touches anyObject];
//    CGPoint point = [touch locationInView:self.view];
//    NSInteger x= point.x;
//    switch ([touch tapCount]) 
//    {
//        case 1:
//            [self performSelector:@selector(touchAction:) withObject:touch afterDelay:.5];
//            break;
//            
//        case 2:
//            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(touchAction:) object:touch];
//            [self performSelector:@selector(touchAction:) withObject:touch afterDelay:.5];
//            break;
//            
//        case 3:
//            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(touchAction:) object:touch];
//            [self performSelector:@selector(touchAction:) withObject:touch afterDelay:.5];
//            break;
//            
//        default:
//            break;
//    }          
//      
 
    
}


- (void)viewDidLoad
{
        
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self createView];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender
{

    CGFloat width = scrollView.frame.size.width;
    currnetPage = floor((scrollView.contentOffset.x-width/2)/width)+1;
    pageControl.currentPage = currnetPage;


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
