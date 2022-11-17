import RadioGroup
import UIKit

class NewTagViewController: GMMainViewController {
    // MARK: - Properties

    var onSaveTag: ((TransactionTag) -> Void)?

    private let viewModel = NewTagViewModel()

    private lazy var label = GMLabel(text: "New category", style: .largeBold)

    private lazy var tagImage: GMExpenseIcon = {
        let icon = GMExpenseIcon()
        icon.loadIcon(src: "logo")
        icon.layer.borderWidth = 1
        icon.layer.borderColor = K.Color.actionBackground.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openIconCollection))
        icon.addGestureRecognizer(tapGesture)
        return icon
    }()

    private lazy var tagName: ExpenseTextField = {
        let textField = ExpenseTextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = .nova(24)
        textField.placeholder = "Enter category name"
        textField.delegate = self
        textField.becomeFirstResponder()
        textField.focusedborderColor = K.Color.actionBackground
        return textField
    }()

    private lazy var radioGroup: RadioGroup = {
        let radioGroup = RadioGroup(titles: [
            ExpenseType.expense.rawValue,
            ExpenseType.income.rawValue,
        ])
        radioGroup.selectedIndex = 0

        radioGroup.tintColor = .action
        radioGroup.selectedColor = .action
        radioGroup.selectedTintColor = .action

        radioGroup.titleFont = .nova(24)

        radioGroup.translatesAutoresizingMaskIntoConstraints = false
        return radioGroup
    }()

    // TODO: Expense Limit

    private lazy var saveBtn = GMButton(
        text: "Save",
        color: K.Color.actionBackground,
        tapAction: { [weak self] in
            guard let src = self?.tagImage.imageSrc,
                  let name = self?.tagName.text?.trimmingCharacters(in: .whitespacesAndNewlines),
                  name.isEmpty == false
            else {
                self?.errorAlert(message: "Tag invalid!")
                return
            }

            let type: ExpenseType = self?.radioGroup.selectedIndex == 0 ? .expense : .income
            let newTag = TransactionTag(name: name, icon: src, type: type)
            TagService.shared.add(tag: newTag) { err in
                if let err = err {
                    self?.errorAlert(message: err)
                } else {
                    self?.onSaveTag?(newTag)
                    self?.dismiss(animated: true)
                }
            }
        })

    override func setupLayout() {
        super.setupLayout()
        view.backgroundColor = .white

        view.addSubviews(
            label,
            saveBtn,
            tagImage,
            tagName,
            radioGroup)

        label.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            paddingTop: 16)
        label.centerX(inView: view)

        saveBtn.anchor(
            top: label.topAnchor,
            right: view.rightAnchor,
            paddingRight: 16)

        tagImage.anchor(
            top: label.bottomAnchor,
            left: view.leftAnchor,
            paddingTop: 32,
            paddingLeft: 16,
            width: 65,
            height: 65)

        tagName.anchor(
            top: tagImage.topAnchor,
            left: tagImage.rightAnchor,
            right: saveBtn.rightAnchor,
            paddingLeft: 32,
            height: 65)

        radioGroup.anchor(
            top: tagName.bottomAnchor,
            left: tagName.leftAnchor,
            right: tagName.rightAnchor,
            paddingTop: 16)
    }

    @objc
    private func openIconCollection() {
        let vc = IconCollectionVC()

        vc.didSelect = { iconSrc in
            self.tagImage.imageSrc = iconSrc
        }

        present(vc, animated: true)
    }
}

extension NewTagViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tagName {
            textField.resignFirstResponder()
        }
        return true
    }
}

class NewTagViewModel {}
