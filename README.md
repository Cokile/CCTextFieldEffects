## TextFieldEffects

[![](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Cokile/CCTextFieldEffects/blob/master/Licence)
[![](https://img.shields.io/github/release/Cokile/CCTextFieldEffects.svg)](https://github.com/Cokile/CCTextFieldEffects/releases)

Custom UITextFields effects inspired by [Codrops](http://tympanus.net/Development/TextInputEffects/index.html), which can be used as a simple replacement for `UITextField`. Original effects were built by [Raul Riera](https://github.com/raulriera) using Swift, but ported to Objective-C.

It now supports

|                 Original                 |                Extension                 |                Extension                 |
| :--------------------------------------: | :--------------------------------------: | :--------------------------------------: |
| [Akira](https://github.com/Cokile/CCTextFieldEffects#akira) | [Hideo](https://github.com/Cokile/CCTextFieldEffects#hideo) | [Nariko](https://github.com/Cokile/CCTextFieldEffects#nariko) |
| [Hoshi](https://github.com/Cokile/CCTextFieldEffects#hoshi) | [Haruki](https://github.com/Cokile/CCTextFieldEffects#haruki) |                                          |
| [Isao](https://github.com/Cokile/CCTextFieldEffects#isao) | [Minoru](https://github.com/Cokile/CCTextFieldEffects#minoru) - bug fixed |                                          |
| [Jiro](https://github.com/Cokile/CCTextFieldEffects#jiro) | [Kyo](https://github.com/Cokile/CCTextFieldEffects#kyo) |                                          |
| [Kaede](https://github.com/Cokile/CCTextFieldEffects#kaede) | [Kuro](https://github.com/Cokile/CCTextFieldEffects#kuro) |                                          |
| [Madoka](https://github.com/Cokile/CCTextFieldEffects#madoka) | [Ruri](https://github.com/Cokile/CCTextFieldEffects#ruri) |                                          |
| [Yoko](https://github.com/Cokile/CCTextFieldEffects#yoko) | [Chisato](https://github.com/Cokile/CCTextFieldEffects#chisato) |                                          |
| [Yoshiko](https://github.com/Cokile/CCTextFieldEffects#yoshiko) | [Manami](https://github.com/Cokile/CCTextFieldEffects#manami) |                                          |



## Acknowledgement

- Thanks to original  effects' developer Raul Riera, [@raulriera](http://twitter.com/raulriera)

  [TextFieldEffects: Custom UITextFields effects inspired by Codrops, built using Swift](https://github.com/raulriera/TextFieldEffects)

- The effect of [Minoru](https://github.com/Cokile/CCTextFieldEffects#minoru) is created by PlusingHalo.

  [ PlusingHalo: iOS Component for creating a pulsing animation.](https://github.com/shu223/PulsingHalo)




## Installation

### CocoaPods

Simply add one line to your Podfile:
```ruby
pod 'CCTextFieldEffects'
```

### Manual

Drag all the files in the  `CCTextFieldEffects` folder into your project.



## Easy to use and customisable

__Note:__ 

- Although every effect have communal APIs, I do not put them in the same area. In most cases, you just use one effect on a single `UIViewController` or other else, so there is no need to scroll up and down the page to see the communal APIs and unique APIs. Just scroll to the effect you need at first ,all you need is there.


- If you run the demo app in the simulator, the animation may get blocked. You should run it in the real iOS device for better test.


- All the text fields are resigned from first responder by pressing the Return button in the keyboard.
- CCTextFieldEffects needs ARC.



### Akira

![Akira](Captures/Akira.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) AkiraTextField *akiraTextField;

//...
self.akiraTextField = [[AkiraTextField alloc] initWithFrame:<#CGRect#>];

self.akiraTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.7
self.akiraTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border, default value is R105 G106 B110 
self.akiraTextField.borderColor = <#UIColor#>;

// The color of the placeholder, default value is R204 G96 B85
self.akiraTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R170 G170 B170
self.akiraTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R170 G170 B170
self.akiraTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.akiraTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.akiraTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.akiraTextField];
```



### Hoshi

![Hoshi](Captures/Hoshi.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) HoshiTextField *hoshiTextField;

//...
self.hoshiTextField = [[HoshiTextField alloc] initWithFrame:<#CGRect#>];

self.hoshiTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.65
self.hoshiTextField.placeholderFontScale = <#CGFloat#>;

// The color of the inactive border, default value is R185 G193 B202 
self.hoshiTextField.borderInactiveColor = <#UIColor#>;

// The color of the active border, default value is R106 B121 B137
self.hoshiTextField.borderActiveColor = <#UIColor#>;

// The color of the placeholder, default value is R185 G193 B202
self.hoshiTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R89 G95 B110
self.hoshiTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R89 G95 B110
self.hoshiTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.hoshiTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.hoshiTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.hoshiTextField];
```



### Isao
![Isao](Captures/Isao.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) IsaoTextField *isaoTextField;

//...
self.isaoTextField = [[IsaoTextField alloc] initWithFrame:<#CGRect#>];

self.isaoTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.7
self.isaoTextField.placeholderFontScale = <#CGFloat#>;

// The color of the inactive border and placeholder, default value is R218 G218 B218 
self.isaoTextField.inactiveColor = <#UIColor#>;

// The color of the active border and placeholder, default value is R218 G112 B113
self.isaoTextField.activeColor = <#UIColor#>;

// The color of the cursor, default value is R175 G179 B184
self.isaoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R175 G179 B184
self.isaoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.isaoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.isaoTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.isaoTextField];
```



### Jiro

![Jiro](Captures/Jiro.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) JiroTextField *jiroTextField;

//...
self.jiroTextField = [[JiroTextField alloc] initWithFrame:<#CGRect#>];

self.jiroTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.65
self.jiroTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border, default value is R106 G121 B137
self.jiroTextField.borderColor = <#UIColor#>;

// The color of the placeholder, default value is R106 G121 B137
self.jiroTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R211 G226 B226
self.jiroTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R211 G226 B226
self.jiroTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.jiroTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.jiroTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.jiroTextField];
```



### Kaede

![Kaede](Captures/Kaede.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) KaedeTextField *kaedeTextField;

//...
self.kaedeTextField = [[kaedeTextField alloc] initWithFrame:<#CGRect#>];

self.kaedeTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.8
self.kaedeTextField.placeholderFontScale = <#CGFloat#>;

// The color of the foreground, default value is R239 G238 B238
self.kaedeTextField.foregroundColor = <#UIColor#>;

// The color of background, default value is R255 G255 B255
self.kaedeTextField.backgroundColor = <#UIColor#>;

// The color of the placeholder, default value is R106 G121 B137
self.kaedeTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R157 G171 B186
self.kaedeTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R175 G171 B186
self.kaedeTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.kaedeTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.kaedeTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.kaedeTextField];
```



### Madoka

![Madoka](Captures/Madoka.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) MadokaTextField *madokaTextField;

//...
self.madokaTextField = [[MadokaTextField alloc] initWithFrame:<#CGRect#>];

self.madokaTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.75
self.madokaTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border, default value is R122 G117 B147 
self.madokaTextField.borderColor = <#UIColor#>;

// The color of the placeholder, default value is R122 G117 B147
self.madokaTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R122 G117 B147
self.madokaTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R122 G117 B147
self.madokaTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.madokaTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.madokaTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.madokaTextField];
```



### Yoko

![Yoko](Captures/Yoko.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) YokoTextField *yokoTextField;

//...
self.yokoTextField = [[YokoTextField alloc] initWithFrame:<#CGRect#>];

self.yokoTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.7
self.yokoTextField.placeholderFontScale = <#CGFloat#>;

// The color of the foreground, default value is R0 G0 B0
self.yokoTextField.foregroundColor = <#UIColor#>;

// The color of the placeholder, default value is R176 G75 B64
self.yokoTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R245 G245 B245
self.yokoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R245 G245 B245
self.yokoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.yokoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.yokoTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.yokoTextField];
```



### Yoshiko

![Yoshiko](Captures/Yoshiko.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) YoshikoTextField *yoshikoTextField;

//...
self.yoshikoTextField = [[YoshikoTextField alloc] initWithFrame:<#CGRect#>];

self.yoshikoTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.7
self.yoshikoTextField.placeholderFontScale = <#CGFloat#>;

// The color of the active border color, default value is R163 G211 B156
self.yoshikoTextField.activeBorderColor = <#UIColor#>;

// The color of the inactive border color, default value is R208 G209 B208
// Also this is color of the inactive bacoground.
self.yoshikoTextField.inactiveBorderColor = <#UIColor#>;

// The color of the active background, default value is R249 G247 B246
self.yoshikoTextField.activeBackgroundColor = <#UIColor#>;

// The color of the placeholder, default value is R139 G140 B139
self.yoshikoTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R170 G170 B170
self.yoshikoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R170 G170 B170
self.yoshikoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.yoshikoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.yoshikoTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.yoshikoTextField];
```



### Hideo

![Hideo](Captures/Hideo.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) HideoTextField *hideoTextField;

//...
self.hideoTextField = [[HideoTextField alloc] initWithFrame:<#CGRect#>];

self.hideoTextField.placeholder = <#NSString#>;

// The size of the image relative to the original size when animated, default value is 0.7
self.hideoTextField.imageScale = <#CGFloat#>;

// The color of the left container, default value is R137 G157 B218 
self.hideoTextField.imageContainerColor = <#UIColor#>;

// The image of the left container.
self.hideoTextField.image = <#UIImage#>;

// The color of background of text area. default value is R255 G255 B255
self.hideoTextField.backgroundColor = <#UIColor#>;

// The color of the cursor, default value is R170 G170 B170
self.hideoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R170 G170 B170
self.hideoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.hideoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.hideoTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.hideoTextField];
```



### Haruki

![Haruki](Captures/Haruki.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) HarukiTextField *harukiTextField;

//...
self.harukiTextField = [[HarukiTextField alloc] initWithFrame:<#CGRect#>];

self.harukiTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.75
self.harukiTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border, default value is R106 G121 B137 
self.harukiTextField.borderColor = <#UIColor#>;

// The color of the placeholder, default value is R106 G121 B137
self.harukiTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R175 G181 B187
self.harukiTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R175 G181 B187
self.harukiTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.harukiTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.harukiTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.harukiTextField];
```



### Minoru

![Minoru](Captures/Minoru.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) MinoruTextField *minoruTextField;

//...
self.minoruTextField = [[MinoruTextField alloc] initWithFrame:<#CGRect#>];

self.minoruTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.65
self.minoruTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border, default value is R236 G162 B155 
self.minoruTextField.borderColor = <#UIColor#>;

// The color of the placeholder, default value is R106 G121 B137
self.minoruTextField.placeholderColor = <#UIColor#>;

// The color of background of text area, default value is R255 G255 B255
self.minoruTextField.backgroundColor = <#UIColor#>;

// The color of the cursor, default value is R236 G162 B155
self.minoruTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R236 G162 B155
self.minoruTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.minoruTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.minoruTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.minoruTextField];
```



### Kyo

![Kyo](Captures/Kyo.gif)

Note: To dismiss the keyboard, just by press the Return button in the keyboard.

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) KyoTextField *kyoTextField;

//...
self.kyoTextField = [[KyoTextField alloc] initWithFrame:<#CGRect#>];

self.kyoTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.85
self.kyoTextField.placeholderFontScale = <#CGFloat#>;

// The color of the placeholder, default value is R106 G121 B137
self.kyoTextField.placeholderColor = <#UIColor#>;

// The color of background of text area, default value is R255 G255 B255
self.kyoTextField.backgroundColor = <#UIColor#>;

// The color of the overlay, default value is R61 G88 B210 Alpha0.6
self.kyoTextField.overlayColor = <#UIColor#>;

// The color of the cursor, default value is R83 G93 B146
self.kyoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R83 G93 B146
self.kyoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.kyoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.kyoTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.kyoTextField];
```



### Kuro

![Kuro](Captures/Kuro.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) KuroTextField *kuroTextField;

//...
self.kuroTextField = [[KuroTextField alloc] initWithFrame:<#CGRect#>];

self.kuroTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.85
self.kuroTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border, default value is R116 G121 B129
self.kuroTextField.borderColor = <#UIColor#>;

// The color of the placeholder, default value is R223 G101 B137
self.kuroTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R145 G150 B161
self.kuroTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R145 G150 B161
self.kuroTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.kuroTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.kuroTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.kuroTextField];
```



### Ruri

![Ruri](Captures/Ruri.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) RuriTextField *ruriTextField;

//...
self.ruriTextField = [[RuriTextField alloc] initWithFrame:<#CGRect#>];

self.ruriTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.8
self.ruriTextField.placeholderFontScale = <#CGFloat#>;

// The color of the lower border, default value is R183 G195 B172
self.ruriTextField.borderColor = <#UIColor#>;

// The color of the border and the placeholder when the text field is not empty or focused, default value is R163 G211 B156
self.ruriTextField.activeColor = <#UIColor#>;

// The color of the placeholder, default value is R105 G105 B105
self.ruriTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R255 G255 B255
self.ruriTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R255 G255 B255
self.ruriTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.ruriTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.ruriTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.ruriTextField];
```



### Chisato

![Chisato](Captures/Chisato.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) ChisatoTextField *chisatoTextField;

//...
self.chisatoTextField = [[ChisatoTextField alloc] initWithFrame:<#CGRect#>];

self.chisatoTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.8
self.chisatoTextField.placeholderFontScale = <#CGFloat#>;

// The color of the border bounds, default value is R181 G181 B181
self.chisatoTextField.borderColor = <#UIColor#>;

// The color of the border and the placeholder when the text field is not empty or focused, default value is R218 G100 B132
self.chisatoTextField.activeColor = <#UIColor#>;

// The color of the placeholder, default value is R181 G181 B181
self.chisatoTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R181 G181 B181
self.chisatoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R181 G181 B181
self.chisatoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.chisatoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.chisatoTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.chisatoTextField];
```



### Manami

![Manami](Captures/Manami.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) ManamiTextField *manamiTextField;

//...
self.manamiTextField = [[ManamiTextField alloc] initWithFrame:<#CGRect#>];

self.manamiTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.9
self.manamiTextField.placeholderFontScale = <#CGFloat#>;

// The color of the lower border, default value is R168 G168 B168
self.manamiTextField.borderColor = <#UIColor#>;

// The color of the text area background, default value is R168 G168 B168
self.manamiTextField.backgroundColor = <#UIColor#>;

// The color of the placeholder, default value is R105 G105 B105
self.manamiTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R249 G247 B246
self.manamiTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R249 G247 B246
self.manamiTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.manamiTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.manamiTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.manamiTextField];
```



### Nariko

![Nariko](Captures/Nariko.gif)

```objective-c
#import "CCTextFieldEffects.h"

//...
@property (strong, nonatomic) NarikoTextField *narikoTextField;

//...
self.narikoTextField = [[NarikoTextField alloc] initWithFrame:<#CGRect#>];

self.narikoTextField.placeholder = <#NSString#>;

// The size of the placeholder label relative to the font size of the text field, default value is 0.85
self.narikoTextField.placeholderFontScale = <#CGFloat#>;

// The color of the lower border, default value is R155 G159 B159
self.narikoTextField.borderColor = <#UIColor#>;

// The color of the text area background, default value is R255 G255 B255
self.narikoTextField.backgroundColor = <#UIColor#>;

// The color of the placeholder, default value is R155 G159 B159
self.narikoTextField.placeholderColor = <#UIColor#>;

// The color of the cursor, default value is R241 G130 B146
self.narikoTextField.cursorColor = <#UIColor#>;

// The color of the text, default value is R241 G130 B146
self.narikoTextField.textColor = <#UIColor#>;

// ------------- Do not use UITextFieldDelegate -------------
// The block excuted when the animation for obtaining focus has completed.
self.narikoTextField.didBeginEditingHandler = ^{
    // ...
};

// The block excuted when the animation for losing focus has completed.
self.manamiTextField.didEndEditingHandler = ^{
    // ...
};
// ---------------------------------------------------------

[self.view addSubview:self.narikoTextField];
```



## TODO

- More types of effects.

