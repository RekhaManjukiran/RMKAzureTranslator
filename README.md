# RMKAzureTranslator
A simple iOS utility to translate text using Microsoft Azure Cognitive Services 

## Steps to integrate

### Step1
Signup to Azure Cognitive services 
Follow the steps in this link [Azure Cognitive Services](https://www.microsoft.com/en-us/translator/getstarted.aspx) and obtain the azure translate key and token

### Step 2

	Import the "RMKAzureTranslator.h" file into your App Delegate file
	Create a pointer for a String containing the obtained azure Key
	Call the "initWithAzureKey" method in didFinishLaunchingWithOptions function with the above created pointer.

```
#import <RMKAzureTranslator/RMKAzureTranslator.h>

static NSString *const RMKAzureTranslatorKey = <Insert-your-azureKey-here>;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [RMKAzureTranslator initWithAzureKey:RMKAzureTranslatorKey];
    
    return YES;
}
````

### Step 3
Import the "RMKAzureTranslator.h" file into the ViewController
Invoke the "translateString" method
Pass the Text to be translated, the Source ISO language code of the source string. _-- __Set nil if language unknown , the utility will autodetect__ and the Destination ISO language code of the desired language output.

````
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
     }]

````

### Step 4 

Run the app

## Demo

1. Go to the RMKAzureTranslatorDemo directory.
2. Open RMKAzureTranslatorDemo.xcodeproj
3. Run the app.

## Adding RMKAzureTranslator to Your Project

add the line 
```
pod 'RMKAzureTranslator' 
```
to your podfile

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like RMKAzureTranslator in your projects. See the ["Getting Started"](https://github.com/RekhaManjukiran/RMKAzureTranslator/wiki/Installing-RMKAzureTranslator-via-CocoaPods) guide for more information.

## Attributions

FGTranslator uses the following projects:

- [XMLDictionary](https://github.com/nicklockwood/XMLDictionary)
	
## License

RMKAzureTranslator is available under the MIT license. See the LICENSE file for more info.

