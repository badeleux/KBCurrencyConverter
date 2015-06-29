//
//  CCViewController.m
//  KBCurrencyConverter
//
//  Created by badeleux on 04/15/2015.
//  Copyright (c) 2014 badeleux. All rights reserved.
//


#import "CCViewController.h"
#import <KBCurrencyConversion.h>

@interface CCViewController ()

@end

@implementation CCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[KBCurrencyConversion sharedInstance] convert:@(10)
                                                                                       fromCurrency:@"PLN"
                                                                                         toCurrency:@"USD"] subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
