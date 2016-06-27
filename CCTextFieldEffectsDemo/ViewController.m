//
//  ViewController.m
//  CCTextFieldEffects
//
//  Created by Kelvin on 6/25/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (copy, nonatomic) NSMutableArray *effects;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"effects" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    self.effects = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.9765 green:0.9686 blue:0.9647 alpha:1.0];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.effects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [[self.effects objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *DVC =[[DetailViewController alloc] init];
    DVC.title = [[self.effects objectAtIndex:indexPath.row] objectForKey:@"title"];
    DVC.red = [[[[self.effects objectAtIndex:indexPath.row] objectForKey:@"backgroundColor"] objectAtIndex:0] floatValue];
    DVC.green = [[[[self.effects objectAtIndex:indexPath.row] objectForKey:@"backgroundColor"] objectAtIndex:1] floatValue];
    DVC.blue = [[[[self.effects objectAtIndex:indexPath.row] objectForKey:@"backgroundColor"] objectAtIndex:2] floatValue];
    
    [self.navigationController pushViewController:DVC animated:YES];
}

@end
