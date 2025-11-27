import UIKit


class LessonViewController: UIViewController {
    let lessonScreen = LessonView()
    
    override func loadView() {
        self.view = lessonScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        navigationItem.largeTitleDisplayMode = .never
        
        lessonScreen.setAccountTarget(self, action: #selector(openProfile))
        lessonScreen.backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
        lessonScreen.startBtn.addTarget(self, action: #selector(startBtnPressed), for: .touchUpInside)
    }
    
    @objc func openProfile() {
        let profileScreen = ProfileViewController()
        navigationController?.pushViewController(profileScreen, animated: true)
    }
    
    @objc func backBtnPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func startBtnPressed(){
        let practiceScreen = PracticeViewController()
        navigationController?.pushViewController(practiceScreen, animated: true)
    }
}

