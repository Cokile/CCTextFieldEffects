//
//  DetailViewController.h
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCTextFieldEffects.h"

@interface DetailViewController : UIViewController

@property (nonatomic) CGFloat red;
@property (nonatomic) CGFloat green;
@property (nonatomic) CGFloat blue;

@property (strong, nonatomic) CCTextField *tf1;
@property (strong, nonatomic) CCTextField *tf2;

@end
