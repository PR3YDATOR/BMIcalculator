//
//  ViewController.swift
//  BMIcalculator
//
//  Created by user238852 on 2/10/24.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!

    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!

    @IBOutlet weak var BMIvalueTextField: UITextField!
    @IBOutlet weak var BMIcategoryTextField: UITextField!

    //Flag to check the unit selected by the user
    var isMetricUnit = true // Default to true which means metric units (kg, m)
    
    override func viewDidLoad() {
        // Labels and textField placeholders to be displayed by default
        heightLabel.text = "Height (m)"
        heightTextField.placeholder = "Enter height in meters"
        weightLabel.text = "Weight (kg)"
        weightTextField.placeholder = "Enter weight in kilograms"
        
    }

    // If the user selects to change the unit
    @IBAction func changeUnitClicked(_ sender: Any) {
        isMetricUnit.toggle() // flag value is changed
        updateUnitLabels() // function to change the displayed labels and placeholder texts
    }

    // If the user clicks on calculate
    @IBAction func calculateClicked(_ sender: Any) {
        guard let heightText = heightTextField.text,
              let weightText = weightTextField.text,
              let height = Double(heightText),
              let weight = Double(weightText),
              height > 0 && height < 200 , weight > 0 && weight < 5000 else {
            updateErrorPlaceholders() // function to display errors
            return
        }

        let bmi = calculateBMI(height: height, weight: weight) // function to calculate bmi
        displayBMIResult(bmi) // function to display bmi and category
    }

    private func calculateBMI(height: Double, weight: Double) -> Double {
        //depending on the flag value the bmi value is calculated
        if isMetricUnit {
            return weight / pow(height, 2)
        } else {
            return (weight / pow(height, 2)) * 703.0
        }
    }

    private func displayBMIResult(_ bmi: Double) {
        // displaying the bmi value
        BMIvalueTextField.text = String(format: "%.2f", bmi)
        
        //based on bmi value we select the actegory and display it
        var category: String
        if bmi < 18.5 {
            category = "Underweight"
        } else if bmi < 24.9 {
            category = "Normal Weight"
        } else if bmi < 29.9 {
            category = "Overweight"
        } else {
            category = "Obesity"
        }
        BMIcategoryTextField.text = category
    }

    // function that changes the labels text based on the flag value for metric units
    private func updateUnitLabels() {
        heightLabel.text = isMetricUnit ? "Height (m)" : "Height (in)"
        weightLabel.text = isMetricUnit ? "Weight (kg)" : "Weight (lb)"
        updatePlaceholders()
    }
    // function that changes the placeholders text based on the flag value for metric units
    private func updatePlaceholders() {
        heightTextField.placeholder = isMetricUnit ? "Enter height in meters" : "Enter height in inches"
        weightTextField.placeholder = isMetricUnit ? "Enter weight in kilograms" : "Enter weight in pounds"
    }

    //function to display error text in the placeholders (first clear the text and then display the placeholder)
    
    private func updateErrorPlaceholders() {
        heightTextField.text=""
        heightTextField.placeholder = "Invalid input"
        
        weightTextField.text=""
        weightTextField.placeholder = "Invalid input"
    }
}
