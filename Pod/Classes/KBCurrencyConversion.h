//
//  KBCurrencyConversion.h
//  Pods
//
//  Created by Kamil Badyla on 15.04.2015.
//
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface KBCurrencyConversion : NSObject

+ (instancetype)sharedInstance;

- (RACSignal*)convert:(NSNumber*)price
         fromCurrency:(NSString*)fromCurrency
           toCurrency:(NSString*)toCurrency;

@end
