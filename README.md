# UIDebuggingTool
A tool to enable UIDebuggingInformationOverlay for iOS 10 &amp; 11

## Install
- Copy UIDebuggingInformationOverlay+Enable.m to your project.
- Add the following code to [AppDelegate application:didFinishLaunchingWithOptions:]

```
 #if DEBUG
 id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
 [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
 #endif
```

## Links
- [Swizzling in iOS 11 with UIDebuggingInformationOverlay](https://www.raywenderlich.com/177890/swizzling-in-ios-11-with-uidebugginginformationoverlay)
- [iOS自带悬浮窗调试工具使用详解](https://wellphone.me/post/2017/use_uidebugginginformationoverlay_to_debug_ui/)
- [在iOS11上使用自带悬浮窗工具调试UI](https://wellphone.me/post/2017/use_uidebugginginformationoverlay_for_ios11)
