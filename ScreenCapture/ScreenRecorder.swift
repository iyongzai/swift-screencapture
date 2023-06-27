//
//  ScreenRecorder.swift
//  ScreenCapture
//
//  Created by Jack P. on 11/12/2015.
//  Copyright © 2015 Jack P. All rights reserved.
//

import Foundation
import AVFoundation

open class ScreenRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {
    
    let destinationUrl: URL
    let session: AVCaptureSession
    let movieFileOutput: AVCaptureMovieFileOutput
    
    open var destination: URL {
        get {
            return self.destinationUrl
        }
    }

    public init(destination: URL) {
        destinationUrl = destination
        
        session = AVCaptureSession()
        session.sessionPreset = .high
        
        let displayId: CGDirectDisplayID = CGDirectDisplayID(CGMainDisplayID())

        let input: AVCaptureScreenInput = AVCaptureScreenInput(displayID: displayId)!

        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        movieFileOutput = AVCaptureMovieFileOutput()

        if session.canAddOutput(movieFileOutput) {
            session.addOutput(movieFileOutput)
        }
        
    }
 
    open func start() {
        session.startRunning()
        movieFileOutput.startRecording(to: destinationUrl, recordingDelegate: self)
    }
    
    open func stop() {
        movieFileOutput.stopRecording()
    }
    
    public func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        //
        session.stopRunning()
    }
}
