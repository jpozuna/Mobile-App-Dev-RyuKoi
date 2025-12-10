import UIKit
import AVFoundation
import FirebaseAuth
import FirebaseFirestore

class PracticeViewController: UIViewController {
    
    // MARK: - Properties
    var lesson: Lesson?
    
    private let practiceView = PracticeView()
    private let database = Firestore.firestore()
    
    // Camera properties
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    
    // MARK: - Lifecycle
    override func loadView() {
        view = practiceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = lesson?.title ?? "Practice"
        
        setupActions()
        displayTips()
        checkCameraAuthorization()
        updateLessonProgressToInProgress()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    // MARK: - Setup
    private func setupActions() {
        practiceView.backButton.addTarget(self, action: #selector(onBackButtonTapped), for: .touchUpInside)
        practiceView.tipsHeaderButton.addTarget(self, action: #selector(onTipsButtonTapped), for: .touchUpInside)
        practiceView.doneButton.addTarget(self, action: #selector(onDoneButtonTapped), for: .touchUpInside)
    }
    
    private func displayTips() {
        guard let lesson = lesson else { return }
        
        let practiceLesson = PracticeLesson(
            imageName: "",
            tips: lesson.practice.tips,
            currentStep: 1,
            totalSteps: 1
        )
        
        practiceView.configure(with: practiceLesson)
    }
    
    // MARK: - Camera Setup
    private func checkCameraAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.setupCamera()
                    }
                }
            }
        case .denied, .restricted:
            showCameraAccessAlert()
        @unknown default:
            break
        }
    }
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: camera),
              captureSession.canAddInput(input) else {
            return
        }
        
        captureSession.addInput(input)
        
        // Setup preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = practiceView.lessonImageView.bounds
        
        practiceView.lessonImageView.layer.insertSublayer(previewLayer, at: 0)
        practiceView.lessonImageView.backgroundColor = .clear
        
        // Start camera on background thread
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = practiceView.lessonImageView.bounds
    }
    
    // MARK: - Actions
    @objc func onBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onTipsButtonTapped() {
        practiceView.toggleTips()
    }
    
    @objc func onDoneButtonTapped() {
        print("🔷 Done button tapped!")
        
        guard var lesson = lesson else {
            print("❌ No lesson found!")
            return
        }
        
        print("🔷 Marking lesson complete: \(lesson.title)")
        lesson.progressState = .completed
        lesson.progressPercentage = 100
        
        saveLessonProgressToFirestore(lesson) { [weak self] success in
            print("🔷 Save result: \(success ? "SUCCESS ✅" : "FAILED ❌")")
            
            if success {
                self?.lesson = lesson
                self?.showCompletionAlert(lesson: lesson)
            } else {
                self?.showErrorAlert()
            }
        }
    }
    
    // MARK: - Firebase Operations
    private func updateLessonProgressToInProgress() {
        guard var lesson = lesson, lesson.progressState == .notStarted else { return }
        
        lesson.progressState = .inProgress
        lesson.progressPercentage = 0
        
        saveLessonProgressToFirestore(lesson) { [weak self] success in
            if success {
                self?.lesson = lesson
            }
        }
    }
    
    private func saveLessonProgressToFirestore(_ lesson: Lesson, completion: @escaping (Bool) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            completion(false)
            return
        }
        
        let progressData: [String: Any] = [
            "progressState": lesson.progressState.rawValue,
            "progressPercentage": lesson.progressPercentage,
            "lastPracticed": Timestamp(date: Date())
        ]
        
        database.collection("users")
            .document(userEmail.lowercased())
            .collection("progress")
            .document(lesson.title)
            .setData(progressData) { error in
                completion(error == nil)
            }
    }
    
    // MARK: - Alerts
    private func showCameraAccessAlert() {
        let alert = UIAlertController(
            title: "Camera Access Required",
            message: "Please enable camera access in Settings.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        
        present(alert, animated: true)
    }
    
    private func showCompletionAlert(lesson: Lesson) {
        print("🔷 Showing completion alert")
        
        let alert = UIAlertController(
            title: "Lesson Complete! 🎉",
            message: "Great job! You've completed \(lesson.title)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default) { [weak self] _ in
            print("🔷 Continue button tapped in alert")
            
            guard let navigationController = self?.navigationController else {
                print("❌ No navigation controller!")
                return
            }
            
            let viewControllers = navigationController.viewControllers
            print("🔷 Navigation stack has \(viewControllers.count) screens")
            
            if viewControllers.count >= 3 {
                // Pop to the lesson library (third from top)
                let targetVC = viewControllers[viewControllers.count - 3]
                print("✅ Popping to: \(type(of: targetVC))")
                navigationController.popToViewController(targetVC, animated: true)
            } else {
                // Fallback: just pop to previous screen if navigation stack is shallow
                print("⚠️ Stack too shallow, popping one screen back")
                navigationController.popViewController(animated: true)
            }
        })
        
        present(alert, animated: true)
        print("✅ Alert presented")
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(
            title: "Error",
            message: "Failed to save progress. Please try again.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
