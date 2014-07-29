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
    UIImageView *transitionImageView2;
    UIVisualEffectView *blurView;
}

@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

@property (weak, nonatomic, readonly) UIImageView *referenceImageView2;

- (instancetype)initWithPresentingViewController:(UIViewController *)presentingViewController presentedViewController:(UIViewController *)presentedViewController referenceImageView:(UIImageView *)referenceImageView imageView2:(UIImageView *)referenceImageView2;

@end
