/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLPhotoCollectionViewCell header.
  
 */

@import UIKit;

@interface AAPLPhotoCollectionViewCell : UICollectionViewCell
{
//    UIImageView *imageView;
}

@property (nonatomic) UIImage *image;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic, readwrite) CGFloat cellSize;
@property (nonatomic, assign, readwrite) CGRect imageScale;

@end
