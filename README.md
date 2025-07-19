# ePub Boilerplate

## Features

* ePub v3.2 compliant book template
* Word count auto-inserted in the frontmatter
* ePub generation date auto-inserted into front-matter
* Minimal CSS
* Separate CSS for front/bodymatter

## Style Guide

* 12pt Times New Roman
* Indentation on every paragraph except first

## Requirements

* Created on macos using zsh
* Requires JRE
* Requires a local copy of the epubchecker .jar file

## Setup

* Run `build first_setup.sh` to install a local version of Java (JRE) and download the epubchecker java file epuchecker.jar

## Usage

`./publish book` to create book.epub in the root folder
`./publish book -c` to include an epub check, using the standard epubchecker

## xhtml Style

Code is formatted using Prettier VSCode plugin