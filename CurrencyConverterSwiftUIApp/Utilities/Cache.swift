//
//  Cache.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

struct Cache {
    static let cacheDirectory: URL = {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let cacheURL = cacheDirectory.appendingPathComponent("Cache")
        
        if !fileManager.fileExists(atPath: cacheURL.path) {
            do {
                try fileManager.createDirectory(at: cacheURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                fatalError("Failed to create cache directory: \(error)")
            }
        }
        
        return cacheURL
    }()
    
    static func storeData<T: Codable>(_ data: T, forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        
        do {
            let encodedData = try JSONEncoder().encode(data)
            try encodedData.write(to: fileURL)
        } catch {
            print("Failed to store data in cache: \(error)")
        }
    }
    
    static func retrieveData<T: Codable>(forKey key: String) -> T? {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Failed to retrieve data from cache: \(error)")
            return nil
        }
    }
    
    static func removeData(forKey key: String) {
        let fileURL = cacheDirectory.appendingPathComponent(key)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print("Failed to remove data from cache: \(error)")
        }
    }
}
