final class DogFactsViewModel {
  private let repository: DogFactsRepository
  
  private let onSuccess: (_ factValue: String) -> Void
  private let onError: (_ errorMessage: String) -> Void
  
  init(
    repository: DogFactsRepository,
    onSuccess: @escaping (_ factValue: String) -> Void,
    onError: @escaping (_ errorMessage: String) -> Void
  ) {
    self.repository = repository
    self.onSuccess = onSuccess
    self.onError = onError
  }
  
  func load() {
    fetch()
  }
  
  func fetchAnotherFact() {
    fetch()
  }
  
  private func fetch() {
    repository.getRandomFact { [unowned self] result in
      switch result {
      case .success(let factData):
        self.onSuccess(factData.factMessage)
      case .failure(let error):
        self.onError(error.localizedDescription)
      }
    }
  }
}
