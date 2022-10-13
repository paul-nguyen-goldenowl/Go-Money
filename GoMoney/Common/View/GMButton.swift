//
//  GMButton.swift
//  GoMoney
//
//  Created by Golden Owl on 13/10/2022.
//

import UIKit

class GMButton: UIButton {
    convenience init(
        text: String = "",
        size: CGFloat = 16,
        color: UIColor = .black,
        font: String = K.Font.nova ,
        builder: ((GMButton) -> Void)? = nil
    ) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(text, for: .normal)
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont(name: font, size: size)
        builder?(self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}