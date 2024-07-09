//
//  ResponseUtil.swift
//  CapThat
//
//  Created by Aman Kumar on 09/07/24.
//

import Foundation

struct ResponseUtil {
    static let shared = ResponseUtil()
    
    func readJSONFromFile(fileName: String) -> Data? {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("File not found.")
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print("Error reading data: \(error)")
            return nil
        }
    }

    func parseJSON() -> SpeechModel? {
        guard let jsonData = readJSONFromFile(fileName: "response") else {
            return nil
        }

        do {
            let decoder = JSONDecoder()
            let decodeResponse = try decoder.decode(SpeechModel.self, from: jsonData)
            return decodeResponse
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
