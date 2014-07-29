/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLCoolAnimatedTransitioning and AAPLCoolTransitioningDelegate interfaces.
  
 */

@import UIKit;

@interface AAPLCoolAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL isPresentation;

@end

@interface AAPLCoolTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>


@property (weak, nonatomic, readonly) UIImageView *referenceImageView;

@property (weak, nonatomic, readonly) UIImageView *referenceImageView2;

// Initializes the receiver with the specified reference image view.
- (id)initWithReferenceImageView:(UIImageView *)referenceImageView imageView2:(UIImageView *)referenceImageView2;




@end