import UIKit

final class DogFactViewController: UIViewController {
  
  var viewModel: DogFactsViewModel!
  
  @IBOutlet weak var factTextView: UITextView!
  
  // MARK: - User interaction
  
  @IBAction func fetchAnotherFactClicked(_ sender: Any) {
    viewModel.onUserInput(.fetchFactClicked)
  }
  
  // MARK: - VC Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.fetchRandomFact()
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
