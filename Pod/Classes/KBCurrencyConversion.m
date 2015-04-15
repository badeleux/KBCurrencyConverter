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

#define kBaseURL [NSURL URLWithString:@"http://jsonrates.com/"]

@interface KBCurrencyConversion ()

@property NSString *apiKey;
@property AFHTTPSessionManager *sessionManager;

@end

@implementation KBCurrencyConversion

static KBCurrencyConversion *sharedInstance = nil;

+ (instancetype)sharedInstanceWithAPIKey:(NSString*)apiKey {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class]alloc]initWithAPIKey:apiKey];
    });
    return sharedInstance;
}

+ (instancetype)sharedInstance {
    return sharedInstance;
}

- (instancetype)initWithAPIKey:(NSString*)apiKey
{
    self = [super init];
    if (self) {
        
        _apiKey = apiKey;
        _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:kBaseURL];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"text/html", nil];
    }
    return self;
}

- (RACSignal*)convert:(NSNumber*)price
         fromCurrency:(NSString*)fromCurrency
           toCurrency:(NSString*)toCurrency {
    return [[[[_sessionManager rac_GET:@"convert/"
                         parameters:@{@"from" : fromCurrency,
                                      @"to" : toCurrency,
                                      @"amount" : price,
                                      @"apiKey" : self.apiKey}] materialize]map:^id(RACEvent *value) {
        if (value.eventType == RACEventTypeNext) {
            NSError *error = nil;
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:value.value
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&error];
            if (error) {
                return [RACEvent eventWithError:error];
            }
            else {
                return [RACEvent eventWithValue:result];
            }
        }
        return value;
    }] dematerialize];
}

@end
