# ePub Boilerplate

## Features

* ePub v3.2 compliant book template, validated against the ePub standard with [epubchecker](https://www.w3.org/publishing/epubcheck/)
* Word count auto-inserted in the frontmatter
* ePub generation date auto-inserted into front-matter
* Minimal CSS
* Separate CSS for base, frontmatter, bodymatter

## Gallery

| Frontmatter | Chapter example | Script |
| --- | --- | --- |
| <img src="https://github.com/geonaut/epub-boilerplate/blob/main/gallery/frontmatter_screenshot.png" width="250"> | <img src="https://github.com/geonaut/epub-boilerplate/blob/main/gallery/chapter_1_screenshot.png" width="250"> | <img src="https://github.com/geonaut/epub-boilerplate/blob/main/gallery/script_output.png" width="250"> |

## Style Guide

* 12pt Times New Roman
* Indentation on every paragraph except first

## Requirements

* Scripts written on macos using zsh
* Requires JRE (setup script will install)
* Requires a local copy of the epubchecker .jar file (setup script will download)

## Setup

* Run `build first_setup.sh` to install a local version of Java (JRE) and download the epubchecker java file epuchecker.jar. This will put a copy of the Java JRE and the epubchecker .jar in a `bin` folder

## Usage

The epub name is `book` and this is hardcoded into the scripts.

`./publish` to create book.epub in the root folder
`./publish -c` to include an epub check, using the standard epubchecker

Warning! The publish script deletes the previous book.epub file each time you generate a new one. I suggest you use git to track your text changes, and consider the ebook a disposable output file.

## xhtml Style

Code is formatted using Prettier VSCode plugin