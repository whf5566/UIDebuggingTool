# UIDebuggingTool

A tool to enable UIDebuggingInformationOverlay for iOS 10 &amp; 11 &amp; 12 &amp; 13.

## Install

### copy source files

- Copy UIDebuggingInformationOverlay+Enable.m, UIDebuggingTool.h, UIDebuggingTool.m to your project.

### pod

```ruby
pod 'UIDebuggingTool'
```

## Usage

- Just shake your phone to show UIDebugging view.

## WARNING

- It will hold the window displayed on the page of Current Window, after entering this page. ([ripperhe](https://github.com/ripperhe) reported this problem)  
- Workaround:  

1. Pick up a system default window on the page of Current Window.
2. Go back to the page of View Hierarchy, pull down to refresh this page.

## 安装

使用pod引入 UIDebuggingInformationOverlay+Enable.m, UIDebuggingTool.h, UIDebuggingTool.m 文件

```ruby
pod 'UIDebuggingTool'
```

## 使用方法

- 摇晃手机即可显示系统的UI调试界面。
- 更多的使用方法见[iOS自带悬浮窗调试工具使用详解](https://wellphone.me/post/2017/use_uidebugginginformationoverlay_to_debug_ui/)

## 警告

- 在进入Current Window页面后，在该页面显示的window会被该工具持有。（该问题由[ripperhe](https://github.com/ripperhe)报告）  
- 解决办法:  

1. 在Current Window页面选择一个系统的window；
2. 返回到View Hierarchy页面，下拉刷新。

## Links

- [Swizzling in iOS 11 with UIDebuggingInformationOverlay](https://www.raywenderlich.com/177890/swizzling-in-ios-11-with-uidebugginginformationoverlay)
- [iOS自带悬浮窗调试工具使用详解](https://wellphone.me/post/2017/use_uidebugginginformationoverlay_to_debug_ui/)
- [在iOS11上使用自带悬浮窗工具调试UI](https://wellphone.me/post/2017/use_uidebugginginformationoverlay_for_ios11)
