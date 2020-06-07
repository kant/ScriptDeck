//
//  AppDelegate.swift
//  ScriptDeck
//
//  Created by Ravi Tripathi on 31/05/20.
//

import Cocoa
import Preferences

extension Preferences.PaneIdentifier {
    static let general = Self("general")
}

extension UserDefaults
{
    @objc dynamic var language: String
    {
        get {
            return string(forKey: "language") ?? "bash"
        }
        set {
            set(newValue, forKey: "language")
        }
    }
    
    @objc dynamic var theme: String
    {
        get {
            return string(forKey: "theme") ?? "solarized-dark"
        }
        set {
            set(newValue, forKey: "theme")
        }
    }
}


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var windowController: NSWindowController = {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "MainWindow") as! NSWindowController
        return windowController
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        StatusBarHandler.shared.setImage()
        
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            var isDirectory: ObjCBool = true
            let fullUrl = url.appendingPathComponent("ScriptDeckStore")
            if !FileManager.default.fileExists(atPath: fullUrl.path, isDirectory: &isDirectory) {
                try? FileManager.default.createDirectory(at: fullUrl, withIntermediateDirectories: false, attributes: nil)
            }
            StatusBarHandler.shared.constructMenu(forUrl: fullUrl)
        }
        
    }
}

