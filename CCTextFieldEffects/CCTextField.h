//
//  CCTextField.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  The type of animatino a TextFieldEffect can perform.
 */
typedef NS_ENUM(NSInteger, CCAnimationType) {
    /**
     *  Animation that takes effect when the textfield has focus.
     */
    CCAnimationTypeTextEntry,
    /**
     *  Animation that takes effect when the textfield loses focus.
     */
    CCAnimationTypeTextDisplay
};

/**
 *  Closure executed when an animation has been completed
 *
 *  @param type The type of animatino a TextFieldEffect can perform.
 */
typedef void(^AnimationCompletionHandler)(CCAnimationType type);

@interface CCTextField : UITextField <UITextFieldDelegate>

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
 *  Block executed when the animation for having focus has been completed.
 */
@property (copy, nonatomic) AnimationCompletionHandler animationCompletionHandler;

#pragma mark - Public methods
- (void)updateViewsForBoundsChange:(CGRect)bounds;

@end
