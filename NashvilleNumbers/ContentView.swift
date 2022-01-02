import SwiftUI

struct ContentView: View {
    
    init() {
       
    }
    
    var body: some View {
            HomeView()
    }
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
       }
    }
}

//extension UIColor {
//    convenience init(red: Int, green: Int, blue: Int) {
//        let newRed = CGFloat(red)/255
//        let newGreen = CGFloat(green)/255
//        let newBlue = CGFloat(blue)/255
//
//        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
//    }
//}
//
//
//extension UITabBarController {
//    override open func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let standardAppearance = UITabBarAppearance()
//
//        let tabColor = UIColor(red: 0, green: 70, blue: 95)
//        standardAppearance.backgroundColor = tabColor
//
//        standardAppearance.shadowColor = tabColor
//        standardAppearance.backgroundImage = UIImage(named: "texture")
//
//        tabBar.standardAppearance = standardAppearance
//    }
//}
