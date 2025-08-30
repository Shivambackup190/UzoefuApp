import UIKit
//oo
class SiginInCell: UITableViewCell {
    var signatureView: SignatureView!



    @IBOutlet weak var signatureContainerView: FloatingSignatureView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // SignatureView ko container ke andar fit karna
        signatureView = SignatureView(frame: signatureContainerView.bounds)
        signatureView.backgroundColor = .white
        signatureView.translatesAutoresizingMaskIntoConstraints = false
        signatureContainerView.addSubview(signatureView)

        // Auto Layout constraints -> puri jagah fill karega
        NSLayoutConstraint.activate([
            signatureView.leadingAnchor.constraint(equalTo: signatureContainerView.leadingAnchor),
            signatureView.trailingAnchor.constraint(equalTo: signatureContainerView.trailingAnchor),
            signatureView.topAnchor.constraint(equalTo: signatureContainerView.topAnchor),
            signatureView.bottomAnchor.constraint(equalTo: signatureContainerView.bottomAnchor)
        ])
    }

    @objc func clearSignature() {
        signatureView.clear()
    }

    @objc func saveSignature() {
        let image = signatureView.getSignatureImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil) // Save to Photos
    }
}
