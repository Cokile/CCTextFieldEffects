//
//  ManamiTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/30/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ManamiTextField.h"

@interface ManamiTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (strong, nonatomic) CALayer *backgroundLayer;
@property (strong, nonatomic) UIColor *backgroundLayerColor;

@end

@implementation ManamiTextField

#pragma mark - Constants
static CGFloat const borderThickness = 1.5;
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

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundLayerColor = backgroundColor;
    
    self.backgroundLayer.backgroundColor = backgroundColor.CGColor;
}

- (UIColor *)backgroundColor {
    return self.backgroundLayerColor;
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
        self.backgroundLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.4118 green:0.4118 blue:0.4118 alpha:1.0];
        self.borderColor = [UIColor colorWithRed:0.6588 green:0.6588 blue:0.6588 alpha:1];
        self.backgroundColor = self.borderColor;
        self.cursorColor = [UIColor colorWithRed:0.9765 green:0.9686 blue:0.9647 alpha:1];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.9;
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
    
    CGRect backgroundRect = [self editingRectForBounds:self.bounds];
    self.backgroundLayer.frame = CGRectMake(0, backgroundRect.origin.y, CGRectGetWidth(backgroundRect), 0);
    [self.layer addSublayer:self.backgroundLayer];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset([self rectForBorderBounds:bounds], textFieldInsets.x, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset([self rectForBorderBounds:bounds], textFieldInsets.x, 0);
}

- (void)animateViewsForTextEntry {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGAffineTransform translate = CGAffineTransformMakeTranslation(-placeholderInsets.x, self.placeholderLabel.bounds.size.height + (placeholderInsets.y*2));
            CGAffineTransform scale = CGAffineTransformMakeScale(0.9, 0.9);
            self.placeholderLabel.transform = CGAffineTransformConcat(translate, scale);
            self.placeholderLabel.alpha = 0.4;
            
            CGRect backgroundRect = [self editingRectForBounds:self.bounds];
            self.backgroundLayer.frame = CGRectMake(0, backgroundRect.origin.y, CGRectGetWidth(backgroundRect), CGRectGetHeight(backgroundRect));
            
            self.borderLayer.opacity = 0;
        } completion:^(BOOL finished) {
            if (self.didBeginEditingHandler != nil) {
                self.didBeginEditingHandler();
            }
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.placeholderLabel.transform = CGAffineTransformIdentity;
            self.placeholderLabel.alpha = 1;
            
            CGRect backgroundRect = [self editingRectForBounds:self.bounds];
            self.backgroundLayer.frame = CGRectMake(0, backgroundRect.origin.y, CGRectGetWidth(backgroundRect), 0);
            
            self.borderLayer.opacity = 1;
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
    self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(rect), CGRectGetWidth(rect), borderThickness);
    self.borderLayer.borderWidth = borderThickness;
    self.borderLayer.borderColor = self.borderColor.CGColor;
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


