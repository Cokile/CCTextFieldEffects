//
//  YoshikoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/26/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "YoshikoTextField.h"

@interface YoshikoTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (nonatomic) CGFloat placeholderHeight;

@end

@implementation YoshikoTextField

#pragma mark - Constants
static CGFloat const borderSize = 2;
static CGPoint const textFieldInsets = {6, 0};
static CGPoint const placeholderInsets = {6, 0};

#pragma mark - Custom accessorys
- (void)setActiveBorderColor:(UIColor *)activeBorderColor {
    _activeBorderColor = activeBorderColor;
    [self updateBorder];
    [self updateBackground];
    [self updatePlaceholder];
}

- (void)setInactiveBorderColor:(UIColor *)inactiveBorderColor {
    _inactiveBorderColor = inactiveBorderColor;
    
    [self updateBorder];
    [self updateBackground];
    [self updatePlaceholder];
}

- (void)setActiveBackgroundColor:(UIColor *)activeBackgroundColor {
    _activeBackgroundColor = activeBackgroundColor;
    
    [self updateBackground];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self updatePlaceholder];
}

- (void)setPlaceholderFontScale:(CGFloat)placeholderFontScale {
    _placeholderFontScale = placeholderFontScale;
    
    [self updatePlaceholder];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    
    [self updatePlaceholder];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    [self updateBorder];
    [self updateBackground];
    [self updatePlaceholder];
}

- (CGFloat)placeholderHeight {
    return placeholderInsets.y + [self placeholderFontFromFont:self.font percentageOfOriginalSize:self.placeholderFontScale].lineHeight;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.borderLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.5451 green:0.5490 blue:0.5490 alpha:1];
        self.inactiveBorderColor = [UIColor colorWithRed:0.8157 green:0.8196 blue:0.8157 alpha:1];
        self.activeBorderColor = [UIColor colorWithRed:0.6392 green:0.8275 blue:0.6118 alpha:1];
        self.activeBackgroundColor = [UIColor colorWithRed:0.9765 green:0.9686 blue:0.9647 alpha:1];
        self.cursorColor = [UIColor colorWithRed:0.6666 green:0.6666 blue:0.6666 alpha:1];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.7;        
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    [self updateBorder];
    [self updateBackground];
    [self updatePlaceholder];
    
    [self.layer addSublayer:self.borderLayer];
    [self addSubview:self.placeholderLabel];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if ([self isFirstResponder] || self.text.length!=0) {
        return CGRectMake(placeholderInsets.x, placeholderInsets.y, CGRectGetWidth(bounds), self.placeholderHeight);
    } else {
        return [self textRectForBounds:self.bounds];
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y+self.placeholderHeight/2);
}

- (void)prepareForInterfaceBuilder {
    self.placeholderLabel.alpha = 1;
}

- (void)animateViewsForTextEntry {
    [self animateViews];
}

- (void)animateViewsForTextDisplay {
    [self animateViews];
}

#pragma mark - Private methods
- (void)animateViews {
    [UIView animateWithDuration:0.2 animations:^{
        // Prevents a "flash" in the placeholder
        if (self.text.length == 0) {
            self.placeholderLabel.alpha = 0;
        }
        
        self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
    } completion:^(BOOL finished) {
        [self updatePlaceholder];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.placeholderLabel.alpha = 1;
            [self updateBorder];
            [self updateBackground];
        } completion:^(BOOL finished) {
            if ([self isFirstResponder] && self.didBeginEditingHandler != nil) {
                self.didBeginEditingHandler();
            } else if (![self isFirstResponder] && self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }];
}

- (void)updateBorder {
    self.borderLayer.frame = [self rectForBounds:self.bounds];
    self.borderLayer.borderWidth = borderSize;
    self.borderLayer.borderColor = [self isFirstResponder] || self.text.length!=0?self.activeBorderColor.CGColor:self.inactiveBorderColor.CGColor;
}

- (void)updateBackground {
    if ([self isFirstResponder] || self.text.length!=0) {
        self.borderLayer.backgroundColor = self.activeBackgroundColor.CGColor;
    } else {
        self.borderLayer.backgroundColor = self.inactiveBorderColor.CGColor;
    }
}

- (void)updatePlaceholder {
    self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textAlignment = self.textAlignment;
    
    if ([self isFirstResponder] || self.text.length!=0) {
        self.placeholderLabel.font = [self placeholderFontFromFont:self.font percentageOfOriginalSize:self.placeholderFontScale*0.8];
        self.placeholderLabel.text = self.placeholder.uppercaseString;
        self.placeholderLabel.textColor = self.activeBorderColor;
    } else {
        self.placeholderLabel.font = [self placeholderFontFromFont:self.font percentageOfOriginalSize:self.placeholderFontScale];
        self.placeholderLabel.textColor = self.placeholderColor;
    }
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font percentageOfOriginalSize:(CGFloat)presentage {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*presentage];
    
    return smallerFont;
}

- (CGRect)rectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y+self.placeholderHeight, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.placeholderHeight);
}

@end
