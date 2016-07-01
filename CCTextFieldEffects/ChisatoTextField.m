//
//  ChisatoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/29/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ChisatoTextField.h"

@interface ChisatoTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (nonatomic) CGFloat placeholderHeight;

@end

@implementation ChisatoTextField

#pragma mark - Constants
static CGFloat const borderSize = 2.5;
static CGPoint const textFieldInsets = {8, 0};
static CGPoint const placeHolderInsets = {8, 0};

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
        
        self.borderColor = [UIColor colorWithRed:0.7098 green:0.7098 blue:0.7098 alpha:1.0];
        self.placeholderColor = self.borderColor;
        self.cursorColor = self.borderColor;
        self.textColor = self.borderColor;
        self.activeColor = [UIColor colorWithRed:0.8549 green:0.3922 blue:0.5176 alpha:1];
        
        self.placeholderFontScale = 0.8;
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
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.1 animations:^{
            self.placeholderLabel.frame = CGRectOffset(self.placeholderLabel.frame, 0, self.placeholderHeight*2);
            self.borderLayer.borderColor = self.activeColor.CGColor;
        } completion:^(BOOL finished) {
            self.placeholderLabel.alpha = 0;
            self.placeholderLabel.frame = CGRectOffset([self placeholderRectForBounds:self.bounds], 0, -self.placeholderHeight*2);
            [UIView animateWithDuration:0.15 animations:^{
                self.placeholderLabel.textColor = self.activeColor;
                self.placeholderLabel.alpha = 1;
                self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
            } completion:^(BOOL finished) {
                if (self.didBeginEditingHandler != nil) {
                    self.didBeginEditingHandler();
                }
            }];
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.15 animations:^{
            self.borderLayer.borderColor = self.borderColor.CGColor;
            self.placeholderLabel.alpha = 0;
        } completion:^(BOOL finished) {
            self.placeholderLabel.textColor = self.placeholderColor;
            self.placeholderLabel.frame = [self placeholderRectForBounds:self.bounds];
            self.placeholderLabel.alpha = 1;
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methods
- (void)updateBorder {
    self.borderLayer.frame = [self rectForBounds:self.bounds];
    self.borderLayer.borderWidth = borderSize;
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

