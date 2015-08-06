//
//  ViewController.m
//  MyJSView
//
//  Created by Petey Mi on 8/4/15.
//  Copyright © 2015 Petey Mi. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <WebKit/WebKit.h>
#import "UIWebView+JavaScript.h"


@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

+(BOOL)isKeyExcludedFromWebScript:(const char *)name
{
    return NO;
}
+(BOOL)isSelectorExcludedFromWebScript:(SEL)aSelector
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,40,320,320)];
    webView.delegate = self;
    [self.view addSubview:webView];
    NSString *pageSource = @"<!DOCTYPE html> <html> <head> </head> <body> <h1>My Mobile App</h1> <p>Please enter the Details</p> <form name=\"feedback\" method=\"post\" action=\"mailto:you@site.com\"> <!-- Form elements will go in here --> </form> <form name=\"inputform\"> <input type=\"button\" onClick=\"submitButton('My Test Parameter')\" value=\"submit\"> <input type=\"button\" onClick=\"viewController.sayGoodbye()\" value=\"submit1\"></form> </body> </html>";
    [webView registerController:self name:@"viewController"];
    [webView loadHTMLString:pageSource baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; // Undocumented access
//    context[@"submitButton"] = ^(NSString *param1) {
//        [self yourObjectiveCMethod:param1];
//    };
    NSArray* array = webView.subviews;
    NSArray* b = ((UIView*)[array objectAtIndex:0]).subviews;

    id a = [webView valueForKeyPath:@"documentView.webView"];
    NSLog(@"%@",a);
}

- (void)yourObjectiveCMethod:(NSString *)param1 {
    NSLog(@"User clicked submit. param1=%@", param1);
}

- (void) sayGoodbye
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView* av = [[UIAlertView alloc] initWithTitle: @"Goodbye, World!"
                                                     message: nil
                                                    delegate: nil
                                           cancelButtonTitle: @"OK"
                                           otherButtonTitles: nil];
        
        [av show];
    });
}

@end
