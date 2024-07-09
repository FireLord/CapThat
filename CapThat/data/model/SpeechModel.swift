//
//  SpeechModel.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import Foundation

struct SpeechModel: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let channels: [Channel]
}

// MARK: - Channel
struct Channel: Codable {
    let alternatives: [Alternative]
}

// MARK: - Alternative
struct Alternative: Codable {
    let transcript: String
    let confidence: Double
    let words: [Word]
    let paragraphs: Paragraphs
}

// MARK: - Paragraphs
struct Paragraphs: Codable {
    let transcript: String
    let paragraphs: [Paragraph]
}

// MARK: - Paragraph
struct Paragraph: Codable {
    let sentences: [Sentence]
    let numWords: Int
    let start, end: Double

    enum CodingKeys: String, CodingKey {
        case sentences
        case numWords = "num_words"
        case start, end
    }
}

// MARK: - Sentence
struct Sentence: Codable {
    let text: String
    let start, end: Double
}

// MARK: - Word
struct Word: Codable {
    let word: String
    let start, end, confidence: Double
    let punctuatedWord: String

    enum CodingKeys: String, CodingKey {
        case word, start, end, confidence
        case punctuatedWord = "punctuated_word"
    }
}
