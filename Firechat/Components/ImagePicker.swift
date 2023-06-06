//
//  ImagePicker.swift
//  Firechat
//
//  Created by Glenn Ludszuweit on 06/06/2023.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: Image?
    @Environment(\.presentationMode) private var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var image: Image?
        private let presentationMode: Binding<PresentationMode>
        
        init(image: Binding<Image?>, presentationMode: Binding<PresentationMode>) {
            _image = image
            self.presentationMode = presentationMode
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let uiImage = info[.originalImage] as? UIImage else { return }
            image = Image(uiImage: uiImage)
            presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, presentationMode: presentationMode)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No update needed
    }
}
