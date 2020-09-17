//
//  AddDontationViewController.swift
//  VKDonations
//
//  Created by Den Matyash on 11.09.2020.
//  Copyright © 2020 Den. All rights reserved.
//

import UIKit

class AddPodcastViewController: ClosableUIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 26
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private let postCover = PostCover().apply {
        $0.isUserInteractionEnabled = true
    }
    
    private let podcastNameInput = TextInputLayout(explanation: "Название", placeholder: "Введите название подкаста")
    
    private let descriptionInput = TextInputLayout(explanation: "Описание подкаста", placeholder: "Опишите о чем ваш подкаст")
    
    private let uploadTitle = UILabel().apply {
        $0.text = "Загрузите Ваш подкаст"
        $0.font = Font.title
        $0.textAlignment = .center
    }
    
    private let uploadExplanation = BodyLabel().apply {
        $0.text = "Выберите готовый аудиофайл из вашего телефона и добавьте его"
        $0.textAlignment = .center
        $0.textColor = Palette.gray
    }
    
    private let uploadButton = CommonButton().apply {
        $0.mode = .bordered
        $0.setTitle("Загрузить файл", for: .normal)
    }
    
    private let horizontalLine = UIView().apply {
        $0.backgroundColor = UIColor(red: 0.843, green: 0.847, blue: 0.851, alpha: 1)
    }
    
    private let firstCheckBox = CheckBoxLayout().apply {
        $0.isUserInteractionEnabled = true
        $0.label.text = "Ненормативный контент"
    }
    private let secondCheckBox = CheckBoxLayout().apply {
        $0.label.text = "Исключить эпизод из экспорта"
    }
    private let thirdCheckBox = CheckBoxLayout().apply {
        $0.label.text = "Трейлер подкаста"
    }
    
    private let accessLabel = UILabel().apply {
        $0.text = "Кому доступен данный подкаст"
        $0.font = Font.smallTitle
    }
    
    private let access = UILabel().apply {
        $0.font = Font.smallHint
        $0.textColor = Palette.gray
        $0.text = "Всем пользователям"
    }
    
    private let accessHint = UILabel().apply {
        $0.font = UIFont(name: "SFProText-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13)
        $0.textColor = Palette.gray
        $0.text = "При публикации записи с эпизодом, он становится доступным для всех пользователей"
        $0.numberOfLines = 0
    }
    
    private let actionButton = BottomButton().apply {
        $0.setTitle("next".localized, for: .normal)
    }
    
    private let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Новый подкаст"
        
        buildViewTree()
        setConstraints()
        
        postCover.onClick = {
            self.pickImage()
        }
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func buildViewTree() {
        [scrollView].forEach(view.addSubview)
        
        scrollView.addSubview(contentView)
        
        [postCover, podcastNameInput, descriptionInput, uploadTitle, uploadExplanation, uploadButton, horizontalLine, firstCheckBox, secondCheckBox, thirdCheckBox, accessLabel, access, accessHint, actionButton].forEach(contentView.addSubview)
        
        //[].forEach(stackView.addArrangedSubview)
    }
    
    private func setConstraints() {
        scrollView.edgesToSuperview()
        
        contentView.run {
            $0.edgesToSuperview()
            $0.width(to: scrollView)
            $0.height(to: scrollView, priority: .defaultLow)
        }
        
        postCover.run {
            $0.topToSuperview(offset: 14.5)
            $0.leadingToSuperview(offset: 12)
            $0.width(72)
            $0.height(72)
        }
        
        podcastNameInput.run {
            $0.top(to: postCover)
            $0.leadingToTrailing(of: postCover, offset: 12)
            $0.trailingToSuperview(offset: 12)
        }
        
        descriptionInput.run {
            $0.topToBottom(of: postCover, offset: 30)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        uploadTitle.run {
            $0.topToBottom(of: descriptionInput, offset: 44)
            $0.horizontalToSuperview(insets: .horizontal(32))
        }
        
        uploadExplanation.run {
            $0.topToBottom(of: uploadTitle, offset: 8)
            $0.horizontalToSuperview(insets: .horizontal(32))
        }
        
        uploadButton.run {
            $0.centerXToSuperview()
            $0.topToBottom(of: uploadExplanation, offset: 24)
        }
        
        horizontalLine.run {
            $0.topToBottom(of: uploadButton, offset: 28)
            $0.height(0.5)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        firstCheckBox.run {
            $0.topToBottom(of: horizontalLine, offset: 12)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        secondCheckBox.run {
            $0.topToBottom(of: firstCheckBox, offset: 12)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        thirdCheckBox.run {
            $0.topToBottom(of: secondCheckBox, offset: 12)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        accessLabel.run {
            $0.topToBottom(of: thirdCheckBox, offset: 32)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        access.run {
            $0.topToBottom(of: accessLabel, offset: 4)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        accessHint.run {
            $0.topToBottom(of: access, offset: 4)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
        
        actionButton.run {
            $0.topToBottom(of: accessHint, offset: 36)
            $0.horizontalToSuperview(insets: .horizontal(12))
        }
    }
    
    private func pickImage() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.run {
                $0.delegate = self
                $0.sourceType = .photoLibrary
                $0.allowsEditing = true
            }

            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        postCover.setPhoto(image)
    }
    
    @objc func buttonTapped() {
        addDontation()
    }
    
    private func addDontation() {
        
    }
}
