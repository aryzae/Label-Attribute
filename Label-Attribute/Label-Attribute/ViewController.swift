//
//  ViewController.swift
//  Label-Attribute
//
//  Created by Aryzae on 2018/09/07.
//  Copyright © 2018 aryzae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let rubyView = RubyView(frame: CGRect.init(origin: .zero, size: CGSize.init(width: view.frame.width, height: 100)).insetBy(dx: 20, dy: 0))
        view.addSubview(rubyView)
    }


}
// 参考　https://qiita.com/woxtu/items/284369fd2654edac2248
private final class RubyView: UIView {

    override func draw(_ rect: CGRect) {
        // ???
        let each = "各種"
        let ruby = "(税込)" as CFString
        let yen = "¥"
        let num = "280"

        var text = [.passRetained(ruby) as Unmanaged<CFString>?, .none, .none, .none]
        let annotation = CTRubyAnnotationCreate(.auto, .auto, 0.5, &text)

        //        NSAttributedString.Key
        let attribute = NSAttributedString(string: yen, attributes: [.font : UIFont.systemFont(ofSize: 30),
                                                                    .foregroundColor : UIColor.black,
                                                                    kCTRubyAnnotationAttributeName as NSAttributedString.Key: annotation])

        let size = attribute.boundingRect(with: rect.size, options: .usesLineFragmentOrigin, context: nil)

        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        context.addRect(rect)
        context.fillPath()

        context.translateBy(x: (rect.width - size.width) / 2, y: 200)
        context.scaleBy(x: 1, y: -1)

        let line = CTLineCreateWithAttributedString(attribute)
        CTLineDraw(line, context)
    }
}

