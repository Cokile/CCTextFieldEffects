//
//  IsaoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "IsaoTextField.h"

@interface IsaoTextField ()

@property (strong, nonatomic) CALayer *borderLayer;

@end

@implementation IsaoTextField

#pragma mark - Constants
static CGFloat const activeBorderThickness = 4;
static CGFloat const inactiveBorderThickness = 2;
static CGPoint const textFieldInsets = {6, 6};
static CGPoint const placeholderInsets = {6, 6};

#pragma mark - Custom accessorys
- (void)setInactiveColor:(UIColor *)inactiveColor {
    _inactiveColor = inactiveColor;
    
    [self updateBorder];
}

- (void)setActiveColor:(UIColor *)activeColor {
    _activeColor = activeColor;
    
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
        
        self.inactiveColor = [UIColor colorWithRed:0.8549 green:0.8549 blue:0.8549 alpha:1.0];
        self.activeColor = [UIColor colorWithRed:0.8549 green:0.4392 blue:0.4431 alpha:1.0];
        self.placeholderLabel.textColor = self.inactiveColor;
        self.cursorColor = [UIColor colorWithRed:0.6863 green:0.702 blue:0.7216 alpha:1.0];
        self.textColor = [UIColor colorWithRed:0.6863 green:0.702 blue:0.7216 alpha:1.0];
        
        self.placeholderFontScale = 0.7;        
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    CGRect frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    self.placeholderLabel.frame = CGRectInset(frame, placeholderInsets.x, placeholderInsets.y);
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    
    [self updateBorder];
    [self updatePlaceholder];
    
    [self.layer addSublayer:self.borderLayer];
    [self addSubview:self.placeholderLabel];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height-self.font.lineHeight+textFieldInsets.y);
    
    return CGRectInset(newBounds, textFieldInsets.x, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height-self.font.lineHeight+textFieldInsets.y);
    
    return CGRectInset(newBounds, textFieldInsets.x, 0);
}

- (void)animateViewsForTextEntry {
    [self updateBorder];
    [self performPlacerholderAnimation];
    
    self.placeholderLabel.textColor = self.activeColor;
}

- (void)animateViewsForTextDisplay {
    [self updateBorder];
    
    [self performPlacerholderAnimation];
    
    self.placeholderLabel.textColor = self.inactiveColor;
}

#pragma mark - Private methods
- (void)updateBorder {
    self.borderLayer.frame = [self rectForBorderBounds:self.frame];
    self.borderLayer.backgroundColor = [self isFirstResponder]?self.activeColor.CGColor:self.inactiveColor.CGColor;
}

- (void)updatePlaceholder {
    self.placeholderLabel.text = self.placeholder;
    [self.placeholderLabel sizeToFit];
    
    [self layoutPlaceholderInTextRect];
    
    if ([self isFirstResponder]) {
        [self animateViewsForTextEntry];
    }
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:self.font.fontName size:self.font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

- (CGRect)rectForBorderBounds:(CGRect)bounds {
    CGRect newRect;
    
    if ([self isFirstResponder]) {
        newRect = CGRectMake(0, bounds.size.height-self.font.lineHeight+textFieldInsets.y-activeBorderThickness, bounds.size.width, activeBorderThickness);
    } else {
        newRect = CGRectMake(0, bounds.size.height-self.font.lineHeight+textFieldInsets.y-inactiveBorderThickness, bounds.size.width, inactiveBorderThickness);
    }
    
    return newRect;
}

- (void)layoutPlaceholderInTextRect {
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
    
    self.placeholderLabel.frame = CGRectMake(originX, self.bounds.size.height-self.placeholderLabel.frame.size.height, self.placeholderLabel.frame.size.width, self.placeholderLabel.frame.size.height);
}

- (void)performPlacerholderAnimation {
    CGFloat yOffset = 4;
    
    [UIView animateWithDuration:0.15 animations:^{
        self.placeholderLabel.transform = CGAffineTransformMakeTranslation(0, -yOffset);
        self.placeholderLabel.alpha = 0;
    } completion:^(BOOL finished){
        self.placeholderLabel.transform = CGAffineTransformIdentity;
        self.placeholderLabel.transform = CGAffineTransformMakeTranslation(0, yOffset);
        
        [UIView animateWithDuration:0.15 animations:^{
            self.placeholderLabel.transform = CGAffineTransformIdentity;
            self.placeholderLabel.alpha = 1;
        } completion:^(BOOL finished) {
            if ([self isFirstResponder] && self.didBeginEditingHandler!= nil) {
                self.didBeginEditingHandler();
            } else if (![self isFirstResponder] && self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }];
}

@end
