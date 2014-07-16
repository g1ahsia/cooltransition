/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolPresentationController implementation.
  
 */

#import "AAPLCoolPresentationController.h"

@implementation AAPLCoolPresentationController

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController presentedViewController:(UIViewController *)presentedViewController referenceImageView:(UIImageView *)referenceImageView
{
    self = [super initWithPresentingViewController:presentingViewController presentedViewController:presentedViewController];
    if(self)
    {
        _referenceImageView = referenceImageView;
        
    }
    return self;
}

- (CGRect)frameOfPresentedViewInContainerView
{
    CGRect containerBounds = [[self containerView] bounds];
    
    CGRect presentedViewFrame = CGRectZero;
    presentedViewFrame.size = CGSizeMake(240, 400);
    presentedViewFrame.origin = CGPointMake(containerBounds.size.width / 2.0, containerBounds.size.height / 2.0);
    presentedViewFrame.origin.x -= presentedViewFrame.size.width / 2.0;
    presentedViewFrame.origin.y -= presentedViewFrame.size.height / 2.0;
    
    return presentedViewFrame;
}

- (void)presentationTransitionWillBegin
{
    NSLog(@"Presentation transition will begin");
    [super presentationTransitionWillBegin];
    
    transitionImageView = [[UIImageView alloc] initWithImage:_referenceImageView.image];
    transitionImageView.contentMode = UIViewContentModeScaleAspectFill;
    transitionImageView.clipsToBounds = YES;
    

    blurView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];

    [transitionImageView setFrame:[[self containerView] convertRect:self.referenceImageView.bounds
                                                           fromView:self.referenceImageView]];
    
    [blurView setFrame:transitionImageView.bounds];
    [blurView setAlpha:0];
    
    [self addViewsToDimmingView];
    
    
    [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [transitionImageView setFrame:[[self containerView] bounds]];
        [blurView setFrame:[[self containerView] bounds]];
        [blurView setAlpha:1];
        
    } completion:nil];

}

- (void)containerViewWillLayoutSubviews
{
    
    NSLog(@"container view will layout subviews");

}

- (void)containerViewDidLayoutSubviews
{
    NSLog(@"container view did layout subviews");
}

- (void)dismissalTransitionWillBegin
{
    NSLog(@"dismissal transition will begin");
    [super dismissalTransitionWillBegin];
    
    _referenceImageView.alpha = 0;

    [[[self presentedViewController] transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [transitionImageView setFrame:[[self containerView] convertRect:self.referenceImageView.bounds
                                                     fromView:self.referenceImageView]];
        blurView.alpha = 0;
//        [blurView setFrame:[[self containerView] convertRect:self.referenceImageView.bounds
//                                                               fromView:self.referenceImageView]];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
        _referenceImageView.alpha = 1;
        
    }];
}

- (void)addViewsToDimmingView
{
    [[self containerView] addSubview:transitionImageView];
    [transitionImageView addSubview:blurView];
    
    
}

@end
