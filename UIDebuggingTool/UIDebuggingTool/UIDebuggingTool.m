//
//  UIDebuggingTool.m
//  UIDebuggingTool
//
//  Created by whf on 2019/8/15.
//  Copyright © 2019 whf5566. All rights reserved.
//

#import "UIDebuggingTool.h"
#import <objc/runtime.h>

#if defined(DEBUG)

void SwapInstanceMethods(Class cls, SEL original, SEL replacement) {
    Method originalMethod = class_getInstanceMethod(cls, original);
    IMP originalImplementation = method_getImplementation(originalMethod);
    const char *originalArgTypes = method_getTypeEncoding(originalMethod);

    Method replacementMethod = class_getInstanceMethod(cls, replacement);
    IMP replacementImplementation = method_getImplementation(replacementMethod);
    const char *replacementArgTypes = method_getTypeEncoding(replacementMethod);

    if (class_addMethod(cls, original, replacementImplementation, replacementArgTypes)) {
        class_replaceMethod(cls, replacement, originalImplementation, originalArgTypes);
    } else {
        method_exchangeImplementations(originalMethod, replacementMethod);
    }
}

@interface _FakeGestureRecognizer : UIGestureRecognizer
- (UIGestureRecognizerState)state;
@end

@implementation _FakeGestureRecognizer
// [[UIDebuggingInformationOverlayInvokeGestureHandler mainHandler] _handleActivationGesture:(UIGestureRecognizer *)]
// requires a UIGestureRecognizer, as it checks the state of it. We just fake that here.
- (UIGestureRecognizerState)state {
    return UIGestureRecognizerStateEnded;
}

@end

NSString *const UIEventSubtypeMotionShakeNotification = @"UIEventSubtypeMotionShakeNotification";
@implementation UIApplication (swizzle)
- (void)swizzle_sendEvent:(UIEvent *)event {
    [self swizzle_sendEvent:event];
    if (event.type == UIEventTypeMotion && event.subtype == UIEventSubtypeMotionShake) {
        if ([[event valueForKey:@"shakeState"] intValue] == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:UIEventSubtypeMotionShakeNotification object:nil];
        }
    }
}

@end

#endif

@implementation UIDebuggingTool
#if defined(DEBUG)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwapInstanceMethods([UIApplication class], @selector(sendEvent:), @selector(swizzle_sendEvent:));
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUIApplicationDidFinishLaunching) name:UIApplicationDidFinishLaunchingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMotionShake) name:UIEventSubtypeMotionShakeNotification object:nil];
    });
}

+ (void)onUIApplicationDidFinishLaunching {
    [self prepareDebuggingOverlay];
}

+ (void)onMotionShake {
    if (self.enableMotion) {
        [self toggleVisibility];
    }
}

#endif

static BOOL _enableMotion = TRUE;
+ (BOOL)enableMotion {
    return _enableMotion;
}

+ (void)setEnableMotion:(BOOL)enableMotion {
    _enableMotion = enableMotion;
}

+ (void)prepareDebuggingOverlay {
#if defined(DEBUG)
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
    #pragma clang diagnostic pop
#endif
}

+ (void)toggleVisibility {
#if defined(DEBUG)
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (@available(iOS 11.0, *)) {
        id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
        [overlayClass performSelector:NSSelectorFromString(@"overlay")];
        id handlerClass = NSClassFromString(@"UIDebuggingInformationOverlayInvokeGestureHandler");

        id handler = [handlerClass performSelector:NSSelectorFromString(@"mainHandler")];
        [handler performSelector:NSSelectorFromString(@"_handleActivationGesture:") withObject:[[_FakeGestureRecognizer alloc] init]];
    } else {
        id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
        id overlay = [overlayClass performSelector:NSSelectorFromString(@"overlay")];
        [overlay performSelector:NSSelectorFromString(@"toggleVisibility")];
    }
    #pragma clang diagnostic pop
#endif
}

@end
