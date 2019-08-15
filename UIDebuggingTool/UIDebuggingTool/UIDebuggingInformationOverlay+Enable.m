//
//  UIDebuggingInformationOverlay+Enable.m
//  UIDebuggingInformationOverlay
//
//  Created by whf5566 on 2017/12/05.
//  Copyright © 2017年 whf5566. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

/*
 In iOS 11, Apple added additional checks to disable this overlay unless the
 device is an internal device. To get around this, we swizzle out the
 -[UIDebuggingInformationOverlay init] method (which returns nil now if
 the device is non-internal)

 */

#if defined(DEBUG) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0

@interface UIWindow (PrivateMethods)
- (void)_setWindowControlsStatusBarOrientation:(BOOL)orientation;
@end

@interface _FakeWindowClass : UIWindow
@end

@implementation _FakeWindowClass

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class UIDebuggingInformationOverlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
        Method originalMethod = class_getInstanceMethod(UIDebuggingInformationOverlayClass, @selector(init));
        Method swizzledMethod = class_getInstanceMethod([_FakeWindowClass class], @selector(initSwizzled));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (instancetype)initSwizzled {
    self = [super init];
    if (self) {
        [self _setWindowControlsStatusBarOrientation:NO];
    }
    return self;
}

@end

#endif
