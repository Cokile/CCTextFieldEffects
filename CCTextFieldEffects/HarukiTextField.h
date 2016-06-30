//
//  HarukiTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/28/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface HarukiTextField : CCTextField

#pragma mark - Public properties

/**
 *  The color of the border.
 *
 *  This property applies a color to the upper and lower borders of the control. The default value for this property is a dark gray color.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a dark gray color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
