//
//  KyoTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/28/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface KyoTextField : CCTextField

#pragma mark - Public properties
/**
 *  The color of the placeholder text.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a dark gray color.
 */
@property (strong, nonatomic) UIColor *placeholderColor;

/**
 *  The color of the overlay.
 *
 *  This property applies a color to the complete placeholder string. The default value for this property is a transparent transparent purple color.
 */
@property (strong, nonatomic) UIColor *overlayColor;

@property (strong, nonatomic) UIColor *backgroundColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
