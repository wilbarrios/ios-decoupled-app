import Foundation

public final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession
  
  public init(session: URLSession = URLSession.shared) {
    self.session = session
  }
  
  // MARK: - HTTP Client
  public func get(_ url: URL, responseHandler: @escaping (ResponseResult) -> Void) {
    session.dataTask(with: url) { data, response, error in
      let handledResponse = Self.handle(data: data, error: error, response: response)
      switch handledResponse {
      case .success(let _data):
        responseHandler(.success(_data))
      case .failure(let _error):
        responseHandler(.failure(_error))
      }
    }.resume()
  }
}

// MARK: - Response handlers
extension URLSessionHTTPClient {
  internal static func handle(data: Data?, error: Error?, response: URLResponse?) -> Result<Data,URLSessionHTTPClientError> {
    if let _data = data,
       error == nil,
       let _response = response,
       let _ = _response as? HTTPURLResponse
    {
      return .success(_data)
    }
    
    if let _error = error {
      return .failure(.error(_error))
    }
    
    return .failure(.unknown(data, response, error))
  }
}
