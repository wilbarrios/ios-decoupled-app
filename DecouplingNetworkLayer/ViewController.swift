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
  
  @IBOutlet weak var factTextView: UITextView!
  
  // MARK: - Initialization
  
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
      onSuccess: { [unowned self] in self.onSuccess(factMessage: $0) },
      onError: { [unowned self] in self.onError(errorMessage: $0) }
    )
  }
  
  // MARK: - User interaction
  
  @IBAction func fetchAnotherFactClicked(_ sender: Any) {
    viewModel.onUserInput(.fetchFactClicked)
  }
  
  // MARK: - VC Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.load()
    print(Self.self, #function)
  }

  // MARK: - Binding
  func onSuccess(factMessage: String) {
    factTextView.text = factMessage
    print(Self.self, #function, factMessage)
  }
  
  func onError(errorMessage: String) {
    print(Self.self, #function, errorMessage)
  }
}

extension ViewController {
  enum UserInput {
    case fetchFactClicked
  }
}

