//
//  RuriTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/29/16.
//  Copyright © 2016 Cokile. All rights reserved.
//


#import "RuriTextField.h"

@interface RuriTextField ()

@property (strong, nonatomic) CALayer *borderLayer;

@end

@implementation RuriTextField

#pragma mark - Constants
static CGFloat const borderActiveThickness = 1;
static CGFloat const borderInactiveThickness = 3;
static CGPoint const textFieldInsets = {6, 6};
static CGPoint const placeholderInsets = {6, 6};

#pragma mark - Custom accessory
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self updatePlaceholder];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    [self updateBorder];
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
    [self updatePlaceholder];
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.borderLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.4118 green:0.4118 blue:0.4118 alpha:1.0];
        self.borderColor = [UIColor colorWithRed:0.7137 green:0.7647 blue:0.6745 alpha:1];
        self.cursorColor = [UIColor whiteColor];
        self.textColor = self.cursorColor;
        self.activeColor = [UIColor colorWithRed:0.6392 green:0.8275 blue:0.6118 alpha:1];
        
        self.placeholderFontScale = 0.8;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    self.placeholderLabel.frame = CGRectInset(frame, placeholderInsets.x, placeholderInsets.y);
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    
    [self updateBorder];
    [self updatePlaceholder];
    
    [self.layer addSublayer:self.borderLayer];
    [self addSubview:self.placeholderLabel];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset([self rectForBorderBounds:bounds], textFieldInsets.x, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset([self rectForBorderBounds:bounds], textFieldInsets.x, 0);
}

- (void)animateViewsForTextEntry {
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform translate = CGAffineTransformMakeTranslation(-placeholderInsets.x, self.placeholderLabel.bounds.size.height + (placeholderInsets.y*2));
        CGAffineTransform scale = CGAffineTransformMakeScale(0.9, 0.9);
        self.placeholderLabel.transform = CGAffineTransformConcat(translate, scale);
        self.placeholderLabel.textColor = self.activeColor;
        self.borderLayer.borderColor = self.activeColor.CGColor;
        
        CGRect rect = [self rectForBorderBounds:self.bounds];
        self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(rect)-borderActiveThickness, CGRectGetWidth(rect), borderActiveThickness);
    } completion:^(BOOL finished) {
        if (self.didBeginEditingHandler != nil) {
            self.didBeginEditingHandler();
        }
    }];
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.placeholderLabel.transform = CGAffineTransformIdentity;
            self.placeholderLabel.textColor = self.placeholderColor;
            self.borderLayer.borderColor = self.borderColor.CGColor;
            
            CGRect rect = [self rectForBorderBounds:self.bounds];
            self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(rect)-borderInactiveThickness, CGRectGetWidth(rect), borderInactiveThickness);
        } completion:^(BOOL finished) {
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methods
- (void)updateBorder {
    CGRect rect = [self rectForBorderBounds:self.bounds];
    
    self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(rect)-borderInactiveThickness, CGRectGetWidth(rect), borderInactiveThickness);
    self.borderLayer.borderColor = self.borderColor.CGColor;
    self.borderLayer.borderWidth = borderInactiveThickness;
}

- (CGFloat)percentageForBottomBorder {
    CGRect borderRect = [self rectForBorderBounds:self.bounds];
    CGFloat sumOfSides = (borderRect.size.width*2) + (borderRect.size.height*2);
    return (borderRect.size.width*100 / sumOfSides) / 100;
}

- (void)updatePlaceholder {
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
    [self.placeholderLabel sizeToFit];
    [self layoutPlaceholderInTextRect];
    
    if ([self isFirstResponder] || self.text.length!=0) {
        [self animateViewsForTextEntry];
    }
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

- (CGRect)rectForBorderBounds:(CGRect)bounds {
    return CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.font.lineHeight-textFieldInsets.y);
}

- (void)layoutPlaceholderInTextRect {
    self.placeholderLabel.transform = CGAffineTransformIdentity;
    
    CGRect textRect = [self textRectForBounds:self.bounds];
    CGFloat originX = textRect.origin.x;
    
    switch (self.textAlignment) {
        case NSTextAlignmentCenter:
            originX += textRect.size.width/2-self.placeholderLabel.bounds.size.width/2;
            break;
        case NSTextAlignmentRight:
            originX += textRect.size.width-self.placeholderLabel.bounds.size.width;
            break;
        default:
            break;
    }
    
    self.placeholderLabel.frame = CGRectMake(originX, CGRectGetHeight(textRect)-CGRectGetHeight(self.placeholderLabel.bounds)-placeholderInsets.y, CGRectGetWidth(self.placeholderLabel.bounds), CGRectGetHeight(self.placeholderLabel.bounds));
}

@end

