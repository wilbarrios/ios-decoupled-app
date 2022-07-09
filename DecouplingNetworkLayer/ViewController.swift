import UIKit

fileprivate func makeRepository() -> DogFactsRepository {
  DogFactsRemoteRepository(
    httpClient: URLSessionHTTPClient(),
    api: .dev
  )
}

fileprivate func makeViewModel(
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

class ViewController: UIViewController {
  
  private var viewModel: DogFactsViewModel!
  
  @IBOutlet weak var factLabel: UILabel!
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    self.viewModel = makeViewModel(
      repository: makeRepository(),
      onSuccess: onSuccess(factMessage:),
      onError: onError(errorMessage:)
    )
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.load()
    print(Self.self, #function)
  }

  // MARK: - Binding
  func onSuccess(factMessage: String) {
    factLabel.text = factMessage
    print(Self.self, #function, factMessage)
  }
  
  func onError(errorMessage: String) {
    print(Self.self, #function, errorMessage)
  }
}

