/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolAnimatedTransitioning and AAPLCoolTransitioningDelegate interfaces.
  
 */

@import UIKit;

@interface AAPLCoolAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning> 
@property (nonatomic) BOOL isPresentation;

@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

@property UITapGestureRecognizer *tapGestureRecognizer;

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView;

@end

@interface DragToDismissTransitioning : NSObject <UIViewControllerInteractiveTransitioning>

@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

@property id <UIViewControllerContextTransitioning> context;

@property UIView *containerView;

@property UIView *dismissView;

@property UIImageView *transitionView;

- (id)initWithReferenceImageView:(UIImageView *)referenceImageView;

- (void)updateInteractiveTransition:(CGFloat)percentComplete;

- (void)finishInteractiveTransition;

- (void)cancelInteractiveTransition;

@end

@interface AAPLCoolTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>


@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

//@property UIPercentDrivenInteractiveTransition *interactionController;

@property DragToDismissTransitioning *interactionController;

// Initializes the receiver with the specified reference image view.
- (id)initWithReferenceImageView:(UIImageView *)referenceImageView;


@end