//
//  BaseViewController.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 16/07/2022.
//

import UIKit
import TTGSnackbar

class BaseViewController: UIViewController {
  var spinner:UIView?
  
  func labelBold(text: String, textSize : CGFloat = 12,textColor:UIColor = .black) -> UILabel{
      let label = UILabel()
      label.text = text
      label.textColor = textColor
      label.textAlignment = .center
      label.numberOfLines = 0
      label.font = UIFont.init(name:"Poppins-Bold",size: textSize)
      return label
  }
  
  func noDataLabel(_ content: String)->UILabel{
    var label = labelBold(text: content)
    label.textAlignment = .center
    return label
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()

      initView()
   }
  
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  func showSnackBar(_ msg:String,_ duration:TTGSnackbarDuration = .middle){
      let snackbar = TTGSnackbar(message: msg, duration: duration)
      snackbar.show()
  }
  func showError(_ title: String,_ msg: String){
    let refreshAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)

    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action: UIAlertAction!) in
    }))

    present(refreshAlert, animated: true, completion: nil)
  }
  
  func showLoading() {
      if(spinner != nil){
          hideLoading();
      }
      spinner = displaySpinner(onView: self.view)
  }
 
  func hideLoading() {
      removeSpinner(spinner: spinner ?? UIView())
  }

  func removeSpinner(spinner: UIView) {
      DispatchQueue.main.async {
          
          spinner.removeFromSuperview()
      }
  }
  
  func displaySpinner(onView: UIView) -> UIView {
      let spinnerView = UIView.init(frame: onView.bounds)
      
      spinnerView.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5)
      
      let ai = UIActivityIndicatorView.init(style: .gray)
      ai.style = .large
      ai.startAnimating()
      ai.center = spinnerView.center
      
      DispatchQueue.main.async {
          spinnerView.addSubview(ai)
          ai.startAnimating()
          onView.addSubview(spinnerView)
      }
      
      return spinnerView
  }
  
  
  func initView(){
       
   }
    
}
