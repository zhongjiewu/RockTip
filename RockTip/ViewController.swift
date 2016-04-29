//
//  ViewController.swift
//  RockTip
//
//  Created by Zhongjie Wu on 4/28/16.
//  Copyright © 2016 Zhongjie Wu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var billField: UITextField!
  @IBOutlet weak var totalField: UILabel!
  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var percentageSelector: UISegmentedControl!
  weak var defaults: NSUserDefaults?

  static let TIP_PERCENTAGES = [0.18, 0.2, 0.22]

  static func configSegmentedControl(control: UISegmentedControl!) {
    for (i, pct) in ViewController.TIP_PERCENTAGES.enumerate() {
      control.setTitle(String(format: "%.0f%%", pct * 100), forSegmentAtIndex: i)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    defaults = NSUserDefaults.standardUserDefaults()

    billField.text = loadInput()
    onEditingChanged(0)
  }

  override func viewWillAppear(animated: Bool) {

    let defaults = NSUserDefaults.standardUserDefaults()
    let idx = defaults.integerForKey("default_percentage_idx")

    percentageSelector.selectedSegmentIndex = idx

    billField.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func saveInput(input: String!) {
    defaults!.setObject(input, forKey: "user_input")
    defaults!.setDouble(NSDate().timeIntervalSince1970, forKey: "user_input_ts")
  }

  func loadInput() -> String? {
    let ts = defaults!.doubleForKey("user_input_ts")
    let now = NSDate().timeIntervalSince1970
    if (now - ts < 600.0) {
      return defaults!.objectForKey("user_input") as? String
    }
    return nil
  }

  @IBAction func onEditingChanged(sender: AnyObject) {
    let tipPercentage = ViewController.TIP_PERCENTAGES[percentageSelector.selectedSegmentIndex]
    let billAmount = NSString(string: billField.text!).doubleValue;
    let tip = billAmount * tipPercentage
    let total = billAmount + tip;
    tipLabel.text = String(format: "$%.2f", tip)
    totalField.text = String(format: "$%.2f", total)

    saveInput(billField.text!)
  }

  @IBAction func onTap(sender: AnyObject) {
    billField.endEditing(true)
  }
}

