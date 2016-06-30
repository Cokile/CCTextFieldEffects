//
//  ChisatoTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/29/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface ChisatoTextField : CCTextField

#pragma mark - Public properties
/**
 *  The color of the border.
 *
 *  This property applies a color to the bounds of the control. The default value for this property is a grey color.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a gray color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The color of the active border and placeholder.
 *
 *  This property applies a color to the bounds of the control and placeholder when the text is not empty or focused. The default value for this property is a pink color.
 */
@property (strong, nonatomic) UIColor *activeColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
