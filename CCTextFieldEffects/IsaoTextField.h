//
//  IsaoTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCTextField.h"

@interface IsaoTextField : CCTextField

#pragma mark - Public properties
/**
 *  The color of the border when it has no content.
 *
 *  This property applies a color to the lower edge of the control. The default value for this property is a white color. This value is also applied to the placeholder color.
 */
@property (strong, nonatomic) UIColor *inactiveColor;

/**
 *  The color of the border when it has content.
 *
 *  This property applies a color to the lower edge of the control. The default value for this property is a shallow red color.
 */
@property (strong, nonatomic) UIColor *activeColor;

/**
 *  The scale of the placeholder font.
 *
 *  This property determines the size of the placeholder label relative to the font size of the text field.
 */
@property (nonatomic) CGFloat placeholderFontScale;

@end
