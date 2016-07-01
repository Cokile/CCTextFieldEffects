//
//  NarikoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/30/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "NarikoTextField.h"

@interface NarikoTextField ()

@property (strong, nonatomic) CALayer *borderLayer;
@property (strong, nonatomic) CALayer *backgroundLayer;
@property (strong, nonatomic) UIColor *backgroundLayerColor;

@end

@implementation NarikoTextField

#pragma mark - Constants
static CGFloat const borderThickness = 2.5;
static CGPoint const textFieldInsets = {10, 6};
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
        self.borderColor = [UIColor colorWithRed:0.6078 green:0.6235 blue:0.6235 alpha:1];
        self.backgroundColor = [UIColor whiteColor];
        self.cursorColor = [UIColor colorWithRed:0.9451 green:0.5098 blue:0.5725 alpha:1];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.85;
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    self.placeholderLabel.frame = CGRectMake(placeholderInsets.x, CGRectGetHeight(rect)-placeholderInsets.y-self.placeholderLabel.font.lineHeight, CGRectGetWidth(rect), placeholderInsets.y+self.placeholderLabel.font.lineHeight);
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    
    [self updateBorder];
    [self updatePlaceholder];
    
    [self.layer addSublayer:self.borderLayer];
    
    self.backgroundLayer.frame = CGRectMake(0,CGRectGetHeight(self.bounds) , CGRectGetWidth(self.bounds), 0);
    [self.layer addSublayer:self.backgroundLayer];
    
    [self addSubview:self.placeholderLabel];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [self textRectForBounds:bounds];
    
    /**
     Basically the return value should euqal to the return value of [self textRectForBounds:bounds] (aka. rect)
     But when you run the code, the editing rect is a little upper than text rect, though their origin.y are euqal.
     I have not figured out the reason, so I make 0.5 offset as a expedient.
     */
    return CGRectOffset(rect, 0, 0.5);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset([self rectForBorderBounds:bounds], textFieldInsets.x, 0);
}

- (void)animateViewsForTextEntry {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect backgroundRect = [self editingRectForBounds:self.bounds];
            self.backgroundLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-CGRectGetHeight(backgroundRect), CGRectGetWidth(self.bounds), CGRectGetHeight(backgroundRect));
            self.borderLayer.frame = CGRectOffset(self.borderLayer.frame, 0, -CGRectGetHeight(self.backgroundLayer.frame));
            
            CGAffineTransform translate = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(self.backgroundLayer.frame)-placeholderInsets.y);
            CGAffineTransform scale = CGAffineTransformMakeScale(0.9, 0.9);
            self.placeholderLabel.transform = CGAffineTransformConcat(translate, scale);
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
            
            self.backgroundLayer.frame = CGRectMake(0,CGRectGetHeight(self.bounds) , CGRectGetWidth(self.bounds), 0);
            self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-borderThickness, CGRectGetWidth(self.bounds), borderThickness);
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
    self.borderLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-borderThickness, CGRectGetWidth(rect), borderThickness);
    self.borderLayer.borderWidth = borderThickness;
    self.borderLayer.borderColor = self.borderColor.CGColor;
}

- (void)updatePlaceholder {
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
    [self.placeholderLabel sizeToFit];
    
    if ([self isFirstResponder] || self.text.length!=0) {
        [self animateViewsForTextEntry];
    }
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

- (CGRect)rectForBorderBounds:(CGRect)bounds {
    return CGRectMake(0, self.font.lineHeight+textFieldInsets.y, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.font.lineHeight-textFieldInsets.y);
}

@end
