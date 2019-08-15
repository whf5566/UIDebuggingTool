//
//  UIDebuggingTool.h
//  UIDebuggingTool
//
//  Created by whf on 2019/8/15.
//  Copyright © 2019 whf5566. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDebuggingTool : NSObject

@property (class) BOOL enableMotion;

+ (void)toggleVisibility;

@end

NS_ASSUME_NONNULL_END
