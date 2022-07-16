import Foundation

public enum URLSessionHTTPClientError: Error {
  case error(Error)
  case unknown(Data?, URLResponse?, Error?)
}
