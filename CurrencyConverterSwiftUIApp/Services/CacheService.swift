//
//  CacheService.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation

extension NetworkService {
    actor CacheService {        
		func retriveCache<T: Codable>(for name: String) -> T? {
			return Cache.retrieveData(forKey: name)
	    }

		func storeCache<T: Codable>(data: T, for name: String) {
			Cache.storeData(data, forKey: name)
        }
    }
}
