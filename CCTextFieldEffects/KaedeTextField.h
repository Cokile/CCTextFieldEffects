//
//  KaedeTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/26/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface KaedeTextField : CCTextField

#pragma mark - Public properties

/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a dark gray color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The view’s foreground color.
 *
 *  The default value for this property is a shallow gray color.
 */
@property (strong, nonatomic) UIColor *foregroundColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
