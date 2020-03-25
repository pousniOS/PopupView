//
//  ViewController.m
//  PopupView
//
//  Created by apple on 25/3/2020.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ViewController.h"
#import "Popuup.h"
@interface ViewController ()

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 44, 44)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonActin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(100+150, 100, 44, 44)];
    button1.backgroundColor = [UIColor redColor];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(buttonActin1:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonActin:(UIButton *)sender{
    [Popuup remove];
}
-(void)buttonActin1:(UIButton *)sender{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [Popuup view:view andCenterOffset:CGPointMake(-100, -100)];
}


@end

