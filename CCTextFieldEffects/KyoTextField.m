//
//  KyoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/28/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "KyoTextField.h"

@interface KyoTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (strong, nonatomic) UIColor *backgroundLayerColor;
@property (strong, nonatomic) UIView *overlayView;
@property (nonatomic) NSUInteger index;

@end

@implementation KyoTextField

#pragma mark - Constants
static CGPoint const placeholderInsets = {1, 3};
static CGPoint const textFieldInsets = {1, 6};

#pragma mark - Custom accessorys
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self updatePlaceholder];
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
        self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.borderLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.4157 green:0.4745 blue:0.5373 alpha:1];
        self.overlayColor  = [UIColor colorWithRed:0.2392 green:0.3451 blue:0.8235 alpha:0.6];
        self.backgroundColor = [UIColor whiteColor];
        self.cursorColor = [UIColor colorWithRed:0.3255 green:0.3647 blue:0.5725 alpha:1];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.85;
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
    
    return CGRectInset(newBounds, textFieldInsets.x+self.borderLayer.cornerRadius, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = [self rectForBorderBounds:bounds];
    
    return CGRectInset(newBounds, textFieldInsets.x+self.borderLayer.cornerRadius, 0);
}

- (void)animateViewsForTextEntry {
    if (self.superview != nil) {
        self.index = [self.superview.subviews indexOfObject:self];
        self.overlayView.backgroundColor = self.overlayColor;
        self.overlayView.alpha = 0;
        
        [UIView animateWithDuration:0.35 animations:^{
            self.overlayView.alpha = [self alphaForColor:self.overlayColor];
            [self.superview addSubview:self.overlayView];
            [self.superview bringSubviewToFront:self];
            self.placeholderLabel.textColor = self.backgroundColor;
        } completion:^(BOOL finished) {
            if (self.didBeginEditingHandler != nil) {
                self.didBeginEditingHandler();
            }
        }];
    }
}

- (void)animateViewsForTextDisplay {
    if (self.superview) {
        [UIView animateWithDuration:0.35 animations:^{
            self.overlayView.alpha = 0;
            self.placeholderLabel.textColor = self.placeholderColor;
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
            [self.superview insertSubview:self atIndex:self.index];
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methods
- (void)updateBorder {
    self.borderLayer.frame = [self rectForBorderBounds:self.frame];
    self.borderLayer.cornerRadius = CGRectGetHeight(self.borderLayer.frame)/2;
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
    return CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.font.lineHeight-placeholderInsets.y);
}

- (void)layoutPlaceholderInTextRect {
    self.placeholderLabel.frame = CGRectMake(placeholderInsets.x+self.borderLayer.cornerRadius, CGRectGetHeight(self.bounds)-CGRectGetHeight(self.placeholderLabel.frame), CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
}

- (CGFloat)alphaForColor:(UIColor *)color {
    CGFloat alpha;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        return alpha;
    } else {
        return 1;
    }
}

@end
