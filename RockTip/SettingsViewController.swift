//
//  SettingsViewController.swift
//  RockTip
//
//  Created by Zhongjie Wu on 4/29/16.
//  Copyright © 2016 Zhongjie Wu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  @IBOutlet weak var defaultPercentageControl: UISegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ViewController.configSegmentedControl(defaultPercentageControl)
    let defaults = NSUserDefaults.standardUserDefaults()
    let idx = defaults.integerForKey("default_percentage_idx")
    
    defaultPercentageControl.selectedSegmentIndex = idx
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(animated: Bool) {
    if (animated) {
      self.view.alpha = 0
      UIView.animateWithDuration(0.4, animations: {
        self.view.alpha = 1
      })
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    if (animated) {
      self.view.alpha = 1
      UIView.animateWithDuration(0.4, animations: {
        self.view.alpha = 0
      })
    }
  }
  
  @IBAction func onChangeDefaultPercentage(sender: AnyObject) {
    let idx = defaultPercentageControl.selectedSegmentIndex
    
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setInteger(idx, forKey: "default_percentage_idx")
    defaults.synchronize()
  }

}
