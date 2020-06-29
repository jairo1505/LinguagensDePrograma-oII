//
//  Utils.swift
//  Livraria
//
//  Created by Jairo Pereira Junior on 17/06/20.
//  Copyright © 2020 Jairo Pereira Junior. All rights reserved.
//

import UIKit

class Utils: NSObject {
    struct Book: Decodable {
        let id: String
        let titulo: String
        let ano: String
        let autor: String
        let editora: String
    }
    
    struct BookEncoder: Codable {
        let id: String
        let titulo: String
        let ano: String
        let autor: String
        let editora: String
        
        init(id: String, titulo: String, ano: String, autor: String, editora: String) {
            self.id = id
            self.titulo = titulo
            self.ano = ano
            self.autor = autor
            self.editora = editora
        }
    }
}
