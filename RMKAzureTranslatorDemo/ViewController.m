//
//  ViewController.m
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import "ViewController.h"
#import "RMKAzureTranslator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[RMKAzureTranslator sharedInstance] translateString:@"Hello, my name is Rekha"
                                            fromLanguage:@"en" toLanguage:@"fr" onCompletion:^(NSString *translatedString, NSError *error)
                                {
                                    if(error)
                                    {
                                        NSLog(@"%@",error);
                                    }
                                    else
                                    {
                                        NSLog(@"%@",translatedString);
                                    }
                                }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
