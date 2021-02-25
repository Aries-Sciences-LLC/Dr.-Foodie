//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    private var index: Int = 0
    private var mockUp: UIImageView! {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 190, height: 275))
        image.image = UIImage(named: "\(index)")
        image.contentMode = .scaleAspectFit
        image.layer.shadowRadius = 20
        image.layer.shadowColor = UIColor.gray.cgColor
        image.layer.shadowOffset = CGSize(width: 3, height: 3)
        image.layer.shadowOpacity = 1
        return image
    }
    override func loadView() {
        let view = UIView()
        view.frame.size = CGSize(width: 600, height: 776)
        view.backgroundColor = UIColor(red: 245, green: 245, blue: 245, alpha: 1)
        
        let icon = UIImageView(image: UIImage(named: "RoundedIcon"))
        icon.frame = CGRect(x: 70, y: 650, width: 100, height: 100)
        icon.layer.shadowRadius = 20
        icon.layer.shadowColor = UIColor.lightGray.cgColor
        icon.layer.shadowOffset = CGSize(width: 3, height: 3)
        icon.layer.shadowOpacity = 1
        view.addSubview(icon)
        
        let title = UILabel(frame: CGRect(x: 185, y: 690, width: 400, height: 50))
        title.textColor = UIColor(red: 180, green: 180, blue: 180, alpha: 1)
        title.font = UIFont(name: "Avenir-Heavy", size: 40)
        title.text = "Dr. Foodie"
        title.layer.shadowRadius = 20
        title.layer.shadowColor = UIColor.black.cgColor
        title.layer.shadowOffset = CGSize(width: 3, height: 3)
        title.layer.shadowOpacity = 1
        view.addSubview(title)
        
        let locations = [
            CGPoint(x: 300 - 75, y: 200),
            CGPoint(x: 300 + 75, y: 200),
            CGPoint(x: 300 - 75, y: 460),
            CGPoint(x: 300 + 75, y: 460),
        ]
        
        for i in 1...4 {
            index = i
            let iPhone = mockUp!
            iPhone.center = locations[i - 1]
            view.addSubview(iPhone)
        }
        
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
