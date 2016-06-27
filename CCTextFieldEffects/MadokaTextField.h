//
//  MadokaTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/26/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface MadokaTextField : CCTextField

#pragma mark - Public properties
/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a purple color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The color of the border.
 *
 *  This property applies a color to the lower edge of the control. The default value for this property is a purple color.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
