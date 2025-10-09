//struct ParticipantModel {
//    var clientName: String?
//    var idNumber: String?
//    var contactNumber: String?
//    var signInDate: String?
//}
//
//import UIKit
////oo
//class SiginInCell: UITableViewCell {
//    var signatureView: SignatureView!
//
//    @IBOutlet weak var signatureContainerView: SignatureView!
//    
//    @IBOutlet weak var clientNameTf: FloatingTextField!
//    
//    @IBOutlet weak var IdNumber: FloatingTextField!
//    
//    @IBOutlet weak var contactNymberTf: FloatingTextField!
//    
//    @IBOutlet weak var dateSigndTf: FloatingTextField!
//    
//    @IBOutlet weak var addParticipantBtn: UIButton!
//    var participants: [ParticipantModel] = []
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//
//        signatureView = SignatureView(frame: signatureContainerView.bounds)
//        signatureView.backgroundColor = .white
//        signatureView.translatesAutoresizingMaskIntoConstraints = false
//        signatureContainerView.addSubview(signatureView)
//
//
//        NSLayoutConstraint.activate([
//            signatureView.leadingAnchor.constraint(equalTo: signatureContainerView.leadingAnchor),
//            signatureView.trailingAnchor.constraint(equalTo: signatureContainerView.trailingAnchor),
//            signatureView.topAnchor.constraint(equalTo: signatureContainerView.topAnchor),
//            signatureView.bottomAnchor.constraint(equalTo: signatureContainerView.bottomAnchor)
//        ])
//    }
//    @IBAction func addParticipantTapped(_ sender: UIButton) {
//    
//        let participant = ParticipantModel(
//                    clientName: clientNameTf.text ?? "",
//                    idNumber: IdNumber.text ?? "",
//                    contactNumber: contactNymberTf.text ?? "",
//                    signInDate: dateSigndTf.text ?? ""
//                )
//                
//                // 👉 Append new participant
//                participants.append(participant)
//                
//                // ✅ Optional: clear fields after adding
//                clientNameTf.text = ""
//                IdNumber.text = ""
//                contactNymberTf.text = ""
//                dateSigndTf.text = ""
//                
//                print("✅ Total Participants Added: \(participants.count)")
//       }
//       
//       // MARK: - Use this when calling API
//    func getParametersForAPI() -> [String: Any] {
//            let names = participants.map { $0.clientName ?? "" }.joined(separator: ",")
//            let ids = participants.map { $0.idNumber ?? "" }.joined(separator: ",")
//            let contacts = participants.map { $0.contactNumber ?? "" }.joined(separator: ",")
//            let dates = participants.map { $0.signInDate ?? "" }.joined(separator: ",")
//            
//            return [
//                "clientname[]": names,
//                "idnumber[]": ids,
//                "contactnumber[]": contacts,
//                "signindate[]": dates
//            ]
//        }
//    
//   
//
//    @objc func clearSignature() {
//        signatureView.clear()
//    }
//    @objc func saveSignature() {
//        print(" saveSignature() CALLED!")
//
//        let image = signatureView.getSignatureImage()
//        guard let imageData = image.jpegData(compressionQuality: 0.9) else {
//            print(" Signature convert nahi hua")
//            return
//        }
//
//        let fileName = "signature_\(Int(Date().timeIntervalSince1970)).jpg"
//        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            .appendingPathComponent(fileName)
//
//        do {
//            try imageData.write(to: fileURL)
//            print(" Signature saved at: \(fileURL.path)")
//
//            UserDefaults.standard.set(fileURL.path, forKey: "savedSignaturePath")
//            UserDefaults.standard.synchronize()
//        } catch {
//            print(" Error saving signature: \(error)")
//        }
//    }
//
//
//}
import UIKit

struct ParticipantModel {
    var clientName: String?
    var idNumber: String?
    var contactNumber: String?
    var signInDate: String?
}

class SiginInCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var signatureContainerView: UIView!
    @IBOutlet weak var clientNameTf: FloatingTextField!
    @IBOutlet weak var IdNumber: FloatingTextField!
    @IBOutlet weak var contactNymberTf: FloatingTextField!
    @IBOutlet weak var dateSigndTf: FloatingTextField!
    @IBOutlet weak var addParticipantBtn: UIButton!
    
    // MARK: - Properties
    var participants: [ParticipantModel] = []
    var signatureView: SignatureView!   // 👈 Custom signature view
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setup signature view inside container
        signatureView = SignatureView(frame: signatureContainerView.bounds)
        signatureView.backgroundColor = .white
        signatureView.translatesAutoresizingMaskIntoConstraints = false
        signatureContainerView.addSubview(signatureView)
        
        NSLayoutConstraint.activate([
            signatureView.leadingAnchor.constraint(equalTo: signatureContainerView.leadingAnchor),
            signatureView.trailingAnchor.constraint(equalTo: signatureContainerView.trailingAnchor),
            signatureView.topAnchor.constraint(equalTo: signatureContainerView.topAnchor),
            signatureView.bottomAnchor.constraint(equalTo: signatureContainerView.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    @IBAction func addParticipantTapped(_ sender: UIButton) {
        let participant = ParticipantModel(
            clientName: clientNameTf.text ?? "",
            idNumber: IdNumber.text ?? "",
            contactNumber: contactNymberTf.text ?? "",
            signInDate: dateSigndTf.text ?? ""
        )
        
        // 👉 Append new participant
        participants.append(participant)
        
        // ✅ Clear fields after adding
        clientNameTf.text = ""
        IdNumber.text = ""
        contactNymberTf.text = ""
        dateSigndTf.text = ""
        
        // ✅ Also clear signature so next participant can sign
        clearSignature()
        
        print("✅ Total Participants Added: \(participants.count)")
    }
    
    // MARK: - Signature Methods
    func hasSignature() -> Bool {
        return signatureView.getSignatureImage() != nil
    }
    
    func clearSignature() {
        signatureView.clear()
    }
    
    func saveSignature() {
        let image = signatureView.getSignatureImage()   // no need for guard let
        
        guard let imageData = image.jpegData(compressionQuality: 0.9) else {
            print(" Signature convert nahi hua")
            return
        }
        
        let fileName = "signature_\(Int(Date().timeIntervalSince1970)).jpg"
        let fileURL = FileManager.default.urls(for: .documentDirectory,
                                               in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
        
        do {
            try imageData.write(to: fileURL)
            print(" Signature saved at: \(fileURL.path)")
            
            UserDefaults.standard.set(fileURL.path, forKey: "savedSignaturePath")
            UserDefaults.standard.synchronize()
        } catch {
            print(" Error saving signature: \(error)")
        }
    }

    
    // MARK: - API Helper
    func getParametersForAPI() -> [String: Any] {
        let names = participants.map { $0.clientName ?? "" }.joined(separator: ",")
        let ids = participants.map { $0.idNumber ?? "" }.joined(separator: ",")
        let contacts = participants.map { $0.contactNumber ?? "" }.joined(separator: ",")
        let dates = participants.map { $0.signInDate ?? "" }.joined(separator: ",")
        
        return [
            "clientname[]": names,
            "idnumber[]": ids,
            "contactnumber[]": contacts,
            "signindate[]": dates
        ]
    }
}
