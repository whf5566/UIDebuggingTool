//
//  ViewController.m
//  UIDebuggingTool
//
//  Created by whf5566 on 2017/12/6.
//  Copyright © 2017年 whf5566. All rights reserved.
//

#import "ViewController.h"

@interface OverlayWindow : UIWindow
- (UIGestureRecognizerState)state;
@end

@implementation OverlayWindow
// [[UIDebuggingInformationOverlayInvokeGestureHandler mainHandler] _handleActivationGesture:(UIGestureRecognizer *)]
// requires a UIGestureRecognizer, as it checks the state of it. We just fake that here.
- (UIGestureRecognizerState)state {
    return UIGestureRecognizerStateEnded;
}
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)onClickToggleVisibility:(id)sender {
    
    // Tap status bar with two fingers to start UIDebuggingInformationOverlay
    // 两个手指同时点击状态栏弹出调试框
    
#if DEBUG
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (@available(iOS 11.0, *)) {
        // Simulate two finger click status bar events
        // 模拟两个手指点击状态栏的事件
        id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
        [overlayClass performSelector:NSSelectorFromString(@"overlay")];
        id handlerClass = NSClassFromString(@"UIDebuggingInformationOverlayInvokeGestureHandler");

        id handler = [handlerClass performSelector:NSSelectorFromString(@"mainHandler")];
        [handler performSelector:NSSelectorFromString(@"_handleActivationGesture:") withObject:[[OverlayWindow alloc] init]];
    } else {
        id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
        id overlay = [overlayClass performSelector:NSSelectorFromString(@"overlay")];
        [overlay performSelector:NSSelectorFromString(@"toggleVisibility")];
    }
#pragma clang diagnostic pop
    
#endif
    
}

@end


