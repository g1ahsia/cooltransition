/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolPresentationController implementation.
  
 */

#import "AAPLCoolPresentationController.h"

@implementation AAPLCoolPresentationController



- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController presentedViewController:(UIViewController *)presentedViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if(self)
    {        
    }
    return self;
}

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController presentedViewController:(UIViewController *)presentedViewController referenceImageView:(UIImageView *)referenceImageView {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _referenceImageView = referenceImageView;
    }
    return self;
}

//- (CGRect)frameOfPresentedViewInContainerView
//{
//    CGRect containerBounds = [[self containerView] bounds];
//    
//    CGRect presentedViewFrame = CGRectZero;
//    presentedViewFrame.size = CGSizeMake(300, 500);
//    presentedViewFrame.origin = CGPointMake(containerBounds.size.width / 2.0, containerBounds.size.height / 2.0);
//    presentedViewFrame.origin.x -= presentedViewFrame.size.width / 2.0;
//    presentedViewFrame.origin.y -= presentedViewFrame.size.height / 2.0;
//    
//    return presentedViewFrame;
//}

- (void)presentationTransitionWillBegin
{
    NSLog(@"Presentation transition will begin");
//    [super presentationTransitionWillBegin];
    transitionImageView = [[UIImageView alloc] initWithImage:_referenceImageView.image];
    transitionImageView.contentMode = _referenceImageView.contentMode;
    transitionImageView.clipsToBounds = YES;
    
    originalFrame = [[self containerView] convertRect:self.referenceImageView.bounds
                                             fromView:self.referenceImageView];
    
    
    [[self containerView] addSubview:transitionImageView];
    
    [transitionImageView setFrame:originalFrame];
    
    [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [transitionImageView setFrame:[self containerView].frame];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        
    }];
}

- (void)presentationTransitionDidEnd:(BOOL)completed {
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentedViewTapped:)];
    [self.presentedViewController.view addGestureRecognizer:_tapGestureRecognizer];
    
    _screenEdgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(presentedViewEdgePanned:)];
    _screenEdgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.presentedViewController.view addGestureRecognizer:_screenEdgePanGestureRecognizer];
    
//    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(presentedViewPanned:)];
//    [self.presentedViewController.view addGestureRecognizer:_panGestureRecognizer];
}


- (void)dismissalTransitionWillBegin
{
    [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [transitionImageView setFrame:originalFrame];
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        
    }];
}

- (AAPLCoolTransitioningDelegate *)transitioningDelegate
{
    return self.presentedViewController.transitioningDelegate;
}

#pragma mark - UIGestureRecognizers

- (void)presentedViewTapped:(UITapGestureRecognizer *)gesture
{
    
    NSLog(@"did tap");
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)presentedViewEdgePanned:(UIScreenEdgePanGestureRecognizer*)gesture {
    CGFloat progress = [gesture translationInView:self.presentedViewController.view].x / (self.presentedViewController.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    NSLog(@"progress is %f", progress);
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"did begin edge panning");
        self.transitioningDelegate.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    }
    else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.transitioningDelegate.interactionController updateInteractiveTransition:progress];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded) {
        // Finish or cancel the interactive transition
        if (progress > 0.5) {
            [self.transitioningDelegate.interactionController finishInteractiveTransition];
        }
        else {
            [self.transitioningDelegate.interactionController cancelInteractiveTransition];
        }
        
        self.transitioningDelegate.interactionController = nil;
    }

    
}



@end
