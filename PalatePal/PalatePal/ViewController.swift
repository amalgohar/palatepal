//
//  ViewController.swift
//  PalatePal
//
//  Created by Amal Gohar on 10/08/23.
//
// This App is developed as an educational project. 

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var SplitViewPP:PalatePal = PalatePal()
    
    var globalPP = PalatePal()
    
    @IBOutlet weak var lblDishName: UILabel!
    
    @IBOutlet weak var txtIngredients: UITextView!
    
    @IBOutlet weak var txtRecipeDescription: UITextView!
    
    @IBOutlet weak var imgRecipeImage: UIImageView!
    
    // Variables
    var PalatePalArray = [PalatePal]()
    var randomRecipe = PalatePal()
    var mySoundFile: AVAudioPlayer!
     
    // Functions
    func setLabels() {
        var randomRecipe = SplitViewPP
        globalPP = randomRecipe
        
        lblDishName.text = randomRecipe.DishName
        txtIngredients.text = randomRecipe.Ingredients
        txtRecipeDescription.text = randomRecipe.RecipeDescription
        
        //imgRecipeImage.image = UIImage(named: randomRecipe.RecipeImage)
        // Looks for image in JSON data and coverts it
        imgRecipeImage.image = convertToImage(urlString: randomRecipe.RecipeImage)
        
        // Sound effect after click
        mySoundFile.play()
    }
    
    // Animations
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        imgRecipeImage.alpha = 0
        txtIngredients.alpha = 0
        txtRecipeDescription.alpha = 0
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        UIView.animate(withDuration: 3, animations: {
            self.imgRecipeImage.alpha = 1
            self.txtIngredients.alpha = 1
            self.txtRecipeDescription.alpha = 1
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let soundUrl = URL(fileURLWithPath: Bundle.main.path(forResource:"munching", ofType:"mp3")!)
        mySoundFile = try?AVAudioPlayer(contentsOf: soundUrl)
        
        setLabels()
        // Do any additional setup after loading the view.
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
}
