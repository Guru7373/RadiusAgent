//
//  ToastMessageHelper.swift
//  Radius Agent
//
//  Created by Karthi CK on 20/01/22.
//

import UIKit

func showToast(_ message: String,
               bgColor: UIColor = UIColor.black.withAlphaComponent(0.8),
               textColor: UIColor = UIColor.white)
{
    DispatchQueue.main.async {
        if message.count > 0 {
            guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {return}
            let messageLbl = UILabel()
            messageLbl.textAlignment = .center
            messageLbl.backgroundColor = bgColor
            messageLbl.textAlignment = .center
            messageLbl.textColor = textColor
            messageLbl.font = .preferredFont(forTextStyle: .callout)
            messageLbl.text = message
            messageLbl.numberOfLines = 0
            messageLbl.alpha = 1
            messageLbl.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: CGFloat.greatestFiniteMagnitude)
            messageLbl.sizeToFit()
            let textSize:CGSize = messageLbl.intrinsicContentSize
            let labelWidth = min(textSize.width, window.frame.width - 60)
            messageLbl.frame = CGRect(x: 20, y: window.frame.height - 90, width: labelWidth + 30, height: messageLbl.frame.height + 20)
            messageLbl.center.x = window.center.x
            messageLbl.layer.cornerRadius = 5
            messageLbl.layer.masksToBounds = true
            window.addSubview(messageLbl)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                UIView.animate(withDuration: 2.0, animations: {
                    messageLbl.alpha = 0
                }) { (_) in
                    messageLbl.removeFromSuperview()
                }
            }
        }
    }
}
