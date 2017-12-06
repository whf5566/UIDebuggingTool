//
//  ViewController.m
//  UIDebuggingTool
//
//  Created by whf5566 on 2017/12/6.
//  Copyright © 2017年 whf5566. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onClickToggleVisibility:(id)sender {
    
    //  Tap status bar with two fingers to start UIDebuggingInformationOverlay
    
#if DEBUG
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    Class overlay = [overlayClass performSelector:NSSelectorFromString(@"overlay")];
    [overlay performSelector:NSSelectorFromString(@"toggleVisibility")];
#pragma clang diagnostic pop
    
#endif
    
}

@end


