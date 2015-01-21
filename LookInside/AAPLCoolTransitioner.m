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
    return [[AAPLCoolPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
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
    
    
    
    //
    // Create a temporary view for the zoom in transition and set the initial frame based
    // on the reference image view
    UIImageView *transitionView = [[UIImageView alloc] initWithImage:self.referenceImageView.image];
    transitionView.contentMode = UIViewContentModeScaleAspectFill;
    transitionView.clipsToBounds = YES;

    
    [containerView addSubview:transitionView];
    

//
//    CGRect transitionViewFinalFrame = [self.referenceImageView.image tgr_aspectFitRectForSize:finalFrame.size];
    
    //
//    AA *fromViewController = (AAPLCoolPresentationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    
    CGRect transitionFinalFramePresent = toView.bounds;
    CGRect transitionFinalFrameDismiss = [transitionContext.containerView convertRect:self.referenceImageView.bounds
                                                                             fromView:self.referenceImageView];;
    
    [transitionView setFrame:isPresentation ? transitionFinalFrameDismiss : transitionFinalFramePresent];

//    UIViewController *animatingVC = isPresentation? toVC : fromVC;
//    UIView *animatingView = [animatingVC view];
    
//    [animatingView setFrame:[transitionContext finalFrameForViewController:animatingVC]];
    [toView setFrame:[transitionContext finalFrameForViewController:toVC]];
    
//    CGAffineTransform presentedTransform = CGAffineTransformIdentity;
//    CGAffineTransform dismissedTransform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.001, 0.001), CGAffineTransformMakeRotation(8 * M_PI));
    
//    CGFloat presentedTransform = 1;
//    CGFloat dismissedTransform = 0;
    
//    [animatingView setTransform:isPresentation ? dismissedTransform : presentedTransform];
    
//    [animatingView setAlpha:isPresentation ? dismissedTransform : presentedTransform];
    
    if(!isPresentation)
    {
        [fromView removeFromSuperview];
        
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
//                         [animatingView setTransform:isPresentation ? presentedTransform : dismissedTransform];
//                         [animatingView setAlpha:isPresentation ? presentedTransform : dismissedTransform];
                         
                         [transitionView setFrame:isPresentation ? transitionFinalFramePresent : transitionFinalFrameDismiss];
                         
                     }
                     completion:^(BOOL finished){
                         if(isPresentation)
                         {
                             [containerView addSubview:toView];
                             [transitionView removeFromSuperview];
                         }
                         
                         [transitionContext completeTransition:YES];
                     }];
}

@end
