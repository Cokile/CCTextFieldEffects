//
//  MinoruTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/28/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "MinoruTextField.h"
#import "PulsingHaloLayer.h"

@interface MinoruTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (strong, nonatomic) UIColor *backgroundLayerColor;
@property (strong, nonatomic) PulsingHaloLayer *halo;

@end

@implementation MinoruTextField

#pragma mark - Constants
static CGFloat const borderThickness = 2;
static CGPoint const placeholderInsets = {6, 6};
static CGPoint const textFieldInsets = {14, 6};
static CGPoint const shadowInsets = {7, 8};

#pragma mark - Custom accessorys
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self updatePlaceholder];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.borderLayer.borderColor = borderColor.CGColor;
    self.halo.backgroundColor = borderColor.CGColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundLayerColor = backgroundColor;
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
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.4157 green:0.4745 blue:0.5373 alpha:1];
        self.backgroundColor = [UIColor whiteColor];
        self.borderColor = [UIColor colorWithRed:0.9255 green:0.6353 blue:0.6078 alpha:1];
        self.cursorColor = [UIColor colorWithRed:0.9255 green:0.6353 blue:0.6078 alpha:1];
        self.textColor = self.cursorColor;
        
        self.halo = [PulsingHaloLayer layer];
        self.halo.repeatCount = 1;
        self.halo.animationDuration = 0.4;
        self.halo.radius = CGRectGetHeight(frame);
        self.halo.backgroundColor = self.borderColor.CGColor;
        [self.layer addSublayer:self.halo];
        
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
    CGRect newBounds = [self rectForBorderBounds:bounds];
    
    return CGRectInset(newBounds, textFieldInsets.x, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = [self rectForBorderBounds:bounds];
    
    return CGRectInset(newBounds, textFieldInsets.x, 0);
}

- (void)animateViewsForTextEntry {
    [UIView animateWithDuration:0.35 animations:^{
        self.borderLayer.borderWidth = borderThickness;
        self.borderLayer.borderColor = self.borderColor.CGColor;
        
        self.halo.frame = self.borderLayer.frame;
        [self.halo startAnimation];
    } completion:^(BOOL finished) {
        if (self.didBeginEditingHandler != nil) {
            self.didBeginEditingHandler();
        }
    }];
}

- (void)animateViewsForTextDisplay {
    [UIView animateWithDuration:0.35 animations:^{
        self.borderLayer.borderWidth = 0;
    } completion:^(BOOL finished) {
        if (self.didEndEditingHandler != nil) {
            self.didEndEditingHandler();
        }
    }];
}

#pragma mark - Private methods
- (void)updateBorder {
    self.borderLayer.frame = [self rectForBorderBounds:self.frame];
    self.borderLayer.backgroundColor = self.backgroundColor.CGColor;
}

- (void)updatePlaceholder {
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
    [self.placeholderLabel sizeToFit];
    [self layoutPlaceholderInTextRect];
    
    if ([self isFirstResponder]) {
        [self animateViewsForTextEntry];
    }
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    return [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
}

- (CGRect)rectForBorderBounds:(CGRect)bounds {
    return CGRectMake(shadowInsets.x, shadowInsets.y, CGRectGetWidth(bounds)-shadowInsets.x*2, CGRectGetHeight(bounds)-self.font.lineHeight-placeholderInsets.y);
}

- (void)layoutPlaceholderInTextRect {
    self.placeholderLabel.frame = CGRectMake(placeholderInsets.x+shadowInsets.x, CGRectGetHeight(self.bounds)-CGRectGetHeight(self.placeholderLabel.frame), CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
}

@end
