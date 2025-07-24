//
//  main.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

let isRunningTests = AppUtils.isRunningTests()
let appDelegateClass = isRunningTests ? nil : NSStringFromClass(AppDelegate.self)
UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, appDelegateClass)
