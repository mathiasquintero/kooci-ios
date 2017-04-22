//
//  WatsonServices.swift
//  kooci
//
//  Created by Ute Schiehlen on 22.04.17.
//  Copyright © 2017 Ute Schiehlen. All rights reserved.
//

import Foundation
import TextToSpeechV1
import AVFoundation
import SpeechToTextV1

class WatsonServices {
    
    // audio player
    var audioPlayer = AVAudioPlayer()
    
    // watson services
    var textToSpeech: TextToSpeech?
    var speechToText: SpeechToText?
    
    public init() {
        let usernameTTS = "b39e1e6a-f4cd-46ec-8236-e90680c0d23b"
        let passwordTTS = "JGsVO86XLDsW"
        textToSpeech = TextToSpeech(username: usernameTTS, password: passwordTTS)
        
        let usernameSTT = "87b2a138-f8a3-4ee7-bc10-884a46806d35"
        let passwordSTT = "8pNOxP7gRiv6"
        speechToText = SpeechToText(username: usernameSTT, password: passwordSTT)
    }
    
    func speak(text: String, completion: @escaping (_ success: Bool) -> Void) {
        textToSpeech?.synthesize(text, voice: SynthesisVoice.us_Allison.rawValue , success: { data in
            do {
                self.audioPlayer = try AVAudioPlayer(data: data)
                self.audioPlayer.play()
                completion(true)
            } catch let error {
                print("error \(error) playing audio file")
                completion(false)
            }
        })
    }
    
    func startStreaming(completion: @escaping (_ success: String) -> Void) {
        var settings = RecognitionSettings(contentType: .opus)
        settings.interimResults = true
        settings.continuous = true
        
        speechToText?.recognizeMicrophone(settings: settings, success: { results in
            print(results.bestTranscript)
            completion(results.bestTranscript)
        })
    }
    
    func stopStreaming() {
        speechToText?.stopRecognizeMicrophone()
    }
}
