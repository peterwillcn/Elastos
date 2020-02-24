//
//  IntentActionChooserItemView.swift
//  elastOS
//
//  Created by Benjamin Piette on 24/02/2020.
//

import Foundation

class IntentActionChooserItemView: UIView {
    // Outlets
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var appNameView: UILabel!
    
    // Model
    private var listener: (()->Void)? = nil
    
    init(appManager: AppManager, appInfo: AppInfo) {
        super.init(frame: CGRect.null)
        
        let view = Bundle.main.loadNibNamed("IntentActionChooserItemView", owner: self, options: nil)![0] as! UIView
        
        self.addSubview(view)
        stretch(view: view)
        
        // Setup UI according to model
        let iconPaths = appManager.getIconPaths(appInfo)
        if (iconPaths.count > 0) {
            let appIconPath = iconPaths[0]
            iconView.image = UIImage(contentsOfFile: appIconPath)
        }
        else {
            iconView.isHidden = true
        }
        appNameView.text = appInfo.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stretch(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
     
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @IBAction func onViewTapped(_ sender: Any) {
        listener?()
    }
    
    public func setListener(_ listener: @escaping ()->Void) {
        self.listener = listener
    }
}
