//
//  ViewController.m
//  Demo
//
//  Created by pengkang on 16/11/17.
//  Copyright © 2016年 pengkang. All rights reserved.
//

#import "ViewController.h"
#import "PengKSlideMenu.h"

@interface ViewController ()

@property(nonatomic,weak)IBOutlet PengKSlideMenu *menu0;

@property(nonatomic,weak)IBOutlet PengKSlideMenu *menu1;

@property(nonatomic,weak)IBOutlet PengKSlideMenu *menu2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSArray *arr0 = @[@"ITEM0",@"ITEM1",@"ITEM2",@"ITEM3"];
    NSArray *arr1 = @[@"ITEM0",@"ITEM1",@"ITEM2",@"ITEM3"];
    NSArray *arr2 = @[@"ITEM0",@"ITEM1",@"ITEM2",@"ITEM3"];
    
    
    self.menu0.titlesArr = arr0;
    self.menu0.itemEqualWidth = YES;
    self.menu0.titleOffset = 25;
    [self.menu0 layout];
    
    self.menu1.titlesArr = arr1;
    [self.menu1 layout];
    
    self.menu2.titlesArr = arr2;
    [self.menu2 layout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
