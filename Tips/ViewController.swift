//
//  ViewController.swift
//  Tips
//
//  Created by new on 7/4/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    private let BillField: UITextField = {
        let billField = UITextField()
        billField.placeholder = "Bill total:"
        billField.layer.borderWidth = 1
        billField.autocapitalizationType = .none
        billField.layer.borderColor = UIColor.blue.cgColor
        billField.backgroundColor = .white
        billField.leftViewMode = .always
        billField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return billField
    }()
    
    private let TisPercentField: UITextField = {
        let tipsField = UITextField()
        tipsField.placeholder = "Percentage of tips"
        tipsField.layer.borderWidth = 1
        tipsField.layer.borderColor = UIColor.blue.cgColor
        tipsField.backgroundColor = .white
        tipsField.leftViewMode = .always
        tipsField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return tipsField
    }()
    
    private let TipsamountField: UITextField = {
        let tipsamountField = UITextField()
        tipsamountField.placeholder = "Tips amount:"
        tipsamountField.layer.borderWidth = 1
        tipsamountField.autocapitalizationType = .none
        tipsamountField.layer.borderColor = UIColor.blue.cgColor
        tipsamountField.backgroundColor = .white
        tipsamountField.leftViewMode = .always
        tipsamountField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return tipsamountField
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Calculate", for: .normal)
        return button
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Total amount:"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.backgroundColor = .systemMint
        return label
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(BillField)
        view.addSubview(TisPercentField)
        view.addSubview(TipsamountField)
        view.addSubview(button)
        view.addSubview(label)
        TipsamountField.delegate = self
        view.backgroundColor = .systemCyan
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        BillField.frame = CGRect(x: 20,
                                  y: label.frame.origin.y+label.frame.size.height+10,
                                  width: view.frame.size.width-40,
                                  height: 50)
        TisPercentField.frame = CGRect(x: 20,
                                     y:BillField.frame.origin.y+BillField.frame.size.height+10,
                                     width: view.frame.size.width-40,
                                     height: 50)
        TipsamountField.frame = CGRect(x: 20,
                                     y:TisPercentField.frame.origin.y+TisPercentField.frame.size.height+10,
                                     width: view.frame.size.width-40,
                                     height: 50)
        button.frame = CGRect(x: 20,
                              y:TipsamountField.frame.origin.y+TipsamountField.frame.size.height+30,
                              width: view.frame.size.width-40,
                              height: 52)
        label.frame = CGRect(x: 20,
                              y:button.frame.origin.y+button.frame.size.height+30,
                              width: view.frame.size.width-40,
                              height: 52)
    }

    @objc private func didTapButton() {
        guard let billAmt = BillField.text,
                !billAmt.isEmpty else {
            print("Bill Amount error")
            return
        }
        guard let tipPercent = TisPercentField.text,
                !tipPercent.isEmpty else {
            print("Tip Percentage error")
            return
        }
        let billDecimal = Decimal(string: billAmt)!
        let percentDecimal = Decimal(string: tipPercent)!
        var tip = (percentDecimal / 100) * billDecimal
        var tipR = Decimal()
        NSDecimalRound(&tipR, &tip, 2, .up)
        TipsamountField.text = "\(tipR)"
        label.text = "Total Bill: \((billDecimal + tipR))"
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var newTotal = Decimal()
        if let t = textField.text,
        let tipAmount = Decimal(string: t) {
            if let billAmt = BillField.text,
                !billAmt.isEmpty {
                let billDecimal = Decimal(string: billAmt)!
                let newPercent = (tipAmount * 100) / billDecimal
                TisPercentField.text = "\(newPercent)"
                newTotal = billDecimal + tipAmount
            }
            label.text = "Total Amount: $\(newTotal)"
        }
    }
    }
    
    


