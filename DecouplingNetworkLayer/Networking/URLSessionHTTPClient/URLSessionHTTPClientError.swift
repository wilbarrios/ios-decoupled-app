import Foundation

public enum URLSessionHTTPClientError: Error {
  case noData
  case error(Error)
  case unknown(Data?, URLResponse?, Error?)
}
