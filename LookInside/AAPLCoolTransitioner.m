/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolAnimatedTransitioning and AAPLCoolTransitioningDelegate implementations.
  
 */

#import "AAPLCoolTransitioner.h"
#import "AAPLCoolPresentationController.h"
//#import "AAPLRootViewController.h" // allen

@implementation AAPLCoolTransitioningDelegate

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView imageView2:(UIImageView *)referenceImageView2 {
    if (self = [super init]) {
        NSAssert(referenceImageView.contentMode == UIViewContentModeScaleAspectFill, @"*** referenceImageView must have a UIViewContentModeScaleAspectFill contentMode!");
        _referenceImageView = referenceImageView;
        _referenceImageView2 = referenceImageView2;
    }
    NSLog(@"presentation initiated");
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    NSLog(@"presentation prepared");
    AAPLCoolPresentationController *coolPC = [[AAPLCoolPresentationController alloc] initWithPresentingViewController:presenting presentedViewController:presented referenceImageView:_referenceImageView imageView2:_referenceImageView2];
    return coolPC;
}

- (AAPLCoolAnimatedTransitioning *)animationController
{
    AAPLCoolAnimatedTransitioning *animationController = [[AAPLCoolAnimatedTransitioning alloc] init];
    NSLog(@"animationController returned");
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    AAPLCoolAnimatedTransitioning *animationController = [self animationController];
    [animationController setIsPresentation:YES];
    NSLog(@"animationController presented");
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    AAPLCoolAnimatedTransitioning *animationController = [self animationController];
    [animationController setIsPresentation:NO];
    NSLog(@"animationController dismissed");
    
    return animationController;
}

@end

@implementation AAPLCoolAnimatedTransitioning


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.7;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [fromVC view];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC view];
    
    UIView *containerView = [transitionContext containerView];
    
    
    BOOL isPresentation = [self isPresentation];
    


    UIViewController *animatingVC = isPresentation? toVC : fromVC;
    UIView *animatingView = [animatingVC view];

    
    [animatingView setFrame:[transitionContext finalFrameForViewController:animatingVC]];
    
    if(!isPresentation)
        [animatingView removeFromSuperview];

    
//    CGFloat presentedTransform = 1;
//    CGFloat dismissedTransform = 0;

    
//    [animatingView setAlpha:isPresentation ? dismissedTransform : presentedTransform];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
 
                     }
                     completion:^(BOOL finished){
//                                                 [animatingView setAlpha:isPresentation ? presentedTransform : dismissedTransform];
                         if([self isPresentation])
                                 [containerView addSubview:animatingView];
                         [transitionContext completeTransition:YES];
                     }];
}

@end
