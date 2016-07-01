//
//  YokoTextField.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/26/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "YokoTextField.h"

@interface YokoTextField ()

@property (strong, nonatomic) UIView *foregroundView;
@property (strong, nonatomic) CALayer *foregroundLayer;

@end

@implementation YokoTextField

#pragma mark - Constants
static CGFloat const borderThickness = 3;
static CGPoint const textFieldInsets = {6, 6};
//static CGPoint const placeholderInsets = {6, 6};

#pragma mark - Custom accessorys
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    [self updatePlaceholder];
}

- (void)setForegroundColor:(UIColor *)foregroundColor {
    _foregroundColor = foregroundColor;
    
    [self updateForeground];
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
    
    [self updateForeground];
    [self updatePlaceholder];
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.foregroundView = [[UIView alloc] init];
        self.foregroundLayer = [[CALayer alloc] init];
        self.placeholderLabel = [[UILabel alloc] init];
        
        self.placeholderColor = [UIColor colorWithRed:0.6902 green:0.2941 blue:0.2501 alpha:1.0];
        self.foregroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        self.cursorColor = [UIColor colorWithRed:0.9608 green:0.9608 blue:0.9608 alpha:1.0];
        self.textColor = self.cursorColor;
        
        self.placeholderFontScale = 0.7;        
    }
    
    return self;
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    [self updateForeground];
    [self updatePlaceholder];
    
    [self addSubview:self.foregroundView];
    [self addSubview:self.placeholderLabel];
    [self.layer addSublayer:self.foregroundLayer];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.font.lineHeight+textFieldInsets.y);
    
    return CGRectInset(newBounds, textFieldInsets.x, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect newBounds = CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.font.lineHeight+textFieldInsets.y);
    
    return CGRectInset(newBounds, textFieldInsets.x, 0);
}

- (void)animateViewsForTextEntry {
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.foregroundView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        if (self.didBeginEditingHandler != nil) {
            self.didBeginEditingHandler();
        }
    }];
    
    self.foregroundLayer.frame = [self rectForBorderBounds:self.foregroundView.frame isFilled:NO];
}

- (void)animateViewsForTextDisplay {
    if (self.text.length == 0) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:0.6 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.foregroundLayer.frame = [self rectForBorderBounds:self.foregroundView.frame isFilled:YES];
            self.foregroundView.layer.transform = [self rotationAndPerspectiveTransformForView:self.foregroundView];
        } completion:^(BOOL finished) {
            if (self.didEndEditingHandler != nil) {
                self.didEndEditingHandler();
            }
        }];
    }
}

#pragma mark - Private methods
- (void)updatePlaceholder {
    self.placeholderLabel.font = [self placeholderFontFromFont:self.font];
    self.placeholderLabel.text = self.placeholder;
    self.placeholderLabel.textColor = self.placeholderColor;
    [self.placeholderLabel sizeToFit];
    [self layoutPlaceholderInTextRect];
    
    if ([self isFirstResponder] || self.text.length!=0) {
        [self animateViewsForTextEntry];
    }
}

- (void)updateForeground {
    self.foregroundView.frame = [self rectForForegroundBounds:self.frame];
    self.foregroundView.userInteractionEnabled = NO;
    self.foregroundView.layer.transform = [self rotationAndPerspectiveTransformForView:self.foregroundView];
    self.foregroundView.backgroundColor = [self colorWithColor:self.foregroundColor alphaFactor:0.5];
    
    self.foregroundLayer.frame = [self rectForBorderBounds:self.foregroundView.frame isFilled:YES];
    self.foregroundLayer.borderWidth = borderThickness;
    self.foregroundLayer.borderColor = [self colorWithColor:self.foregroundColor alphaFactor:0.5].CGColor;
}

- (UIFont *)placeholderFontFromFont:(UIFont *)font {
    UIFont *smallerFont = [UIFont fontWithName:font.fontName size:font.pointSize*self.placeholderFontScale];
    
    return smallerFont;
}

- (CGRect)rectForForegroundBounds:(CGRect)bounds {
    return CGRectMake(0, 0, CGRectGetWidth(bounds), CGRectGetHeight(bounds)-self.font.lineHeight+textFieldInsets.y-borderThickness);
}

- (CGRect)rectForBorderBounds:(CGRect)bounds isFilled:(BOOL)isFilled {
    CGRect newRect = CGRectMake(0, CGRectGetHeight(bounds), CGRectGetWidth(bounds), isFilled?borderThickness:0);
    
    if (!CATransform3DIsIdentity(self.foregroundView.layer.transform)) {
        newRect = CGRectMake(0, bounds.origin.y, CGRectGetWidth(newRect), CGRectGetHeight(newRect));
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
    
    self.placeholderLabel.frame = CGRectMake(originX, CGRectGetHeight(self.bounds)-CGRectGetHeight(self.placeholderLabel.frame), CGRectGetWidth(self.placeholderLabel.frame), CGRectGetHeight(self.placeholderLabel.frame));
}

- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint newPoint = CGPointMake(CGRectGetWidth(view.bounds)*anchorPoint.x, CGRectGetHeight(view.bounds)*anchorPoint.y);
    CGPoint oldPoint = CGPointMake(CGRectGetWidth(view.bounds)*view.layer.anchorPoint.x, CGRectGetHeight(view.bounds)*view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
}

- (UIColor *)colorWithColor:(UIColor *)color alphaFactor:(CGFloat)factor {
    CGFloat hue = 0;
    CGFloat saturation = 0;
    CGFloat brightness = 0;
    CGFloat alpha = 0;
    
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha*factor];
    } else {
        return color;
    }
}

- (CATransform3D)rotationAndPerspectiveTransformForView:(UIView *)view {
    [self setAnchorPoint:CGPointMake(0.5, 1.0) forView:view];
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0/800;
    CGFloat radians = -90/180.0*M_PI;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, radians, 1.0, 0.0, 0.0);
    return rotationAndPerspectiveTransform;
}

@end
