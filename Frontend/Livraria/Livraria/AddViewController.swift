//
//  ViewController.swift
//  Livraria
//
//  Created by Jairo Pereira Junior on 17/06/20.
//  Copyright © 2020 Jairo Pereira Junior. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var tf_titulo: UITextField!
    @IBOutlet weak var tf_autor: UITextField!
    @IBOutlet weak var tf_editora: UITextField!
    @IBOutlet weak var tf_ano: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Novo Livro"
        let add = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItems = [add]
    }
    
    @objc func save() {
        let book2 = Utils.BookEncoder(id: "", titulo: tf_titulo.text!, ano: tf_ano.text!, autor: tf_autor.text!, editora: tf_editora.text!)
        
        let jsonUrlString = NSLocalizedString("url_servidor", comment: "")
        guard let url = URL(string: jsonUrlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var body = Data()
        do {
            body = try JSONEncoder().encode(book2)
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
        }
        request.httpBody = body
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            guard let data = data else { return }
            do {
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }.resume()
        
        navigationController?.popViewController(animated: true)
    }

}

