//
//  JiroTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/26/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "JiroTextField.h"

@interface JiroTextField ()

@property (strong, nonatomic) CALayer *borderLayer;

@end

@implementation JiroTextField

#pragma mark - Constant
static CGFloat const borderThickness = 2;
static CGPoint const textFieldInsets = {8, 12};
static CGPoint const placeholderInsets = {8, 8};

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
    [self updatePlaceholder];
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.borderLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.borderColor = [UIColor colorWithRed:0.4157 green:0.4745 blue:0.5373 alpha:1.0];
        self.placeholderColor = self.borderColor;
        self.cursorColor = [UIColor colorWithRed:0.8275 green:0.8862 blue:0.8862 alpha:1.0];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.65;        
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
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectOffset(bounds, textFieldInsets.x, textFieldInsets.y);
}

- (void)animateViewsForTextEntry {
    self.borderLayer.frame= CGRectMake(0, self.font.lineHeight, CGRectGetWidth(self.borderLayer.frame), CGRectGetHeight(self.borderLayer.frame));
    
    [UIView animateWithDuration:0.2 delay:0.3 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.placeholderLabel.frame = CGRectMake(placeholderInsets.x, self.borderLayer.frame.origin.y-self.placeholderLabel.bounds.size.height, CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
        self.borderLayer.frame = [self rectForBorderThickness:borderThickness isFilled:YES];
    } completion:^(BOOL finished) {
        if (self.didBeginEditingHandler != nil) {
            self.didBeginEditingHandler();
        }
    }];
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:2.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [self layoutPlaceholderInTextRect];
            self.placeholderLabel.alpha = 1;
        } completion:^(BOOL finished) {
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
        
        self.borderLayer.frame = [self rectForBorderThickness:borderThickness isFilled:NO];
    }
}

#pragma mark - Private methods
- (void)updateBorder {
    self.borderLayer.frame = [self rectForBorderThickness:borderThickness isFilled:NO];
    self.borderLayer.backgroundColor = self.borderColor.CGColor;
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
    UIFont *smallerFont = [UIFont fontWithName:self.font.fontName size:self.font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

- (CGRect)rectForBorderThickness:(CGFloat)thickness isFilled:(BOOL)isFilled {
    if (isFilled) {
        return CGRectMake(0, self.placeholderLabel.frame.origin.y+self.placeholderLabel.font.lineHeight, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    } else {
        return CGRectMake(0, CGRectGetHeight(self.frame)-thickness, CGRectGetWidth(self.frame), thickness);
    }
}

- (void)layoutPlaceholderInTextRect {
    if (self.text.length != 0) {
        return;
    }
    
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
    
    self.placeholderLabel.frame = CGRectMake(originX, textRect.size.height/2, CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
}

@end
