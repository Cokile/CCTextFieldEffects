//
//  SaeTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 7/1/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface SaeTextField : CCTextField

#pragma mark - Public properties
/**
 *  The color of the border.
 *
 *  This property applies a color to the lower border of the control. The default value for this property is a white color.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  The image of the control.
 *
 *  This property applies a image to the  right-down of the control, the color of the image is determined by borderColor. The default value for this property is a pencil.
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a transparent black color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
