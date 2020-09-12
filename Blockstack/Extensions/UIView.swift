import UIKit

extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        layer.cornerRadius = radius ?? self.frame.width / 2
        layer.masksToBounds = true
    }
}
