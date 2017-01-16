//
//  RMKAzureTokenManager.m
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import "RMKAzureTokenManager.h"

static NSString *const RMKMicrosoftTokenRefreshURL = @"https://api.cognitive.microsoft.com/sts/v1.0/issueToken";

@interface RMKAzureTokenManager()
@property (nonatomic, strong) NSString *azureKey;
@property (nonatomic, strong) NSString *azureToken;
@property (nonatomic, strong) NSDate *tokenExpiryDate;
@end

@implementation RMKAzureTokenManager

- (instancetype)initWithAzureKey:(NSString *)azureKey
{
    self = [super init];
    if (self) {
        if(azureKey.length)
        {
            self.azureKey = azureKey;
            [self refreshTokenForAzureKey:azureKey onCompletion:nil];
        }
    }
    return self;
}


- (void)refreshTokenForAzureKey:(NSString *)azureKey
                         onCompletion:(void (^)(NSString *azureToken, NSError *error))completionHandler;

{
    if (self.azureToken.length && self.tokenExpiryDate > [NSDate date])
    {
        if(completionHandler)
        {
            completionHandler(self.azureToken,nil);
        }
    }
    else
    {
        [self retrieveUpdatedTranslationTokeFromMicrosoftWithKey:azureKey
                                                    onCompletion:completionHandler];
    }
}

- (void)fetchTokenForAzureKey:(NSString *)azureKey
                 onCompletion:(void (^)(NSString *azureToken, NSError *error))completionHandler;
{
    
    [self refreshTokenForAzureKey:azureKey
                     onCompletion:completionHandler];
}

- (void)retrieveUpdatedTranslationTokeFromMicrosoftWithKey:(NSString *)azureKey
                                              onCompletion:(void (^)(NSString *azureToken, NSError *error))completionHandler
{
 
    NSURL *url = [NSURL URLWithString:RMKMicrosoftTokenRefreshURL];
    NSMutableURLRequest *tokenRequest = [NSMutableURLRequest requestWithURL:url];
    
    // Setting Headers
    [tokenRequest setHTTPMethod:@"POST"];
    [tokenRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [tokenRequest setValue:@"application/jwt" forHTTPHeaderField:@"Accept"];
    [tokenRequest setValue:azureKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                          dataTaskWithRequest:tokenRequest
                                      completionHandler:^(NSData * data, NSURLResponse *  response, NSError * error)
                                      {
                                          
                                          if(error)
                                          {
                                              if(completionHandler)
                                              {
                                                  completionHandler(nil,error);
                                              }
                                          }
                                          else
                                          {
                                              NSString *azureToken = [[NSString alloc] initWithData:data
                                                                                           encoding:NSUTF8StringEncoding];
                                              if(azureToken.length)
                                              {
                                                  self.azureToken = azureToken;
                                                  self.tokenExpiryDate = [NSDate dateWithTimeIntervalSinceNow:9*60];
                                                  if(completionHandler)
                                                  {
                                                      completionHandler(azureToken,error);
                                                  }
                                              }
                                              
                                          }
                                      }];
    
    
    [dataTask resume];
}


@end
