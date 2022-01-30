

import UIKit


class ViewController: UIViewController {

  //----------------------------------------------------------------------------
  // MARK: - Outlet
  //----------------------------------------------------------------------------

  @IBOutlet weak var textView: UITextView!

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------

  var calculator = Calculator()

  //----------------------------------------------------------------------------
  // MARK: - Methods
  //----------------------------------------------------------------------------

  /******************** View Did Load ********************/

  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    calculator.delegate = self
    textView.isEditable = false
    textView.text = ""
  }

  /******************** Alert ********************/

  /// Present alerte.
  /// - Parameter message: Choose message.
  func displayAlert(message: String) {
    let alertVC = UIAlertController(title: "Erreur!",
                                    message: message,
                                    preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alertVC, animated: true, completion: nil)
  }

  //----------------------------------------------------------------------------
  // MARK: - Number
  //----------------------------------------------------------------------------

  /// Add number for compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    calculator.addNumber(number: numberText)
  }
    
    
    @IBAction func tappedVirguleButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
          return
        }
        calculator.addNumber(number: ".")      }
    
  //----------------------------------------------------------------------------
  // MARK: - Operator
  //----------------------------------------------------------------------------

  /// Add plus in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
    calculator.adder()
  }

  /// Add minus in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    calculator.subtract()
  }

  /// Add multiply sign in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedMutiplicationButton(_ sender: UIButton) {
    calculator.multiply()
  }

  /// Add divided sign in the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedDivideButton(_ sender: UIButton) {
    calculator.divide()
  }

  //----------------------------------------------------------------------------
  // MARK: - Clear
  //----------------------------------------------------------------------------

  /// Remove the elements of the compute.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedClearExpression(_ sender: UIButton) {
    calculator.clear()
  }

  //----------------------------------------------------------------------------
  // MARK: - Equal
  //----------------------------------------------------------------------------

  /// Compute elements.
  /// - Parameter sender:  button who am the action
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    calculator.calculate()
  }
}

extension ViewController: CalculatorDelegate {
  
  func didAddOperatorFail() {
    displayAlert(message: "Un operateur est déja mis!")
  }

  func didEqualErrorDisplay() {
    displayAlert(message: "Démarrez un nouveau calcul !")
  }

  func didExpressionErrorDisplay() {
    displayAlert(message: "Entrez une expression correcte !")

  }
  func didCompute(textModel: String) {
    textView.text = textModel
  }
}

