//
//  ContentView.swift
//  MVVM Demo
//
//  Created by User on 6/3/23.
//

//Refrencing the ViewModel in order to acesss the data and display it.
import SwiftUI

struct ContentView: View {
   
    //The view is listening too this object
   @ObservedObject var model = RecipeModel()
        
    var body: some View {
        
        VStack {
            List(model.recipes) { r in
                
                VStack(alignment: .leading) {
                    Text(r.name)
                        .font(.title)
                    Text(r.cuisine)
                }
            }
            Button("Add Recipe") {
                model.addRecipe()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
