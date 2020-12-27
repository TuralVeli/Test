//
//  ViewController.swift
//  test
//
//  Created by Tural Veliyev on 12/23/20.
//

import UIKit
import ObjectMapper
import SocketIO
import Starscream

class ViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
  
    

    
 

    @IBOutlet weak var convertLabel: UILabel!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var fisrtTextField: UITextField!

    var toConvert = ""
    var fromConvert = ""
    var picker = UIPickerView()
    var data = [CurrencyList]()
    var dataRate = [CurrencyListRate]()
    var manager:SocketManager?
    var socketIOClient:SocketIOClient!
    let todaysDate:NSDate = NSDate()
    let dateFormatter:DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingData()
        hideKeyboardWhenTappedAround()
        self.ConnectToSocket()

    }
    
 
    func ConnectToSocket() {

        manager = SocketManager(socketURL: URL(string: "https://q.investaz.az/live")!, config: [.log(true), .compress])
        socketIOClient = manager?.defaultSocket

        socketIOClient.on(clientEvent: .connect) {data, ack in
            print(data)
            print("socket connected")
        }

        socketIOClient.on(clientEvent: .error) { (data, eck) in
            print(data)
            print("socket error")
        }

        socketIOClient.on(clientEvent: .disconnect) { (data, eck) in
            print(data)
            print("socket disconnect")
        }

        socketIOClient.on(clientEvent: SocketClientEvent.reconnect) { (data, eck) in
            print(data)
            print("socket reconnect")
        }

        socketIOClient.connect()
    }

    

    
    
    func loadingData() {
        let url = "get_currency_list_for_app"
        
    GlobalMethod.objGlobalMethod.ServiceMethodGet(url:url, controller: self)
        {
            response in

            if  response.response?.statusCode == 200 && response.result.value != nil {
                let servicePackages = Mapper<CurrencyList>().mapArray(JSONArray: response.result.value as! [[String : Any]] )

                self.data += servicePackages
                self.pickerdDesigner()
               
            } else{
                print("erorr ")
            }
        }
        
    }
    
    
    func pickerdDesigner() {
        fisrtTextField.text = "\(data[0].code ?? "") - \(data[0].en ?? "")"
        self.fromConvert = "\(data[0].code ?? "")"
        self.toConvert = "\(data[0].code ?? "")"
        fisrtTextField.inputView = picker
        secondTextField.text = "\(data[0].code ?? "") - \(data[0].en ?? "")"
        secondTextField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = .white
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.gray
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancle))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ flexibleSpace,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        fisrtTextField.inputAccessoryView = toolBar
        secondTextField.inputAccessoryView = toolBar
    }
    
    
    @objc  func cancle() {
        
        self.view.endEditing(false)
        
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
       textField.inputView = picker
        picker.tag =  textField.tag
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(data[row].code ?? "") - \(data[row].en ?? "")"
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if  fisrtTextField.isFirstResponder {
        fisrtTextField.text = "\(data[row].code ?? "") - \(data[row].en ?? "")"
            self.toConvert = "\(data[row].code ?? "")"
            
        } else if secondTextField.isFirstResponder {
        secondTextField.text = "\(data[row].code ?? "") - \(data[row].en ?? "")"
            self.fromConvert = "\(data[row].code ?? "")"
        }
        
        
    }
    
    

    @IBAction func convertButton(_ sender: Any) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayString:String = dateFormatter.string(from: todaysDate as Date)

        self.dataRate.removeAll()
        self.convertData(from:fromConvert, to:toConvert, date: todayString)
        
        
    }
    
    
    var m:Double = 0.0
    
    func convertData(from:String,to:String,date:String) {
        let url = "get_currency_rate_for_app/\(to)/\(date)"
        
    GlobalMethod.objGlobalMethod.ServiceMethodGet(url:url, controller: self)
        {
       
            response in
           
            if  response.response?.statusCode == 200 && response.result.value != nil {
                let service = Mapper<CurrencyListRate>().mapArray(JSONArray: response.result.value as! [[String : Any]] )

                self.dataRate += service
                for s in  self.dataRate {
                   
                if   s.from == from  &&  s.to == to {
                     
                    self.m =  Double(self.priceTextField.text!) ?? 0.0
                    self.convertLabel.text = "\(self.m * s.result!) - \(s.from!) "
                    
                }
                    
                }
                
            } else {
                print("erorr ")
            }
        }
        
    }
    
    
    

}



extension String {
func toDouble() -> Double? {
    return NumberFormatter().number(from: self)?.doubleValue
 }
}



extension UIViewController {
    
func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
}
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        
}




