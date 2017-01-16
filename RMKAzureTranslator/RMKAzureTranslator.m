//
//  RMKAzureTranslator.m
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import "RMKAzureTranslator.h"
#import "RMKAzureTokenManager.h"
#import "XMLDictionary/XMLDictionary.h"

static NSString *const RMKMicrosoftTranslationURLWithSourceLanguage= @"https://api.microsofttranslator.com/v2/http.svc/"\
    "Translate?appid=Bearer %@"
    "&text=%@"\
    "&from=%@"\
    "&to=%@";

static NSString *const RMKMicrosoftTranslationURLWithoutSourceLanguage= @"https://api.microsofttranslator.com/v2/http.svc/"\
    "Translate?appid=Bearer %@"
    "&text=%@"\
    "&to=%@";


@interface RMKAzureTranslator()
@property (nonatomic,strong) NSString *azureKey;
@property (nonatomic,strong) RMKAzureTokenManager *tokenManager;
@end

@implementation RMKAzureTranslator

+ (instancetype)initWithAzureKey:(NSString *)azureKey
{
    RMKAzureTranslator *sharedInstance = [RMKAzureTranslator sharedInstance];
    sharedInstance.azureKey = azureKey;
    sharedInstance.tokenManager = [[RMKAzureTokenManager alloc] initWithAzureKey:azureKey];
    return sharedInstance;
}


+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate = 0;
    __strong static id sharedObject = nil;
    //static id sharedObject = nil;  //if you're not using ARC
    dispatch_once(&predicate, ^{
        sharedObject = [[self alloc] init];
        
    });
    return sharedObject;
}

- (void)configureAzureToken
{
    if(self.azureKey)
    {
        // Do something to Configure
    }
}

- (void)translateString:(NSString *)sourceString
           fromLanguage:(NSString *)sourceLanguageCode
             toLanguage:(NSString *)destinationLanguageCode
           onCompletion:(void (^)(NSString *translatedString, NSError *error))completionHandler
{
    [self.tokenManager fetchTokenForAzureKey:self.azureKey
                                onCompletion:^(NSString *azureToken, NSError *error)
                                {
                                    if(azureToken.length)
                                    {
                                        [self translateString:sourceString
                                                 fromLanguage:sourceLanguageCode
                                                   toLanguage:destinationLanguageCode
                                         withAzureToken:azureToken
                                                 onCompletion:completionHandler
                                         ];
                                    }
                                    else
                                    {
                                        completionHandler(nil,error);
                                    }
                                   
                                }];
}

- (void)translateString:(NSString *)sourceString
           fromLanguage:(NSString *)sourceLanguageCode
             toLanguage:(NSString *)destinationLanguageCode
         withAzureToken:(NSString *)azureToken
           onCompletion:(void (^)(NSString *translatedString, NSError *error))completionHandler
{
    NSString *azureTranslateURLString;
    if(sourceLanguageCode.length)
    {
        azureTranslateURLString = [NSString stringWithFormat:RMKMicrosoftTranslationURLWithSourceLanguage,
                                   azureToken,
                                   sourceString,
                                   sourceLanguageCode,
                                   destinationLanguageCode];
    }else
    {
        azureTranslateURLString = [NSString stringWithFormat:RMKMicrosoftTranslationURLWithoutSourceLanguage,
                                   azureToken,
                                   sourceString,
                                   destinationLanguageCode];
    }
    
    azureTranslateURLString = [azureTranslateURLString stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    
    NSURL *translateURL = [NSURL URLWithString:azureTranslateURLString];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
                                      dataTaskWithURL:translateURL
                                      completionHandler:^(NSData * data, NSURLResponse * response, NSError * error)
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
                                            if(data)
                                            {
                                                XMLDictionaryParser *parser = [XMLDictionaryParser sharedInstance];
                                                NSDictionary *parsedDictionary = [parser dictionaryWithData:data];
                                                NSString *translatedString = [parsedDictionary innerText];
                                                if(completionHandler)
                                                {
                                                    completionHandler(translatedString,error);
                                                }
                                            }
                                        }
                                          
                                    }];
    [dataTask resume];

}
/* Sample URL Type
 https://api.microsofttranslator.com/v2/http.svc/Translate?appid=Bearer%20eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzY29wZSI6Imh0dHBzOi8vYXBpLm1pY3Jvc29mdHRyYW5zbGF0b3IuY29tLyIsInN1YnNjcmlwdGlvbi1pZCI6IjgwNzc5MDUzMTg1ZTQ2MWQ5YzEyYWFmZGU5NDc1YjExIiwicHJvZHVjdC1pZCI6IlRleHRUcmFuc2xhdG9yLkYwIiwiY29nbml0aXZlLXNlcnZpY2VzLWVuZHBvaW50IjoiaHR0cHM6Ly9hcGkuY29nbml0aXZlLm1pY3Jvc29mdC5jb20vaW50ZXJuYWwvdjEuMC8iLCJhenVyZS1yZXNvdXJjZS1pZCI6Ii9zdWJzY3JpcHRpb25zLzc4OWNhYThhLTJkYzYtNGE1Zi1iYjZhLTlkYWQzNzU2ZWI1ZC9yZXNvdXJjZUdyb3Vwcy9STUtTb2x1dGlvbnMvcHJvdmlkZXJzL01pY3Jvc29mdC5Db2duaXRpdmVTZXJ2aWNlcy9hY2NvdW50cy9SZWtoYV9NYW5qdV9LaXJhbiIsImlzcyI6InVybjptcy5jb2duaXRpdmVzZXJ2aWNlcyIsImF1ZCI6InVybjptcy5taWNyb3NvZnR0cmFuc2xhdG9yIiwiZXhwIjoxNDg0NjA4NzU4fQ.kMlBdtOHzbNWiYfgKvOfKaYl8UiT2TXkVGjINcV2tFU&text=Hello%2C%20my%20name%20is%20Rekha&from=en&to=fr
 
 */

@end
