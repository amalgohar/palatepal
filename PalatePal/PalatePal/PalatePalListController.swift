//
//  PalatePalListController.swift
//  PalatePal
//
//  Created by Amal Gohar on 11/29/23.
//

import Foundation
import UIKit

class PalatePalListController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetJSONData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segue knows the controller
        var destController = segue.destination as! ViewController
        // find selected row index from tableView
        let index = tableView.indexPathForSelectedRow
        // find the matching row in object array
        let selectedRowPP = PalatePalArray[index!.row]
        // set the desination controller Hiking Trail object with object from selected tableView row
        destController.SplitViewPP = selectedRowPP
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PalatePalArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // add identifier on cell on storyboard
        var myCell = tableView.dequeueReusableCell(withIdentifier: "myCellID")
        
        var cellIndex = indexPath.row
        
        var PP = PalatePalArray[cellIndex]
        
        myCell!.textLabel!.text = PP.DishName
        myCell!.detailTextLabel!.text = PP.DishType
        
        myCell!.textLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        return myCell!
    }
    
    func convertToImage(urlString: String) -> UIImage {
        // Reach out to the URL and download bytes of data.
        //convert string to a URL type
        let imgURL = URL(string:urlString)!
        //call the end point and receive the Bytes
        let imgData  = try? Data(contentsOf: imgURL)
        print(imgData ?? "Error. Image does not exist at URL \(imgURL)")
        //convert bytes of data to image type
        let img = UIImage(data: imgData!)
        //return the UIImage
        return img!
    }
    
    var PalatePalArray = [PalatePal]()
    
    //Getting API Data
    func GetJSONData() {
        
        // Use the String address and convert it to a URL type
        let endPointString  = "https://raw.githubusercontent.com/amalgohar/palatepal/master/PalatePal.json"
        let endPointURL = URL(string: endPointString)
        
        // Pass it to the Data function
        let dataBytes = try? Data(contentsOf:endPointURL!)
        // Receive the bytes
        print(dataBytes) // just for developers to see what is received. this will help in debugging
        
        
        if (dataBytes != nil) {
            // get the JSON Objects and convert it to a Dictionary
            let dictionary:NSDictionary = (try! JSONSerialization.jsonObject(with: dataBytes!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
            
            print("Dictionary --:  \(dictionary) ---- \n") // for debugging purposes
            
            // Split the Dictionary into two parts. Keep the HikingTrails Part and discard the other
            let htDictionary = dictionary["PalatePal"]! as! [[String:AnyObject]]
            
            
            for index in 0...htDictionary.count - 1  {
                // Dictionary to Single Object (Palate Pal)
                let singlePP = htDictionary[index]
                // create the Hiking Trail Object
                let pp = PalatePal()
                //reterive each object from the dictionary
                pp.DishName = singlePP["DishName"] as! String
                print("DishName: - \(pp.DishName)")
                //ht. = singleHT["TrailAddress"] as! String
                pp.DishType = singlePP["DishType"] as! String
                pp.RecipeImage = singlePP["RecipeImage"] as! String
                pp.Ingredients = singlePP["Ingredients"] as! String
                pp.RecipeDescription = singlePP["RecipeDescription"] as! String
                pp.RecipeVideo = singlePP["RecipeVideo"] as! String
                PalatePalArray.append(pp)
            }
            
        }
    }

}
