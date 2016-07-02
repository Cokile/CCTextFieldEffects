//
//  KaedeTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/26/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "KaedeTextfield.h"

@interface KaedeTextField ()

@property (strong, nonatomic) UIView *foregroundView;

@end

@implementation KaedeTextField

#pragma mark - Constants
static CGPoint const textFieldInsets = {10, 0};
static CGPoint const placeholderInsets = {10, 5};

#pragma mark - Custom accessorys
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self updatePlaceholder];
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    
    [self updateForegroundColor];
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
    
    [self drawRect:bounds];
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.foregroundView = [[UIView alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.4157 green:0.4745 blue:0.5373 alpha:1.0];
        self.foregroundColor = [UIColor colorWithRed:0.9373 green:0.9333 blue:0.9333 alpha:1.0];
        self.cursorColor = [UIColor colorWithRed:0.6157 green:0.6706 blue:0.7294 alpha:1.0];
        self.textColor = self.cursorColor;
        self.backgroundColor = [UIColor whiteColor];
        
        self.placeholderFontScale = 0.8;        
    }
    
    return self;
}

#pragma mark - Overridden methos
- (void)drawRect:(CGRect)rect {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    self.foregroundView.frame = frame;
    self.foregroundView.userInteractionEnabled = NO;
    self.placeholderLabel.frame = CGRectInset(frame, placeholderInsets.x, placeholderInsets.y);
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    
    [self updateForegroundColor];
    [self updatePlaceholder];
    
    if (self.text.length!=0 || [self isFirstResponder]) {
        [self animateViewsForTextEntry];
    }
    
    [self addSubview:self.foregroundView];
    [self addSubview:self.placeholderLabel];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect frame  = CGRectMake(bounds.origin.x, bounds.origin.y, CGRectGetWidth(bounds)*0.6, CGRectGetHeight(bounds));
    
    return CGRectInset(frame, textFieldInsets.x, textFieldInsets.y);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect frame  = CGRectMake(bounds.origin.x, bounds.origin.y, CGRectGetWidth(bounds)*0.6, CGRectGetHeight(bounds));
    
    return CGRectInset(frame, textFieldInsets.x, textFieldInsets.y);
}

- (void)animateViewsForTextEntry {
    [UIView animateWithDuration:0.16 animations:^{
        self.placeholderLabel.frame = CGRectMake(CGRectGetWidth(self.frame)*0.7, placeholderInsets.y, CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
    }];
    
    [UIView animateWithDuration:0.22 animations:^{
        self.foregroundView.frame = CGRectMake(CGRectGetWidth(self.frame)*0.65, 0, CGRectGetWidth(self.foregroundView.frame), CGRectGetHeight(self.foregroundView.frame));
    } completion:^(BOOL finished) {
        if (self.didBeginEditingHandler != nil) {
            self.didBeginEditingHandler();
        }
    }];
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.placeholderLabel.frame = CGRectMake(placeholderInsets.x, placeholderInsets.y, CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
        }];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.foregroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.foregroundView.frame), CGRectGetHeight(self.foregroundView.frame));
        } completion:^(BOOL finished) {
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methos
- (void)updatePlaceholder {
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
}

- (void)updateForegroundColor {
    self.foregroundView.backgroundColor = self.foregroundColor;
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

@end
