//
//  RMKAzureTranslator.h
//  RMKAzureTranslatorDemo
//
//  Created by Rekha Manju Kiran on 16/01/17.
//  Copyright © 2017 RMK Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMKAzureTranslator : NSObject

/**
 Initializes a singleton instance of the translator with the provided Azure key.
 
 @param azureKey Key obtained from Azure Cognitive Services

 @returns
 RMKAzureTranslator singletone instance.
 */
+ (instancetype)initWithAzureKey:(NSString *)azureKey;


/**
 @returns
 RMKAzureTranslator singleton instance. To be used when translating a string
 */
+ (instancetype)sharedInstance;

/**
 Translates the text provided
 
 @param sourceString : String to be Translated
 @param sourceLanguageCode : Source ISO language code of the source string. -- Set nil if language unknown -- Will Autodetect
 @param destinationLanguageCode : Destination ISO language code of the desired language output.
 @param completionHandler : The completion block returned after data is received from the Azure Translation Service
 */

- (void)translateString:(NSString *)sourceString
           fromLanguage:(NSString *)sourceLanguageCode
             toLanguage:(NSString *)destinationLanguageCode
           onCompletion:(void (^)(NSString *translatedString, NSError *error))completionHandler;


@end

