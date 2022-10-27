import UIKit
final class DogFactsBuilder {
  private let environment: DogFactsAPI
  
  init(environment: DogFactsAPI) {
    self.environment = environment
  }
  
  func buildRoot() -> UIViewController? {
    let viewController = instantiateViewController(
      .root, on: .main,
      as: DogFactViewController.self
    )
    
    let viewModel = makeViewModel(
      repository: makeRepository(environment: environment),
      onSuccess: { [weak viewController] in viewController?.onSuccess(factMessage: $0) },
      onError: { [weak viewController] in viewController?.onError(errorMessage: $0) }
    )
    
    viewController?.viewModel = viewModel
    return viewController
  }
}

// MARK: - Application identifiers
fileprivate extension DogFactsBuilder {
  struct DogFactsUI {
    enum Storyboard: String {
      case main = "Main"
    }
    
    enum ViewController: String {
      case root = "DogFactViewController"
    }
  }
}

// MARK: - Storyboard factory helpers
fileprivate extension DogFactsBuilder {
  private static var bundle: Bundle { Bundle(for: Self.self) }
    
  func instantiateViewController<T>(_ viewController: DogFactsUI.ViewController, on storyboard: DogFactsUI.Storyboard, as type: T.Type) -> T? {
    instantiateViewController(
      identifier: viewController.rawValue,
      storyboard: instantiateStoryboard(
        name: storyboard.rawValue
      )
    ) as? T
  }
  
  private func instantiateStoryboard(name: String, bundle: Bundle = bundle) -> UIStoryboard {
    UIStoryboard(name: name, bundle: bundle)
  }
  
  private func instantiateViewController(identifier: String, storyboard: UIStoryboard) -> UIViewController {
    storyboard.instantiateViewController(withIdentifier: identifier)
  }
}

// MARK: - Feature factory helpers
fileprivate extension DogFactsBuilder {
  func makeRepository(environment: DogFactsAPI) -> DogFactsRepository {
    DogFactsRemoteRepository(
      httpClient: URLSessionHTTPClient(),
      api: environment
    )
  }

  func makeViewModel(
    repository: DogFactsRepository,
    onSuccess: @escaping (_ factValue: String) -> Void,
    onError: @escaping (_ errorMessage: String) -> Void
  ) -> DogFactsViewModel {
    DogFactsViewModel(
      repository: repository,
      onSuccess: onSuccess,
      onError: onError
    )
  }
}
