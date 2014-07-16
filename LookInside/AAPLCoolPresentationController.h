/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolPresentationController header.
  
 */

@import UIKit;

@interface AAPLCoolPresentationController : UIPresentationController
{
    
    UIImageView *transitionImageView;
    UIVisualEffectView *blurView;
}

@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController presentedViewController:(UIViewController *)presentedViewController referenceImageView:(UIImageView *)referenceImageView;

@end
