//
//  AkiraTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "AkiraTextField.h"

@interface AkiraTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (nonatomic) CGFloat placeholderHeight;

@end

@implementation AkiraTextField

#pragma mark - Constants
static CGFloat const activeSize = 1.2;
static CGFloat const inactiveSize = 2.5;
static CGPoint const textFieldInsets = {6, 0};
static CGPoint const placeHolderInsets = {6, 0};

#pragma mark - Custom accessorys
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    [self updateBorder];
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
}

- (CGFloat)placeholderHeight {
    return placeHolderInsets.y + [self placeholderFontFromFont:self.font].lineHeight;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.borderLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.borderColor = [UIColor colorWithRed:0.4118 green:0.4157 blue:0.4314 alpha:1.0];
        self.placeholderColor = [UIColor colorWithRed:0.8 green:0.3765 blue:0.3333 alpha:1.0];
        self.cursorColor = self.borderColor;
        self.textColor = [UIColor colorWithRed:0.6667 green:0.6667 blue:0.6667 alpha:1.0];
        
        self.placeholderFontScale = 0.7;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    [self updateBorder];
    [self updatePlaceholder];
    
    [self addSubview:self.placeholderLabel];
    [self.layer addSublayer:self.borderLayer];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if ([self isFirstResponder] || self.text.length!=0) {
        return CGRectMake(placeHolderInsets.x, placeHolderInsets.y, bounds.size.width, self.placeholderHeight);
    } else {
        return [self textRectForBounds:bounds];
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y+self.placeholderHeight/2);
}

- (void)animateViewsForTextEntry {
    [UIView animateWithDuration:0.35 animations:^{
        [self updateBorder];
        [self updatePlaceholder];
    } completion:^(BOOL finished) {
        if (self.didBeginEditingHandler != nil) {
            self.didBeginEditingHandler();
        }
    }];
}

- (void)animateViewsForTextDisplay {
    [UIView animateWithDuration:0.35 animations:^{
        [self updateBorder];
        [self updatePlaceholder];
    } completion:^(BOOL finished) {
        if (self.didEndEditingHandler != nil) {
            self.didEndEditingHandler();
        }
    }];
}

#pragma mark - Private methods
- (void)updateBorder {
    self.borderLayer.frame = [self rectForBounds:self.bounds];
    self.borderLayer.borderWidth = ([self isFirstResponder] || self.text.length!=0)?activeSize:inactiveSize;
    self.borderLayer.borderColor = self.borderColor.CGColor;
}

- (void)updatePlaceholder {
    self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    self.placeholderLabel.textColor = self.placeholderColor;
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

- (CGRect)rectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y+self.placeholderHeight, bounds.size.width, bounds.size.height-self.placeholderHeight);
}

@end
