//
//  ViewController.m
//  Transfer
//
//  Created by mengyan.luo on 13-10-17.
//  Copyright (c) 2013年 MTime. All rights reserved.
//
static NSInteger count;
#import "ViewController.h"
#import "HorizontalCubeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [_button setTitle:[NSString stringWithFormat:@"%d", count++] forState:UIControlStateNormal];
}

- (IBAction)btnPressed:(id)sender
{
    NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
    ViewController *vc1 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    vc1.view.backgroundColor = [UIColor blackColor];
    [array addObject:vc1.view];

    ViewController *vc2 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    vc2.view.backgroundColor = [UIColor redColor];
    [array addObject:vc2.view];

    ViewController *vc3 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    vc3.view.backgroundColor = [UIColor blueColor];
    [array addObject:vc3.view];

    ViewController *vc4 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    vc4.view.backgroundColor = [UIColor greenColor];
    [array addObject:vc4.view];

    ViewController *vc5 = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    vc5.view.backgroundColor = [UIColor yellowColor];
    [array addObject:vc5.view];

    HorizontalCubeView *view = [[HorizontalCubeView alloc] initWithViews:array frame:self.view.bounds];
    [self.view addSubview:view];
    
//    ViewController *vc = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
//    [self transitionFromViewController:self toViewController:vc duration:4 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
//        [self.view addSubview:vc.view];
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
