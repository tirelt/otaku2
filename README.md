# otaku2
Create PDF from png to read on Kindle

## Config 
Darwin Mac 24.1.0 Darwin Kernel Version 24.1.0: Thu Nov 14 18:19:02 PST 2024; root:xnu-11215.41.3~13/RELEASE_ARM64_T8132 arm64

## Prerequisite

### Media

We subscribe to [VIZ](https://www.viz.com/) but it doesn't provide the pictures so we use a tier provider [1r0n](https://nyaa.si/view/1943212).

### Applications
```Bash
brew install imagemagick
brew install img2pdf
brew install qpdf:w
chmod +x script.sh
```
We tried to use MacOS tools, `shortcuts` and `automator` it proved to be a massive waste of time.
## Usage
To create the PDFs:
```Bash
./script.sh
```
Then we use Amazon website to send to [Kindle](https://www.amazon.com/sendtokindle).