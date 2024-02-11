//
//  KeychainManager.swift
//  Curency Converter
//
//  Created by Никита Галкин on 2/11/24.
//

import Foundation
import Security

final actor KeychainManager {
	static func save(key: String, data: Data) -> OSStatus {
		let query = [
			kSecClass as String: kSecClassGenericPassword as String,
			kSecAttrAccount as String: key,
			kSecValueData as String: data
		] as [String: Any]
		
		SecItemDelete(query as CFDictionary)
		return SecItemAdd(query as CFDictionary, nil)
	}
	
	static func load(key: String) -> Data? {
		let query = [
			kSecClass as String: kSecClassGenericPassword,
			kSecAttrAccount as String: key,
			kSecReturnData as String: kCFBooleanTrue!,
			kSecMatchLimit as String: kSecMatchLimitOne
		] as [String: Any]
		
		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)
		if status == noErr {
			return item as? Data
		}
		return nil
	}
}
