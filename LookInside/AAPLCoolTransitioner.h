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

// Initializes the receiver with the specified reference image view.
- (id)initWithReferenceImageView:(UIImageView *)referenceImageView;


@end

@interface AAPLCoolTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>


@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

@property UIPercentDrivenInteractiveTransition *interactionController;

// Initializes the receiver with the specified reference image view.
- (id)initWithReferenceImageView:(UIImageView *)referenceImageView;


@end