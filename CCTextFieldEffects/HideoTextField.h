//
//  HideoTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/27/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface HideoTextField : CCTextField

#pragma mark - Public properties

/**
 *  The color of the image container color.
 *
 *  This property applies a color to the background of the image container. The default value for this property is a purple color.
 */
@property (strong, nonatomic) UIColor *imageContainerColor;

/**
 *  The image of the image container view.
 *
 *  This property applies a image to the image container.
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  The scale of the image.
 *
 *  This property determines the size of the image relative to the original size when animated. The default value for this properties is 0.7
 */
@property (nonatomic) CGFloat imageScale;

@end
