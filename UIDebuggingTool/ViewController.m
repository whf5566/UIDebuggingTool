//
//  ViewController.m
//  UIDebuggingTool
//
//  Created by whf5566 on 2017/12/6.
//  Copyright © 2017年 whf5566. All rights reserved.
//

#import "ViewController.h"
#import "UIDebuggingTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self becomeFirstResponder];
}

- (IBAction)onClickToggleVisibility:(id)sender {
    [UIDebuggingTool toggleVisibility];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"test motion");
}

@end
