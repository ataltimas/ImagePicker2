//
//  ContentView.swift
//  ImagePicker
//
//  Created by scholar on 6/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedImage: Image?
    @State private var isShowingImagePicker = false

    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }

                Button(action: {
                    isShowingImagePicker = true
                }) {
                    Text("Select Image")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }
            .padding()
            .background(Color(UIColor.systemTeal))
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitle("Choose Your Image! 🌿🤍📷", displayMode: .inline)
            .foregroundColor(Color.white)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: Image?

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var selectedImage: Image?

        init(presentationMode: Binding<PresentationMode>, selectedImage: Binding<Image?>) {
            _presentationMode = presentationMode
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = Image(uiImage: uiImage)
            }

            presentationMode.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, selectedImage: $selectedImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




