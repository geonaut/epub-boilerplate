# ePub Boilerplate

## Features

* ePub v3.2 compliant book template, validated against the ePub standard with [epubchecker](https://www.w3.org/publishing/epubcheck/)
* Word count auto-inserted in the frontmatter
* ePub generation date auto-inserted into front-matter
* Minimal CSS
* Separate CSS for base, frontmatter, bodymatter

## Gallery
<!-- ![ch01](https://github.com/geonaut/epub-boilerplate/blob/main/gallery/chapter_1_screenshot.png | width=100) -->
<img src="https://github.com/geonaut/epub-boilerplate/blob/main/gallery/chapter_1_screenshot.png" width="100">

<!-- ![frontmatter](https://github.com/geonaut/epub-boilerplate/blob/main/gallery/frontmatter_screenshot.png | width=100)

![script](https://github.com/geonaut/epub-boilerplate/blob/main/gallery/script_ouput.png | width=100) -->

## Style Guide

* 12pt Times New Roman
* Indentation on every paragraph except first

## Requirements

* Created on macos using zsh
* Requires JRE
* Requires a local copy of the epubchecker .jar file

## Setup

* Run `build first_setup.sh` to install a local version of Java (JRE) and download the epubchecker java file epuchecker.jar. This will put a copy of the Java JRE and the epubchecker .jar in a `bin` folder

## Usage

The epub name is `book` and this is hardcoded into the scripts.

`./publish` to create book.epub in the root folder
`./publish -c` to include an epub check, using the standard epubchecker

## xhtml Style

Code is formatted using Prettier VSCode plugin