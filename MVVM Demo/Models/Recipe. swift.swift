//
//  Recipe. swift.swift
//  MVVM Demo
//
//  Created by User on 6/3/23.
//

//Representing our Recipe Data
import Foundation

//Here we had to make sure it could conform to the decodable protocall
 class Recipe:Identifiable, Decodable {
    
    //Unique Identifier
    //We make this an optional property, this means it going to be nil by default.
     //The id property is not set in our recipe instances
    var id:UUID?
    var name = ""
    var cuisine = ""
}
