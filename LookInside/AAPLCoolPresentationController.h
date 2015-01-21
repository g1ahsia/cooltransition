/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolPresentationController header.
  
 */
#import "AAPLCoolTransitioner.h"

@import UIKit;


@interface AAPLCoolPresentationController : UIPresentationController
{
    UIImageView *transitionImageView;
    CGRect originalFrame;
}

@property UITapGestureRecognizer *tapGestureRecognizer;
@property UIPanGestureRecognizer *panGestureRecognizer;
@property UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer;
@property (weak, readonly) AAPLCoolTransitioningDelegate *transitioningDelegate;

@property (nonatomic, readwrite) UIImageView *referenceImageView;

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController presentedViewController:(UIViewController *)presentedViewController referenceImageView:(UIImageView *)referenceImageView;


@end
