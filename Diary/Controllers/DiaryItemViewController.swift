//
//  DiaryItemViewController.swift
//  Diary
//
//  Created by jin on 12/22/27.
//

import UIKit

class DiaryItemViewController: UIViewController {
    
    var diary: Diary?
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNotificationCenter()
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            manageCoreData()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configureUI() {
        self.view.backgroundColor = .white
    
        self.view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -10),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateContentText(content: String?) {
        self.textView.text = content
    }
}

// MARK: - Keyboard adjusting
extension DiaryItemViewController {
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.manageCoreData), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func adjustForKeyboard(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = .zero
            manageCoreData()
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textView.verticalScrollIndicatorInsets = textView.contentInset

        let selectedRange = textView.selectedRange
        textView.scrollRangeToVisible(selectedRange)
    }
}

// MARK: - CoreData
extension DiaryItemViewController {
    
    @objc func manageCoreData() {
        guard textView.text != "" else { return }

        if self.diary != nil {
            updateCoreData()
            return
        }

        createCoreData()
    }
    
    func createCoreData() {
        do {
            let (title, content) = sliceText()
            
            self.diary = try CoreDataManager.shared.createDiary(title: title, content: content, createdAt: Date().timeIntervalSince1970)
        } catch {
            print(error)
        }
    }
    
    func updateCoreData() {
        guard let diary else { return }
        
        let (title, content) = sliceText()
        
        diary.title = title
        diary.content = content
        
        do {
            try CoreDataManager.shared.updateDiary(updatedDiary: diary)
        } catch {
            print(error)
        }
    }
    
    func sliceText() -> (String?, String) {
        var text = textView.text.components(separatedBy: "\n")
        let title = text.first
        text.removeFirst()
        let content = text.joined(separator: "\n")
        
        return (title, content)
    }
}

