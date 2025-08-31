# otaku2
Create PDF from png to read on Kindle.

DISCLAIMER: This article serves educational purposes only.

## Config 
Darwin Mac 24.1.0 Darwin Kernel Version 24.1.0: Thu Nov 14 18:19:02 PST 2024; root:xnu-11215.41.3~13/RELEASE_ARM64_T8132 arm64

## Prerequisite

### Media

We subscribe to [Manga PLus](https://www.viz.com/](https://mangaplus.shueisha.co.jp/updates)) but it doesn't provide the pictures so we use tier providers 
- [OnePiece](https://nyaa.si/view/1943212)
- [Naruto](https://nyaa.si/view/1619360)
- [DeliciousInDungeon](https://nyaa.si/view/1849177)


### Applications
```Bash
brew install imagemagick
brew install img2pdf
brew install qpdf
chmod +x script_[name].sh
```
We tried to use MacOS tools, `shortcuts` and `automator` it proved to be a massive waste of time.

## Usage

To create the PDFs:
```Bash
./script_[name].sh
```
Then we use Amazon website to send to [Kindle](https://www.amazon.com/sendtokindle).

## Available titles

- Naruto
- OnePiece

## Debug

- Install the extension `Bash Debug` and `BashCheck` for `VSCode`
- Install `bashdb`

```Bash
sudo apt install bashdb
brew install bashdb
```
