//
//  EditViewController.swift
//  Livraria
//
//  Created by Jairo Pereira Junior on 17/06/20.
//  Copyright © 2020 Jairo Pereira Junior. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    var book: Utils.Book?
    
    @IBOutlet weak var lb_id: UILabel!
    @IBOutlet weak var tf_titulo: UITextField!
    @IBOutlet weak var tf_autor: UITextField!
    @IBOutlet weak var tf_editora: UITextField!
    @IBOutlet weak var tf_ano: UITextField!

    var btn_edit: UIBarButtonItem?
    var btn_save: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = book?.titulo
        
        lb_id.text = book?.id
        tf_titulo.text = book?.titulo
        tf_autor.text = book?.autor
        tf_editora.text = book?.editora
        tf_ano.text = book?.ano
        
        tf_titulo.isEnabled = false
        tf_autor.isEnabled = false
        tf_editora.isEnabled = false
        tf_ano.isEnabled = false
        
        btn_edit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(edit))
        btn_save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = btn_edit
    }
    
    @objc func edit() {
        self.navigationItem.rightBarButtonItem = btn_save
        tf_titulo.isEnabled = true
        tf_autor.isEnabled = true
        tf_editora.isEnabled = true
        tf_ano.isEnabled = true
    }
    
    @objc func save() {
        self.navigationItem.rightBarButtonItem = btn_edit
        tf_titulo.isEnabled = false
        tf_autor.isEnabled = false
        tf_editora.isEnabled = false
        tf_ano.isEnabled = false
        
        let book2 = Utils.BookEncoder(id: lb_id.text!, titulo: tf_titulo.text!, ano: tf_ano.text!, autor: tf_autor.text!, editora: tf_editora.text!)
        
        let jsonUrlString = NSLocalizedString("url_servidor", comment: "")
        guard let url = URL(string: jsonUrlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
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
    }
}
