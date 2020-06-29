//
//  BooksTableViewController.swift
//  Livraria
//
//  Created by Jairo Pereira Junior on 17/06/20.
//  Copyright © 2020 Jairo Pereira Junior. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    var books: [Utils.Book] = []
    
    let refreshController = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newBook))
        navigationItem.rightBarButtonItems = [add]
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshController
        } else {
            tableView.addSubview(refreshController)
        }
        refreshController.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        refreshController.addTarget(self, action: #selector(refresh_screen(sender:)), for: .valueChanged)
        
        screen()
    }
    
    func screen() {
        let jsonUrlString = NSLocalizedString("url_servidor", comment: "")
        guard let url = URL(string: jsonUrlString) else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let body = ""
        request.httpBody = body.data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            guard let data = data else { return }
            do {
                self.books = try JSONDecoder().decode([Utils.Book].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refreshController.endRefreshing()
                    self.refreshController.attributedTitle = NSAttributedString(string:"Puxe para atualizar")
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
                DispatchQueue.main.async {
                    self.refreshController.endRefreshing()
                    self.refreshController.attributedTitle = NSAttributedString(string:"Puxe para atualizar")
                }
            }
            }.resume()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_book", for: indexPath)
        cell.textLabel?.text = self.books[indexPath.row].titulo
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let edit = storyboard?.instantiateViewController(withIdentifier: "segue_edit") as! EditViewController
        edit.book = books[indexPath.row]
        navigationController?.pushViewController(edit, animated: true)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book2 = Utils.BookEncoder(id: books[indexPath.row].id, titulo: books[indexPath.row].titulo, ano: books[indexPath.row].ano, autor: books[indexPath.row].autor, editora: books[indexPath.row].editora)
            
            let jsonUrlString = NSLocalizedString("url_servidor", comment: "")
            guard let url = URL(string: jsonUrlString) else { return }
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "DELETE"
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
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc func newBook() {
        let new = storyboard?.instantiateViewController(withIdentifier: "segue_add") as! AddViewController
        navigationController?.pushViewController(new, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        screen()
    }
    
    @objc func refresh_screen(sender: UIRefreshControl){
        refreshControl?.attributedTitle = NSAttributedString(string: "Aguarde...")
        screen()
    }

}
