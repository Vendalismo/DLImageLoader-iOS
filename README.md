DLImageLoader-iOS
=================

Image Loader for iOS. <br/>
This project aims to provide a reusable instrument for asynchronous image loading, caching and displaying.

![Screenshot](https://raw.githubusercontent.com/AndreyLunevich/DLImageLoader-iOS/master/dlil.png)

## Instalation

| Swift | DLImageLoader |
| ----- | ------------- |
| 4.X   | -             |
| 2.2   | 1.2.0-swift   |

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add DLImageLoader to your project.

1. Add a pod entry for DLImageLoader to your Podfile `pod 'DLImageLoader', '1.2.0-swift'`
2. Install the pod(s) by running `pod install`.

## Usage

### Simple

<pre>
DLImageLoader.shared.image(for: "image_url_here", imageView: "UIImageView here")
</pre>

### Complete

<pre>
DLImageLoader.shared.image(for: "image_url_here") { (image, error) in
    if let error = error {
        // if we have no any errors
    } else {
        // if we got an error when load an image
    }
}
</pre>

### Cancel loading operations

// === With using of DLImageLoader instance === //

<pre>
DLImageLoader.shared.cancelOperation(url: "image_url_here")
</pre>

<pre>
DLImageLoader.shared.cancelAllOperations()
</pre>

// === With using of DLImageView === //

<pre>
DLImageView.cancelLoading()
</pre>
=======
[Objective-C](https://github.com/AndreyLunevich/DLImageLoader-iOS/tree/objc) - "DLImageLoader", "~> 2.2.0"
>>>>>>> Refactor

## Plans

Objective-C version will be fully moved to [objc](https://github.com/AndreyLunevich/DLImageLoader-iOS/tree/objc) branch

## Applications using DLImageLoader

[Share TV](https://itunes.apple.com/br/app/share-tv-rede-social-para/id1097456577?mt=8) |
[Nootri The Nutrition Manager](https://itunes.apple.com/US/app/id912109727?mt=8) |
[Plusarium](https://itunes.apple.com/us/app/plusarium/id901280642?l=ru&ls=1&mt=8) |
[Naomuseum](https://itunes.apple.com/ru/app/naomuseum/id847290457?mt=8) | [Aerobia](https://itunes.apple.com/us/app/aerobia/id566375588?mt=8) | [StreetForm](https://itunes.apple.com/us/app/easy/id874395902?ls=1&mt=8)

## License

    Copyright 2013-2014 Andrey Lunevich

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.