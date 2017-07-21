//: Playground - noun: a place where people can play

import UIKit

// Loop characters
var str = "Hello, playground"
print("Loop characters")
for char in str {
    print(char)
}

// Character count
var wordInSpanish = "Cantare"
print("\"\(wordInSpanish)\" chracters count: \(wordInSpanish.count)")
wordInSpanish += "\u{301}"
print("\"\(wordInSpanish)\" chracters count: \(wordInSpanish.count)")

// Indices
var phrase = "This is a very long phrase"
print("Index handling examples for: \(phrase)")
// Accessing first chracter
let firstChar = phrase[phrase.startIndex]
print("First chracter: \(firstChar)")
// 'before' index access
let previousChar = phrase[phrase.index(before: phrase.endIndex)]
print("The character before the last one: \(previousChar)") // Prints "e" because the real end character is end of string
// 'after' index access
let nextChar = phrase[phrase.index(after: phrase.startIndex)]
print("The character after the first one: \(nextChar)")
// Access a specific index
let intIndex = 5
var sixthChar = phrase[phrase.index(phrase.startIndex, offsetBy: intIndex)]
print("Fifth character: \(sixthChar)")
// Test access limitation
let intLimit = 4
let limitIndex = phrase.index(phrase.startIndex, offsetBy: intLimit)
let accessIndex = phrase.index(phrase.startIndex, offsetBy: intIndex, limitedBy: limitIndex)
if (accessIndex == nil) {
    print("Cannot get index because is out of limit")
}
// Accessing every index
print("Accessing every index")
for index in phrase.indices {
    print("\(phrase[index])")
}
// Inserting
print("Inserting elements")
let firstInsertionIndex = phrase.endIndex
phrase.insert("!", at: firstInsertionIndex)
print("First insertion \(phrase)")
let secondInsertionIndex = phrase.index(phrase.startIndex, offsetBy: 10)
phrase.insert(contentsOf: "really ", at: secondInsertionIndex)
print("Second insertion \(phrase)")
//Remove
print("Removing elements")
let removalIndex = phrase.index(before: phrase.endIndex)
phrase.remove(at: removalIndex)
print("Index removal: \(phrase)")
let removalRange = phrase.index(phrase.startIndex, offsetBy: 10)..<phrase.index(phrase.startIndex, offsetBy: 17)
phrase.removeSubrange(removalRange)
print("Range removal: \(phrase)")

// Substrings
let substringIndex = phrase.index(of: "s") ?? phrase.endIndex
let substring = phrase[..<substringIndex]
// let newString = String(substring) // Creates a real string (without reference to the main string)
print("Substring: \(substring)")

// String comparison (different strings with equivalent grapheme cluster)
let wantCoffe1 = "Quieres un caf\u{E9}?"
let wantCoffe2 = "Quieres un caf\u{65}\u{301}?"
if wantCoffe1 == wantCoffe1 {
    print("String \"\(wantCoffe1)\" is equivalent to \"\(wantCoffe2)\"")
}

// Prefixes and sufixes
let checkText = "Everything that has a beginning has an end"
print("Check prefixes and suffixes for \"\(checkText)\"")
let evePrefix = "Eve"
if checkText.hasPrefix(evePrefix) {
    print("It has the prefix: \"\(evePrefix)\"")
}
let endSuffix = "end"
if checkText.hasSuffix(endSuffix) {
    print("It has the suffix: \"\(endSuffix)\"")
}

// Lower case and upper case
let songName = "The name of the song is \"Hey Now Now\""
print("Original text: \"\(songName)\"")
let upperCasedSongName = songName.uppercased()
print("Upper text: \"\(upperCasedSongName)\"")
let lowerCasedSongName = songName.lowercased()
print("Lower text: \"\(lowerCasedSongName)\"")

let ex = "caf\u{65}\u{301}"
let exc = ex.count

// Unicode string representations
let emojisText = "I'm ✈️ tomorrow, it was 💸, but I'll ❤️ it"
print("Representation of the text \"\(emojisText)\" with different encodings")
print("UTF8 representation")
for codeUnit in emojisText.utf8 {
    print("\(codeUnit)")
}
print("UTF16 representation")
for codeUnit in emojisText.utf16 {
    print("\(codeUnit)")
}
print("Unicode Scalar representation")
for codeUnit in emojisText.unicodeScalars {
    print("\(codeUnit)")
}

// Replace string with another
let toReplace = "I love apples, apples are tasty"
print("Text before replacement: \(toReplace)")
let replacedText = toReplace.replacingOccurrences(of: "apples", with: "oranges")
print("Text after replacement: \(replacedText)")

// Split string by a given character
let toSplit = "This can be better."
print("String to split by whitespace: \(toSplit)")
let splitSubstrings = toSplit.components(separatedBy: " ")
print("Split substrings: ")
for substring in splitSubstrings {
    print("\(substring)")
}

// Check if a string contains another string
let mainString = "Swift for iOS"
let subString = "iOS"
print("Check if \"\(mainString)\" contains \"\(subString)\"")
if mainString.range(of: subString) != nil {
    print("Contains substring")
}

