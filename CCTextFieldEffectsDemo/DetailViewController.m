//
//  DetailViewController.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "DetailViewController.h"
#import "CCTextFieldEffects.h"

@interface DetailViewController ()

@property (nonatomic) CGRect highFrame;
@property (nonatomic) CGRect lowFrame;

@end

@implementation DetailViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:self.red/255 green:self.green/255 blue:self.blue/255 alpha:1];
    
    self.highFrame = CGRectMake(16, self.navigationController.navigationBar.frame.size.height+80, CGRectGetWidth(self.view.frame)-32, 70);
    
    self.lowFrame = CGRectMake(16, self.highFrame.origin.y+CGRectGetHeight(self.highFrame)+40, CGRectGetWidth(self.view.frame)-32, 70);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@"Akira"]) {
        AkiraTextField *tf1 = [[AkiraTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        AkiraTextField *tf2 = [[AkiraTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Hoshi"]) {
        HoshiTextField *tf1 = [[HoshiTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        HoshiTextField *tf2 = [[HoshiTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Isao"]) {
        IsaoTextField *tf1 = [[IsaoTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        IsaoTextField *tf2 = [[IsaoTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Jiro"]) {
        JiroTextField *tf1 = [[JiroTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        JiroTextField *tf2 = [[JiroTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Kaede"]) {
        KaedeTextField *tf1 = [[KaedeTextField alloc] initWithFrame:CGRectInset(self.highFrame, 0, 7)];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        KaedeTextField *tf2 = [[KaedeTextField alloc] initWithFrame:CGRectInset(self.lowFrame, 0, 7)];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Madoka"]) {
        MadokaTextField *tf1 = [[MadokaTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        MadokaTextField *tf2 = [[MadokaTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Yoko"]) {
        YokoTextField *tf1 = [[YokoTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        YokoTextField *tf2 = [[YokoTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Yoshiko"]) {
        YoshikoTextField *tf1 = [[YoshikoTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        YoshikoTextField *tf2 = [[YoshikoTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Hoshi"]) {
        HoshiTextField *tf1 = [[HoshiTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        HoshiTextField *tf2 = [[HoshiTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Hideo"]) {
        HideoTextField *tf1 = [[HideoTextField alloc] initWithFrame:CGRectInset(self.highFrame, 0, 7)];
        tf1.image = [UIImage imageNamed:@"mail.png"];
        [self.view addSubview:tf1];
        
        HideoTextField *tf2 = [[HideoTextField alloc] initWithFrame:CGRectInset(self.lowFrame, 0, 7)];
        tf2.image = [UIImage imageNamed:@"user.png"];
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Haruki"]) {
        HarukiTextField *tf1 = [[HarukiTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        HarukiTextField *tf2 = [[HarukiTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Minoru"]) {
        MinoruTextField *tf1 = [[MinoruTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        MinoruTextField *tf2 = [[MinoruTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Kyo"]) {
        KyoTextField *tf1 = [[KyoTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        KyoTextField *tf2 = [[KyoTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Kuro"]) {
        KuroTextField *tf1 = [[KuroTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        KuroTextField *tf2 = [[KuroTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Ruri"]) {
        RuriTextField *tf1 = [[RuriTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        RuriTextField *tf2 = [[RuriTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Chisato"]) {
        ChisatoTextField *tf1 = [[ChisatoTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        ChisatoTextField *tf2 = [[ChisatoTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Manami"]) {
        ManamiTextField *tf1 = [[ManamiTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        ManamiTextField *tf2 = [[ManamiTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Nariko"]) {
        NarikoTextField *tf1 = [[NarikoTextField alloc] initWithFrame:self.highFrame];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        NarikoTextField *tf2 = [[NarikoTextField alloc] initWithFrame:self.lowFrame];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Sae"]) {
        SaeTextField *tf1 = [[SaeTextField alloc] initWithFrame:CGRectInset(self.highFrame, 80, 0)];
        tf1.placeholder = @"First Name";
        [self.view addSubview:tf1];
        
        SaeTextField *tf2 = [[SaeTextField alloc] initWithFrame:CGRectInset(self.lowFrame, 80, 0)];
        tf2.placeholder = @"Last Name";
        [self.view addSubview:tf2];
    } else if ([self.title isEqualToString:@"Kohana"]) {
        KohanaTextField *tf1 = [[KohanaTextField alloc] initWithFrame:CGRectInset(self.highFrame, 0, 7)];
        tf1.placeholder = @"Mail";
        tf1.image = [UIImage imageNamed:@"mail.png"];
        [self.view addSubview:tf1];
        
        KohanaTextField *tf2 = [[KohanaTextField alloc] initWithFrame:CGRectInset(self.lowFrame, 0, 7)];
        tf2.placeholder = @"User Name";
        tf2.image = [UIImage imageNamed:@"user.png"];
        [self.view addSubview:tf2];
    }
}

#pragma mark - Pirvate methods


@end
