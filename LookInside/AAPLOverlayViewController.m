/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLOverlayViewController implementation.
  
 */

#import "AAPLOverlayViewController.h"
#import "AAPLRootViewController.h"

@interface AAPLOverlayViewController ()

@end

@implementation AAPLOverlayViewController
{
    dispatch_queue_t processingQueue;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self setModalPresentationStyle:UIModalPresentationCustom];
        [self setup];
//        self.navigationController.delegate = self;

    }
    return self;
}

- (void)setImage:(UIImage *)image {
    imageView.image = image;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setup
{
    imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:imageView];
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self && [toVC isKindOfClass:[AAPLRootViewController class]]) {
//        return [[DSLTransitionFromSecondToFirst alloc] init];
        NSLog(@"transitioning to root");
        return nil;
    }
    else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
//    if ([animationController isKindOfClass:[DSLTransitionFromSecondToFirst class]]) {
//        return self.interactivePopTransition;
//    }
//    else {
//        return nil;
//    }
    
    NSLog(@"returning custom transition here");
    return nil;
}


@end
