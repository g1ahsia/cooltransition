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
    UIImageView *bigFlowerImageView;
    UIImageView *carlImageView;

    UIImage *jaguarPrintImageH;
    UIImage *jaguarPrintImageV;

    UIImageView *topJaguarPrintImageView;
    UIImageView *bottomJaguarPrintImageView;

    UIImageView *leftJaguarPrintImageView;
    UIImageView *rightJaguarPrintImageView;
    
    UIView *dimmingView;
}

@property UITapGestureRecognizer *tapGestureRecognizer;
@property UIPanGestureRecognizer *panGestureRecognizer;
@property UIScreenEdgePanGestureRecognizer *screenEdgePanGestureRecognizer;
@property (weak, readonly) AAPLCoolTransitioningDelegate *transitioningDelegate;


@end
