//
//  UIWebView+JavaScript.h
//  MyJSView
//
//  Created by Petey Mi on 8/6/15.
//  Copyright © 2015 Petey Mi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (JavaScript)

/*
 *  Register object c object to scripting environment.
 *  controller: object c object.
 *  name: Scripting environment window object property name.
 */
-(void)registerController:(id)controller name:(NSString*)name;
/*
 *  Returns the result of executing a method in the scripting environment.
 *  name: The name of the method to invoke.
 *  args: The values to pass to the method.
 */
- (id)callWebScriptMethod:(NSString *)name withArguments:(NSArray *)args;

@end

@protocol UIWebViewJavaScript <NSObject>
/*
 *  Returns the scripting environment name for an attribute specified by a key.
 */
+(NSString*)webScriptNameForKey:(NSString*)name;

/*
 *  Returns the scripting environment name for a selector.
 */
+(NSString*)webScriptNameForSelector:(SEL)aSelector;

/*
 *  Returns whether a key should be hidden from the scripting environment.
 *  YES if the attribute specified by name should be hidden from the scripting environment; otherwise NO.
 */
+(BOOL)isKeyExcludedFromWebScript:(const char *)name;

/*
 *  Returns whether a selector should be hidden from the scripting environment.
 *  YES if the selector specified by aSelector should be hidden from the scripting environment; otherwise NO.
 */
+(BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector;

@end