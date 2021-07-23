[![Codemagic build status](https://api.codemagic.io/apps/60cc81ba9b56df2eb2bf3f8a/60cc81ba9b56df2eb2bf3f89/status_badge.svg)](https://codemagic.io/apps/60cc81ba9b56df2eb2bf3f8a/60cc81ba9b56df2eb2bf3f89/latest_build)
# Owlbot app
App that uses Owlbot API to define words. 

This is mainly a practise project to learn about Flutter and Dart. I copied some of the looks from [another owlbot app](https://play.google.com/store/apps/details?id=de.bergerapps.owlbot).

## Installation and building
You are going to need your own token which you can register at [https://owlbot.info/](https://owlbot.info/). Then you have to add "secrets" folder at project root and add file "secrets.json" with format like this: `{"token":"your token"}`. You also might need to run in your terminal a command `flutter pub run build_runner build -delete-conflicting-outputs`.

## Possible future stuff to do
- widget and integration testing
- light/dark mode

## Super secret stuff!
In the app there is nothing telling this but if word has image (for example, word "cat" has image) then clicking the image will open the image in the browser.