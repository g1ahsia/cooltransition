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


@implementation DragToDismissTransitioning

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView {
    if (self = [super init]) {
        NSAssert(referenceImageView.contentMode == UIViewContentModeScaleAspectFill, @"*** referenceImageView must have a UIViewContentModeScaleAspectFill contentMode!");
        _referenceImageView = referenceImageView;
    }
    return self;
}

- (void)startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    NSLog(@"starting interactive transition");
    
    self.context = transitionContext;
    

    
//    CGRect transitionFinalFrameDismiss = [self.context.containerView convertRect:self.referenceImageView.bounds
//                                                                        fromView:self.referenceImageView];

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    fromVC.view.frame = [transitionContext initialFrameForViewController:fromVC];
    
    self.transitionView = [[UIImageView alloc] initWithImage:self.referenceImageView.image];
    self.transitionView.frame = fromVC.view.frame;
    self.transitionView.contentMode = UIViewContentModeScaleAspectFill;
    self.transitionView.clipsToBounds = YES;

    
    self.containerView = [transitionContext containerView];

//    [containerView addSubview:toVC.view];
//    [containerView addSubview:fromVC.view];
    
    [self.containerView addSubview:self.transitionView];
    
    self.dismissView = fromVC.view;
    self.dismissView.alpha = 0.0;
    self.transitionView.layer.borderColor = [[UIColor redColor]CGColor];
    self.transitionView.layer.borderWidth = 2.0;
}

- (void)updateInteractiveTransition:(CGFloat)percentComplete {
    UIViewController *toVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect transitionFinalFramePresent = [self.context finalFrameForViewController:toVC];
    CGRect transitionFinalFrameDismiss = [self.context.containerView convertRect:self.referenceImageView.bounds
                                                                             fromView:self.referenceImageView];
    NSLog(@"percentComplete %f", percentComplete);

    
//    CGAffineTransform dismissedTransform = CGAffineTransformConcat(CGAffineTransformMakeScale(1 - percentComplete, 1 - percentComplete), CGAffineTransformMakeRotation(8 * M_PI));
    
    
    CGAffineTransform dismissedTransform = [self translatedAndScaledTransformUsingViewRect:transitionFinalFrameDismiss fromRect:transitionFinalFramePresent percentage:percentComplete];
    
//    CGAffineTransform dismissedTransform = [self translateFromRect:transitionFinalFramePresent toRect:transitionFinalFrameDismiss];
    
    [self.transitionView setTransform:dismissedTransform];
    self.transitionView.image = [self scaleImage:self.transitionView.image toSize:CGSizeMake(self.transitionView.frame.size.width, self.transitionView.frame.size.height)];
    //    [self.dismissView setFrame:transitionFinalFrameDismiss];
    [self.context updateInteractiveTransition:percentComplete];
    
}

- (void)finishInteractiveTransition {
    [self.context finishInteractiveTransition];
    [self.context completeTransition:YES];
}

- (void)cancelInteractiveTransition {
    UIViewController *toVC = [self.context viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [self.context viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect initialFrame = [self.context initialFrameForViewController:fromVC];
    CGRect currentFrame = self.transitionView.frame;
    
//    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.context.containerView];
//    
//    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.transitionView]];
//    gravity.gravityDirection = CGVectorMake(0, 4.0);
//    
//    gravity.action = ^{
//        self.transitionView.frame = initialFrame;
//    };
//    
//    [animator addBehavior:gravity];
    
    [UIView animateWithDuration:0.6 animations:^{
        [self.transitionView setFrame:initialFrame];
    } completion:^(BOOL finished) {
        self.dismissView.alpha = 1.0;
        [self.transitionView removeFromSuperview];
        [self.context cancelInteractiveTransition];
        [self.context completeTransition:NO];
    }];
}

- (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)toRect fromRect:(CGRect)fromRect percentage:(CGFloat)percentageComplete {
    
    CGFloat percent = 1.0 - percentageComplete;
    
    CGSize scales = CGSizeMake(toRect.size.width/fromRect.size.width, toRect.size.height/fromRect.size.height);
    
    NSLog(@"scale is %f %f", scales.width, scales.height);
    
//    scales = CGSizeMake(scales.width * ( 1 - percentage), scales.height * (1 - percentage));
    CGPoint offset = CGPointMake(CGRectGetMidX(toRect) - CGRectGetMidX(fromRect), CGRectGetMidY(toRect) - CGRectGetMidY(fromRect));
    
    NSLog(@"offset is %f %f", offset.x, offset.y);
    
//    return CGAffineTransformMake(scales.width, 0, 0, scales.height, offset.x, offset.y);
        return CGAffineTransformMake(percent * (1-scales.width) + scales.width, 0, 0, percent * (1-scales.height) + scales.height, percent * (-offset.x) + offset.x, percent * (-offset.y) + offset.y);
    
}

- (UIImage*)scaleImage:(UIImage*)image toSize:(CGSize)newSize {
    CGSize scaledSize = newSize;
    float scaleFactor = 1.0;
    if( image.size.width > image.size.height ) {
        scaleFactor = image.size.width / image.size.height;
        scaledSize.width = newSize.width;
        scaledSize.height = newSize.height / scaleFactor;
    }
    else {
        scaleFactor = image.size.height / image.size.width;
        scaledSize.height = newSize.height;
        scaledSize.width = newSize.width / scaleFactor;
    }
    
    UIGraphicsBeginImageContextWithOptions( scaledSize, NO, 0.0 );
    CGRect scaledImageRect = CGRectMake( 0.0, 0.0, scaledSize.width, scaledSize.height );
    [image drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end