//
//  RecipeModel.swift
//  MVVM Demo
//
//  Created by User on 6/3/23.
//

//First we got a string to the json file in our app(bundle) - line 33
//Then we checked that it was a nil - line 44
//Next we create a url object using that path - line 50
//That's because we need to pass that url object into a data object, this will go and collect that data at that url- line 62
//That can throw an error and we wrap it in a do, try, and catch block - line 59, 69, 96
//If it fails to grab that data at that url, its going to go down here - line 96
//Otherwise we are going to proceed with parsing it with a JSON decoder, so here we create a new instance of this class - line 69 and then again we need to use the do, try, and catch block because the decode method might throw an error - line 75, 78, 91
//So here with the decode method we are passing in the data from our JSON file and we are telling it that it should converted to an array of recipe instances - line 79
//Here we had to make sure it could conform to the decodable protocall
//And that these properties map to the key value pairs in the JSON data as well.
//Then we are going to get that array of recipe instances into that recipeData- line 81
//We needed to set a unique id for each recipe instance with a loop - line 85
//And the last piece of the puzzle is to assign it to this recipes property of our ViewModel - line 94 which has the @Published property wrapper so whoever is observing this RecipeModel will get that data change and then update it's UI
//So the contentview is sending the model as a ObservedObject and when that published property(recipes) gets changed, the contentview will get notified and the viewcode is going to update it's UI.


//Managing the Data in any business logic
//The source of truth for our data
import Foundation

//Declaring that this object can be listened too
//We do have our Spaghetti, Sushi, and Burger inside of our recipe array however because the id is not set for the instances the swift ui list can't tell them apart.
class RecipeModel: ObservableObject {
    
    //We have to specify which properties we want to broadcast it's changes whenever there is a change
    //When this recipe property changes this Published state property is going to cause our list to react and update the UI, however we never have actually set up this property. We have only assigned our decoded data into recipeData
    @Published var recipes = [Recipe]()
    
    //Set-up code for the instance
    init() {
        //Step 1 -
        //Find the path inside that bundle to our data.json file
        //We need to know where it is to tell our code to access that file to read that data from it.
        //Get the path to the json file within the app bundle
        
        //The Bundle.math.path returns the full path name for the resource identified by the specified name and file extension.
        //The forResource is just the file name that you put
        //The ofType is the type of extention that it is and it will prob be json alot.
        let pathString = Bundle.main.path(forResource: "data", ofType: "json")
        
        //Step 2 - Now this path statement could potentially be nil so we have two options.
        //We could use an if statement
        // 1.if pathString != nil {}
        
        //Or we could use Optional Binding
        //2.Optional Biding - We are checking to see if there's a toy(or a value) in the box(variable)
        //If pathString is nil then it's going to skip everything but if it's an actually string it will assign it to path constant
        if let path = pathString {
            //Inside here I can use the path constant that contains the string path
            //Assuming we get the string path the next thing to do is Create the URL Object
            
            //This is a special class use for networking, which also includes pointing to local resources
            //This creates a file URL that refrences the local file or directory at the path
            let url = URL(fileURLWithPath: path)
            
            //Step 4 - Handle the Error by using the keyword do and catch
            //Error handling
            
            do{
                //Put the code that potentially throwns an error
                //Step 3 - Create a data object with the data at the url
                //The data object is a swift class that lets us work with data
                //Anytime you call a method or do an action that may potentially throw you have to put the try keyword in front of it as well
                let data = try Data(contentsOf: url)
                
              //Step 5 - Parse the data
              //We do this with a special class called JSON decoder.
              //We are going to create an instance(copy) of it and we have to assign it to something(let decoder) so we refrence it.
               let decoder = JSONDecoder()
                //If it cannot decode the json then it will throw an error
                //How you prepare to decode that JSON? You need to have a set of structures or classes that map directly to the JSON objects.
                //To pass in a data type as a parameter to a method you have to write .self and this will indicate that your trying to pass in the type
            
                //I didn't have to do another do and catch, I could of just put try in front of decoder and it would of been fine. The reason I did is because if there is an error I wouldn't know if it's from fetching the data from the file or decoding the JSON.
                do{
                    
                   //This is going to turn this data into an Array of Recipe instances and it's going to return that. I need to keep a reference to that.(let recipeData)
                   let recipeData = try decoder.decode([Recipe].self, from: data)
                    
                    //Set unique id for each instance
                    for r in recipeData {
                        
                        //Set a unique ID for each recipe in the recipe data array
                        r.id = UUID()
                    }
                    
                    //Assign the data to the published property
                    //This makes it clear that we are referencing the recipe's properties of the recipe model class. line 17 and 13 of this code.
                    self.recipes = recipeData
                }
                catch{
                    //Couldn't decode JSON
                    print(error)
                }
            }
            catch{
                //Execution will come here if an error is thrown
                print(error)
            }
        }
    }
        func addRecipe() {
            
        }
    }

