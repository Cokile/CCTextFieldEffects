//
//  KohanaTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 7/1/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface KohanaTextField : CCTextField

#pragma mark - Public properties
/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a gray color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The image of the comtrol.
 *
 *  This property applies a image to the control. The color of the image is determined by placeholderColor.
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
