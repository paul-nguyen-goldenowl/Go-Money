/// https://github.dev/sag333ar/InputViews

import UIKit

public class AccessoryView: UIView {
    lazy var toolBar = UIToolbar()

    lazy var doneItem: UIBarButtonItem = {
        let doneItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )

        doneItem.setTextAttributes(font: UIFont(name: K.Font.nova, size: 16))

        return doneItem
    }()

    lazy var addItem: UIBarButtonItem = {
        let addItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        return addItem
    }()

    var title = ""
    var doneTapped: (() -> Void)?
    var addTapped: (() -> Void)?
    var shouldShowAdd = false
    var height: CGFloat = 44

    override public func didMoveToWindow() {
        super.didMoveToWindow()
        toolBar.frame = bounds

        let spaceBefore = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let spaceAfter = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let title = UIBarButtonItem(
            title: self.title,
            style: .plain,
            target: nil,
            action: nil
        )

        title.setTextAttributes(font: UIFont(name: K.Font.novaBold, size: 16.0), state: .disabled)

        title.isEnabled = false

        if shouldShowAdd {
            toolBar.setItems([addItem, spaceBefore, title, spaceAfter, doneItem], animated: true)
        } else {
            toolBar.setItems([spaceBefore, title, spaceAfter, doneItem], animated: true)
        }
    }

    init(
        _ title: String = "",
        doneTapped: (() -> Void)? = nil,
        addTapped: (() -> Void)? = nil,
        shouldShowAdd: Bool = false,
        height: CGFloat = 44
    ) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height))
        setupView()
        self.shouldShowAdd = shouldShowAdd
        self.doneTapped = doneTapped
        self.addTapped = addTapped
        self.title = title
        self.height = height
    }

    private func setupView() {
        addSubview(toolBar)

        toolBar.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func doneButtonTapped() {
        doneTapped?()
    }

    @objc func addButtonTapped() {
        addTapped?()
    }
}
