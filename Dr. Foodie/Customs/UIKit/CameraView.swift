//
//  CameraView.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/16/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import AVFoundation

// MARK: CameraViewDelegate
@objc protocol CameraViewDelegate {
    func photoWasTaken(photo: UIImage)
}

// MARK: Properties, Constructors, & IBActions
class CameraView: UIView {
    
    @IBOutlet weak var captureBtn: UIButton!
    @IBOutlet weak var delegate: CameraViewDelegate!
    
    private(set) var captureSession: AVCaptureSession!
    private(set) var stillImageOutput: AVCapturePhotoOutput!
    private(set) var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()

            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    @IBAction func snapped(_ sender: UIButton!) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
}

// MARK: Methods
extension CameraView {
    private func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        layer.insertSublayer(videoPreviewLayer, at: 0)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.bounds
            }
        }
    }
}

// MARK: AVCapturePhotoCaptureDelegate
extension CameraView: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        delegate.photoWasTaken(photo: UIImage(data: imageData)!)
        captureSession.stopRunning()
    }
}
