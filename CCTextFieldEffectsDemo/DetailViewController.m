//
//  DetailViewController.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:self.red/255 green:self.green/255 blue:self.blue/255 alpha:1];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    self.tf1.frame = CGRectMake(16, self.navigationController.navigationBar.frame.size.height+80, CGRectGetWidth(self.view.frame)-32, 70);
    self.tf1.placeholder = @"First Name";
    [self.view addSubview:self.tf1];
    
    self.tf2.frame = CGRectMake(16, self.tf1.frame.origin.y+CGRectGetHeight(self.tf1.frame)+40, CGRectGetWidth(self.view.frame)-32, 70);
    self.tf2.placeholder = @"Last Name";
    [self.view addSubview:self.tf2];
}

#pragma mark - Pirvate methods
- (void)hideKeyboard {
    if ([self.tf1 isFirstResponder]) {
        [self.tf1 resignFirstResponder];
    }

    if ([self.tf2 isFirstResponder]) {
        [self.tf2 resignFirstResponder];
    }
}

@end
