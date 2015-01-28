/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolAnimatedTransitioning and AAPLCoolTransitioningDelegate implementations.
  
 */

#import "AAPLCoolTransitioner.h"
#import "AAPLCoolPresentationController.h"
#import "AAPLRootViewController.h" // allen

@implementation AAPLCoolTransitioningDelegate

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView {
    if (self = [super init]) {
        NSAssert(referenceImageView.contentMode == UIViewContentModeScaleAspectFill, @"*** referenceImageView must have a UIViewContentModeScaleAspectFill contentMode!");
        _referenceImageView = referenceImageView;
    }
    return self;
}

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[AAPLCoolPresentationController alloc] initWithPresentingViewController:presenting presentedViewController:presented referenceImageView:_referenceImageView];
}

- (AAPLCoolAnimatedTransitioning *)animationController
{
    AAPLCoolAnimatedTransitioning *animationController = [[AAPLCoolAnimatedTransitioning alloc] initWithReferenceImageView:_referenceImageView];
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    AAPLCoolAnimatedTransitioning *animationController = [self animationController];
    [animationController setIsPresentation:YES];
    
    return animationController;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    AAPLCoolAnimatedTransitioning *animationController = [self animationController];
    [animationController setIsPresentation:NO];
    
    return animationController;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator
{
    NSLog(@"return interaction controller for presentation");
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator
{
    NSLog(@"return interaction controller for dismissal");
    return self.interactionController;
}

@end

@implementation AAPLCoolAnimatedTransitioning

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView {
    if (self = [super init]) {
        NSAssert(referenceImageView.contentMode == UIViewContentModeScaleAspectFill, @"*** referenceImageView must have a UIViewContentModeScaleAspectFill contentMode!");
        _referenceImageView = referenceImageView;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // obtain the view controllers and their views
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = [fromVC view];
    UIViewController *toVC   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = [toVC view];
    
    // get the container view
    UIView *containerView = [transitionContext containerView];
    
    // are we presenting or dismissing?
    BOOL isPresentation = [self isPresentation];
    
    // Create a temporary view for the zoom in transition and set the initial frame based
    // on the reference image view
    UIImageView *transitionView = [[UIImageView alloc] initWithImage:self.referenceImageView.image];
    transitionView.contentMode = UIViewContentModeScaleAspectFill;
    transitionView.clipsToBounds = YES;
    
    // add the transitionView to the transition
    [containerView addSubview:transitionView];
    
    // calculate the final frames of transitionView
    CGRect transitionFinalFramePresent = toView.bounds;
    CGRect transitionFinalFrameDismiss = [transitionContext.containerView convertRect:self.referenceImageView.bounds
                                                                             fromView:self.referenceImageView];;
    // set the initial position of the transitionView
    [transitionView setFrame:isPresentation ? transitionFinalFrameDismiss : transitionFinalFramePresent];
    
    // position the toView to its final position
    [toView setFrame:[transitionContext finalFrameForViewController:toVC]];
    
    if(!isPresentation)
    {
        // since we are using a transitionView, we need to make the fromView invisible when dismissing
        fromView.alpha = 0.0;
    }
    
    // animate
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        // animate transitionView into the final position
        [transitionView setFrame:isPresentation ? transitionFinalFramePresent : transitionFinalFrameDismiss];
    } completion:^(BOOL finished) {
        if(isPresentation) // we presented the single image
        {
            // add the toView to the container
            [containerView addSubview:toView];
            // let the context know we are donw.
            [transitionContext completeTransition:YES];
            
        } else if (!transitionContext.transitionWasCancelled) {
            // we dismissed the single image, and we should complete the transition
            [transitionContext completeTransition:YES];
            
        } else { // transition was a dismiss, and was cancelled, so don't complete
            // make the fromView visible again
            fromView.alpha = 1.0;
            [transitionContext completeTransition:NO];
        }
        
        // remove the temporary transitionView
        [transitionView removeFromSuperview];

    }];
    
//    [UIView animateWithDuration:[self transitionDuration:transitionContext]
//                          delay:0
//         usingSpringWithDamping:1.0
//          initialSpringVelocity:0.0
//                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         // animate transitionView into the final position
//                         [transitionView setFrame:isPresentation ? transitionFinalFramePresent : transitionFinalFrameDismiss];
//                     }
//                     completion:^(BOOL finished){ // we are done with the animation, so clean up
//                         if(isPresentation) // we presented the single image
//                         {
//                             // add the toView to the container
//                             [containerView addSubview:toView];
//                             // let the context know we are donw.
//                             [transitionContext completeTransition:YES];
//                             
//                         } else if (!transitionContext.transitionWasCancelled) {
//                             // we dismissed the single image, and we should complete the transition
//                             [transitionContext completeTransition:YES];
//                             
//                         } else { // transition was a dismiss, and was cancelled, so don't complete
//                             // make the fromView visible again
//                             fromView.alpha = 1.0;
//                             [transitionContext completeTransition:NO];
//                         }
//                         
//                         // remove the temporary transitionView
//                         [transitionView removeFromSuperview];
//                     }];
}
@end
