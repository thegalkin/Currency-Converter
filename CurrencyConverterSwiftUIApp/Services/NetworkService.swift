import Foundation

actor NetworkService {
    private let baseURL = "https://api.freecurrencyapi.com/v1"
    private let apikey: String = tokenSecret
	private let jsonEncoder = JSONEncoder()
	private let jsonDecoder = JSONDecoder()
	private let cacheService = CacheService()
    
	func getStatus() async throws -> Status.Output {
		let input = Status.Input(apikey: self.apikey)
		return try await fetchData(requestModel: Status.self, input: input, for: .status)
    }
    
	func getCurrencies(currencies: [String]? = nil) async throws -> Currencies.Output {
		let input = Currencies.Input(apikey: self.apikey, currencies: currencies)
		return try await fetchData(requestModel: Currencies.self, input: input, for: .currencies)
    }
    
	func getLatest(baseCurrency: String? = nil, currencies: [String]? = nil) async throws -> LatestRates.Output {
		let input = LatestRates.Input(apikey: self.apikey, base_currency: baseCurrency, currencies: currencies)
		return try await fetchData(requestModel: LatestRates.self, input: input, for: .latest)
    }
    
	private func fetchData<T: RequestModelProtocol>(requestModel: T.Type, input: T.Input,for endpoint: Endopont) async throws -> T.Output {
		let encoded = try self.jsonEncoder.encode(input)
		let typeName: String = String(describing: T.Output.self)
		guard let request: URLRequest = try makeURLRequest(for: endpoint, input: input) else {
			throw NetworkingError.invalidURL
		}
		do {
			let (data, response) = try await URLSession.shared.data(for: request)
			let decodedData: T.Output = try self.jsonDecoder.decode(T.Output.self, from: data)
			if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
				await self.cacheService.storeCache(data: decodedData, for: typeName)
			}
			return decodedData
		} catch {
			guard let cachedResult: T.Output = await self.cacheService.retriveCache(for: typeName) else {
				throw NetworkingError.networkFailureAndCacheEmpty
			}
			return cachedResult
		}
    }
	
	private func makeURLRequest<T: Codable>(for endpoint: Endopont, input: T) throws -> URLRequest? {
		let url: String = baseURL + endpoint.path
		var request = createRequestWithCodableInURL(urlString: url, codableData: input)
		request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
		switch endpoint {
			default: 
				request?.httpMethod = "GET"
		}
		return request
	}
}

extension NetworkService {
	enum Endopont {
		case status
		case currencies
		case latest
		var path: String {
			switch self {
			case .status:
				return "/status"
			case .currencies:
				return "/currencies"
			case .latest:
				return "/latest"
			}
		}
	}
}


enum NetworkingError: Error {
    case invalidURL
    case networkError(Error)
	case networkFailureAndCacheEmpty
}


extension NetworkService {
	func convertToQueryString(from dictionary: [String: Any]) -> String {
		var components = URLComponents()
		components.queryItems = dictionary.map {
			URLQueryItem(name: $0.key, value: String(describing: $0.value))
		}
		return components.url?.query ?? ""
	}
	
	func createRequestWithCodableInURL<T: Codable>(urlString: String, codableData: T) -> URLRequest? {
		guard let parameters = codableData.toDictionary() else { return nil }
		guard var urlComponents = URLComponents(string: urlString) else { return nil }
		
		let queryString = convertToQueryString(from: parameters)
		urlComponents.query = queryString
		
		guard let url = urlComponents.url else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = "GET" // Typically used for GET requests
		
		return request
	}
}
