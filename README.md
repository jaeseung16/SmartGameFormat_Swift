# SmartGameFormat_Swift
![](https://img.shields.io/badge/version-0.1.0-blue)
![](https://img.shields.io/badge/license-MIT-green)
![](https://img.shields.io/badge/last%20updated-October%202020-orange)

Copyright (c) 2021 Jae-Seung Lee

License: MIT License

SmartGameFormat_Swift is a Swift package parsing the smart game format.<sup>1,2</sup> The implementation is based on SGF Summarizer.<sup>3</sup>

## References

1. [SGF File Format FF[4]](https://www.red-bean.com/sgf/index.html)
2. [Smart Game Format in Sensei's Library](https://senseis.xmp.net/?SmartGameFormat#toc7)
3. [GO Tools: SGF Summarizer](http://gotools.sourceforge.net/sgfsummary/index.html)
4. [SGF](https://homepages.cwi.nl/~aeb/go/misc/sgfnotes.html)

## Usage

Initialize `SGFParser` with a string. `SGFParser` has a method `parse()` to convert the string input to an array of `SGFGameTree`'s.

```swift
let parser = SGFParser(sgfString)
do {
  try parser.parse()
} catch {
  print("Failed parsing sgfString: \(error)")
}
```

Then, the `SGFGameTree` instance can be accessed for your application.

```swift
let gameTree = parser.gameTrees[0]
let node = gameTree.rootNode
```

`SGFGameTree` has a property `sgfString`, which can be saved as a `.sgf` file.

## Uopdate History

### Version 0.1.0 (1/20/2021)
