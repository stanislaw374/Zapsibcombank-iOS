//
//  ServiceViewController.m
//  Zapsibcombank
//
//  Created by Yazhenskikh Stanislaw on 14.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()
- (void)viewDragged:(UIPanGestureRecognizer *)gesture;
@end

@implementation ServiceViewController
@synthesize startImages = _startImages;

- (NSMutableArray *)startImages {
    if (!_startImages) {
        _startImages = [NSMutableArray array];
    }
    return _startImages;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSObject *startView in self.startImages) {
        if ( [startView isKindOfClass:[UIImage alloc]]){
            UIImage *startImage = (UIImage *)startView;
            UIImageView *iv = [[UIImageView alloc] initWithImage:startImage];
            [iv setUserInteractionEnabled:YES];
            UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDragged:)];
            [iv addGestureRecognizer:gesture];
            [self.view addSubview:iv];
        } else {
            [(UIView *)startView setUserInteractionEnabled:YES];
            UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDragged:)];
            [(UIView *)startView addGestureRecognizer:gesture];
            [self.view addSubview:(UIView *)startView];
        }
    }
//	// Do any additional setup after loading the view.
//    for (UIImage *startImage in self.startImages) {
//        UIImageView *iv = [[UIImageView alloc] initWithImage:startImage];
//        [iv setUserInteractionEnabled:YES];
//        UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewDragged:)];
//        [iv addGestureRecognizer:gesture];
//        [self.view addSubview:iv];
//    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark - Helpers
- (void)viewDragged:(UIPanGestureRecognizer *)gesture {
    CGPoint translation = [gesture translationInView:gesture.view];
    //NSLog(@"%@: %@", NSStringFromSelector(_cmd), NSStringFromCGPoint(translation));
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
            if (translation.x < 0) {
                CGRect frame = gesture.view.frame;
                frame.origin.x += translation.x;
                gesture.view.frame = frame;
            }
            break;
            
        case UIGestureRecognizerStateEnded:
            if (gesture.view.frame.origin.x >= -100) {
                [UIView animateWithDuration:0.5f animations:^{
                    CGRect frame = gesture.view.frame;
                    frame.origin.x = 0;
                    gesture.view.frame = frame;
                }];               
            }
            else {
                [UIView animateWithDuration:0.5f animations:^{
                    CGRect frame = gesture.view.frame;
                    frame.origin.x = - frame.size.width;
                    gesture.view.frame = frame;
                } completion:^(BOOL finished) {
                    if (finished) {
                        [gesture.view removeFromSuperview];
                    }
                }];
            }
            break;
            
        default:
            break;
    }
    
    [gesture setTranslation:CGPointZero inView:gesture.view];
}

@end
