//
//  KBCurrencyConversion.m
//  Pods
//
//  Created by Kamil Badyla on 15.04.2015.
//
//

#import "KBCurrencyConversion.h"
#import <AFNetworking.h>
#import <AFNetworking-RACExtensions/AFHTTPSessionManager+RACSupport.h>

#define kEnv @"store://datatables.org/alltableswithkeys"
#define kBaseURL [NSURL URLWithString:@"http://query.yahooapis.com/v1/public/"]

@interface KBCurrencyConversion ()

@property AFHTTPSessionManager *sessionManager;

@end

@implementation KBCurrencyConversion

static KBCurrencyConversion *sharedInstance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc]init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:kBaseURL];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (RACSignal*)convert:(NSNumber*)price
         fromCurrency:(NSString*)fromCurrency
           toCurrency:(NSString*)toCurrency {
    NSString *q = [NSString stringWithFormat:@"select * from yahoo.finance.xchange where pair in (\"%@%@\")", fromCurrency, toCurrency];
    return [[_sessionManager rac_GET:@"yql"
                         parameters:@{@"q" : q,
                                      @"format" : @"json",
                                      @"env" : kEnv}]map:^id(RACTuple *tuple) {
        NSDictionary *response = [tuple first];
        NSDictionary *results = response[@"query"][@"results"];
        NSNumber *rate = @([results[@"rate"][@"Rate"] doubleValue]);
        return @([price doubleValue] * [rate doubleValue]);
    }];
}

@end
