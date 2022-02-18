//
//  SecondViewController.swift
//  GCD
//
//  Created by Артур Дохно on 02.11.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imegeView: UIImageView!
    @IBOutlet weak var activityIdicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get {
            return imegeView.image
        }
        set {
            activityIdicator.startAnimating()
            activityIdicator.isHidden = true
            imegeView.image = newValue
            imegeView.sizeToFit() // устанавливаем режим отображения
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.loginAlert()
        }
    }
    
    fileprivate func delay(
        _ delay: Int,
        closure: @escaping () -> ()) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
                closure()
            }
        }
    
    fileprivate func loginAlert() {
        let ac = UIAlertController(
            title: "Зарегистрированы?",
            message: "Введите ваш логин и пароль",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ок",
            style: .default,
            handler: nil)
        let cancelAction = UIAlertAction(
            title: "Отмена",
            style: .default,
            handler: nil)
        
        ac.addAction(cancelAction)
        ac.addAction(okAction)
        
        ac.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        
        ac.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://image.freepik.com/free-photo/cupcakes-dark-chocolate-sugar-butter-sour-cream-condenced-milk-side-view-jpg_141793-3537.jpg")
        activityIdicator.isHidden = false
        activityIdicator.startAnimating()
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
        }
    }
}
