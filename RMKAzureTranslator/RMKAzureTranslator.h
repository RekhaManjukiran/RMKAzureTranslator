//
//  RMKAzureTranslator.h
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMKAzureTranslator : NSObject

+ (instancetype)initWithAzureKey:(NSString *)azureKey;
+ (instancetype)sharedInstance;

- (void)translateString:(NSString *)sourceString
           fromLanguage:(NSString *)sourceLanguageCode
             toLanguage:(NSString *)destinationLanguageCode
           onCompletion:(void (^)(NSString *translatedString, NSError *error))completionHandler;


@end

