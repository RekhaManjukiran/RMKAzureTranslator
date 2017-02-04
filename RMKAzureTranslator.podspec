Pod::Spec.new do |spec|
  spec.name         = 'RMKAzureTranslator'
  spec.version      = '1.0.1'
  spec.license      = 'MIT'
  spec.summary      = 'A simple iOS utility to translate using Microsoft Azure'
  spec.homepage     = 'https://github.com/RekhaManjukiran/RMKAzureTranslator'
  spec.author       = { "Rekha Manju Kiran" => "rekha@manjukiran.com" }
  spec.source       = { :git => "https://github.com/RekhaManjukiran/RMKAzureTranslator.git", :tag => "v1.0.1" }
  spec.source_files = 'RMKAzureTranslator', 'RMKAzureTranslator/XMLDictionary'
  spec.requires_arc = true
end
