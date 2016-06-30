//
//  RuriTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/29/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface RuriTextField : CCTextField

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
 *  This property applies a color to the lower edge of the control. The default value for this property is a shallow green color.
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  The color of the active border and placeholder.
 *
 *  This property applies a color to the lower edge of the control and placeholder when the text is not empty or focused. The default value for this property is a shallow green color.
 */
@property (strong, nonatomic) UIColor *activeColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;


@end
