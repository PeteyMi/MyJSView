//
//  UIWebView+JavaScript.m
//  MyJSView
//
//  Created by Petey Mi on 8/6/15.
//  Copyright © 2015 Petey Mi. All rights reserved.
//

#import "UIWebView+JavaScript.h"
#import <objc/runtime.h>

static const char* kWindowJavaScriptContext = "windowScriptContext";
static const char* kRegisterController = "registerController";

@protocol WindowScriptObjectProtocol <NSObject>

-(id)evaluateWebScript:(NSString*)str;
- (id)callWebScriptMethod:(NSString *)name withArguments:(NSArray *)args;

@end

@implementation UIWebView (JavaScript)

-(NSMutableDictionary*)controller
{
    NSMutableDictionary* dic = objc_getAssociatedObject(self, kRegisterController);
    if (dic == nil) {
        dic = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, kRegisterController, dic, OBJC_ASSOCIATION_RETAIN);
    }
    return dic;
}

- (void)webView:(id )sender didClearWindowObject:(id )windowObject forFrame:(id)frame
{
    objc_setAssociatedObject(self, kWindowJavaScriptContext, windowObject, OBJC_ASSOCIATION_ASSIGN);
    NSDictionary* dic = [self controller];
    NSArray* keys = [dic allKeys];
    for (NSString* key in keys) {
        [windowObject setValue:[dic objectForKey:key] forKey:key];
    }
}

-(void)registerController:(id)controller name:(NSString*)name
{
    NSMutableDictionary* dic = [self controller];
    [dic setObject:controller forKey:name];
}

- (id)callWebScriptMethod:(NSString *)name withArguments:(NSArray *)args
{
    id windowObjct = objc_getAssociatedObject(self, kWindowJavaScriptContext);
    if ([windowObjct respondsToSelector:@selector(callWebScriptMethod:withArguments:)]) {
        return [windowObjct callWebScriptMethod:name withArguments:args];
    }
    return nil;
}

@end
