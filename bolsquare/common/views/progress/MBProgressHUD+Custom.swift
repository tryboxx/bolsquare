//
//  MBProgressHUD+Custom.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import MBProgressHUD

extension MBProgressHUD {

    class func showProgress(addedTo parent: UIView, animated: Bool) -> MBProgressHUD {
        showProgressView(addedTo: parent, inMode: .horizontalProgress, animated: animated)
    }

    class func showLoading(addedTo parent: UIView, animated: Bool) -> MBProgressHUD {
        showProgressView(addedTo: parent, inMode: .indeterminate, animated: animated)
    }

    private class func showProgressView(
        addedTo parent: UIView,
        inMode mode: CustomProgressViewMode,
        animated: Bool
    ) -> MBProgressHUD {
        let progressHUD = MBProgressHUD.showAdded(to: parent, animated: animated)
        progressHUD.customView = CustomProgressView(forMode: mode)
        progressHUD.mode = .customView
        progressHUD.contentColor = Colors.white.color
        progressHUD.margin = CGFloat(24)
        progressHUD.offset = CGPoint(x: 0, y: -50)
        progressHUD.backgroundView.color = .black.withAlphaComponent(0.15)
        return progressHUD
    }

    var customProgressView: CustomProgressView? {
        customView as? CustomProgressView
    }

    var customProgress: Float {
        get {
            progress
        }

        set {
            progress = newValue
            customProgressView?.progress = newValue
        }
    }
}
