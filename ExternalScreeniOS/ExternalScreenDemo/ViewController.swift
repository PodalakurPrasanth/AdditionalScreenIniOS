import UIKit

class ViewController: UIViewController {

    var secondWindow: UIWindow?
    var secondScreenView : UIView?
    var externalLabel = UILabel()
    
    @IBOutlet var externalView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupScreen()
        registerForScreenNotifications()
    }

    @objc func setupScreen(){
        if UIScreen.screens.count > 1{
            
            //find the second screen
            let secondScreen = UIScreen.screens[1]
            
            //set up a window for the screen using the screens pixel dimensions
            secondWindow = UIWindow(frame: secondScreen.bounds)
            
            //windows require a root view controller
            let viewcontroller = UIViewController()
            secondWindow?.rootViewController = viewcontroller
            
            //tell the window which screen to use
            secondWindow?.screen = secondScreen
            
            //set the dimensions for the view for the external screen so it fills the screen
            externalView.frame =  secondWindow!.frame
            
            //add the view to the second screens window
            secondWindow?.addSubview(externalView!)
            
            //unhide the window
            secondWindow?.isHidden = false
            
            //customised the view
            externalView!.backgroundColor = UIColor.white
            //configure the label
            externalLabel.textAlignment = NSTextAlignment.center
            externalLabel.font = UIFont(name: "Helvetica", size: 50.0)
            externalLabel.frame = externalView!.bounds
            externalLabel.text = "Hello"
            
            //add the label to the view
//            externalView!.addSubview(externalLabel)
        }
    }
    
    @objc func screenDisconnected(){
        secondWindow = nil
        externalView = nil
    }
    
    func registerForScreenNotifications(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.setupScreen), name: UIScreen.didConnectNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.screenDisconnected), name: UIScreen.didDisconnectNotification, object: nil)
        
    }

}

