//
//  CCTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Closure executed when an animation has been completed
 *
 *  @param type The type of animatino a TextFieldEffect can perform.
 */
typedef void(^AnimationCompletionHandler)(void);

@interface CCTextField : UITextField

#pragma mark - Public properties
/**
 *  UIColor that indicates the cursorColor.
 */
@property (strong, nonatomic) UIColor *cursorColor;

/**
 *  UILabel that holds all the placeholder information.
 */
@property (strong, nonatomic) UILabel *placeholderLabel;

/**
 *  Block executed when the animation for obtaining focus has been completed.
 */
@property (copy, nonatomic) AnimationCompletionHandler didBeginEditingHandler;

/**
 *  Block executed when the animation for losing focus has been completed.
 */
@property (copy, nonatomic) AnimationCompletionHandler didEndEditingHandler;

#pragma mark - Public methods
/**
 *  Creates all the animations that are used to leave the textfield in the "entering text" state.
 */
- (void)animateViewsForTextEntry;

/**
 *  Creates all the animations that are used to leave the textfield in the "display input text" state.
 */
- (void)animateViewsForTextDisplay;

- (void)updateViewsForBoundsChange:(CGRect)bounds;

@end
