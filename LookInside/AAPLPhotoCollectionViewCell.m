/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  AAPLPhotoCollectionViewCell implementation.
  
 */

#import "AAPLPhotoCollectionViewCell.h"

@implementation AAPLPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        self.imageView = [[UIImageView alloc] init];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        self.imageView.layer.contentsRect = CGRectMake(0.05, 0.05, 0.9, 0.9);
        
        [[self contentView] addSubview:self.imageView];
        [[self contentView] setClipsToBounds:YES];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView setFrame:[[self contentView] bounds]];
}

- (void)setImage:(UIImage *)image
{
    [self.imageView setImage:image];

}

- (void)setCellSize:(CGFloat)cellSize {
    _cellSize = cellSize;
    [self.imageView setFrame:CGRectMake(([[self contentView] bounds].size.width - _cellSize)/2, ([[self contentView] bounds].size.height  - _cellSize)/2, _cellSize, _cellSize)];
    
}

- (UIImage *)image
{
    return [self.imageView image];
}

- (void)setImageScale:(CGRect)imageScale {
    _imageScale = imageScale;
    self.imageView.layer.contentsRect = CGRectMake(imageScale.origin.x, imageScale.origin.y, imageScale.size.width, imageScale.size.height);
}

@end
