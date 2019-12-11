//
//  filter.swift
//  kavakExercise
//
//  Created by Andrés Abraham Bonilla Gómez on 12/3/19.
//  Copyright © 2019 Andrés Abraham Bonilla Gómez. All rights reserved.
//

import UIKit
import iOSDropDown

class filter: UIView {

    @IBOutlet var container: UIView!
    @IBOutlet weak var hairDropDown: DropDown!
    @IBOutlet weak var professionDropDown: DropDown!
    @IBOutlet weak var valueHeight: UISlider!
    @IBOutlet weak var showHeight: UILabel!
    @IBOutlet weak var valueWeight: UISlider!
    @IBOutlet weak var showWeight: UILabel!
    @IBOutlet weak var valueAge: UISlider!
    @IBOutlet weak var showAge: UILabel!
    @IBOutlet weak var switchAge: UISwitch!
    @IBOutlet weak var switchWeight: UISwitch!
    @IBOutlet weak var switchHeight: UISwitch!
    @IBOutlet weak var switchHair: UISwitch!
    @IBOutlet weak var switchProfession: UISwitch!
    
    
    weak var delegate: dataFiler?
    
    private var infoFilter = [String:Any]()
    
    
    public var minimumValueAge = 0.0 {
        didSet {
            initHairDropDown()
        }
    }
    
    public var maximumValueAge = 1.0 {
        didSet {
            initHairDropDown()
        }
    }
    
    public var minimumValueWeight = 0.0 {
        didSet {
            initHairDropDown()
        }
    }
    
    public var maximumValueWeight = 1.0 {
        didSet {
            initHairDropDown()
        }
    }
    
    public var minimumValueHeight = 0.0 {
        didSet {
            initHairDropDown()
        }
    }
    
    public var maximumValueHeight = 1.0 {
        didSet {
            initHairDropDown()
        }
    }
    
    public var optionsHairColor = ["Black"] {
        didSet {
            initHairDropDown()
        }
    }
    
    public var optionsProfessions = ["Medic"] {
        didSet {
            initHairDropDown()
        }
    }

    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        custom()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        custom()
    }

    private func custom()
    {
        Bundle.main.loadNibNamed("filter", owner: self, options: nil)
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        addSubview(container)
        initHairDropDown()
    }

    func initHairDropDown()
    {
        hairDropDown.optionArray = optionsHairColor
        hairDropDown.inputView = UIView()
        hairDropDown.text = "Hair Color"
        hairDropDown.isUserInteractionEnabled = false
        hairDropDown.didSelect { (info, _, _) in
            self.infoFilter["hairColor"] = info
        }
        
        professionDropDown.optionArray = optionsProfessions
        professionDropDown.inputView = UIView()
        professionDropDown.text = "Professions"
        professionDropDown.isUserInteractionEnabled = false
        professionDropDown.didSelect { (info, _, _) in
            self.infoFilter["profession"] = info
        }
        
        valueAge.isUserInteractionEnabled = false
        valueAge.minimumValue = Float(minimumValueAge)
        valueAge.maximumValue = Float(maximumValueAge)
        showAge.text = String(minimumValueAge)
        valueWeight.isUserInteractionEnabled = false
        valueWeight.minimumValue = Float(minimumValueWeight)
        valueWeight.maximumValue = Float(maximumValueWeight)
        showWeight.text = String(minimumValueWeight)
        valueHeight.isUserInteractionEnabled = false
        valueHeight.minimumValue = Float(minimumValueHeight)
        valueHeight.maximumValue = Float(maximumValueHeight)
        showHeight.text = String(minimumValueHeight)
    }

    @IBAction func changeValueAge(_ sender: UISlider) {
        showAge.text = String(Int(sender.value))
        self.infoFilter["age"] = Int(sender.value)
    }
    
    @IBAction func changeValueWeight(_ sender: UISlider) {
        showWeight.text = String(sender.value)
        self.infoFilter["weight"] = sender.value
    }
    
    @IBAction func changeValueHeight(_ sender: UISlider) {
        showHeight.text = String(sender.value)
        self.infoFilter["height"] = sender.value
    }
    
    @IBAction func saveFilter(_ sender: Any) {
        print(infoFilter)
        delegate?.infoFilter(infoFilter)
    }
    
    @IBAction func defultFilter(_ sender: Any) {
        infoFilter.removeAll()
        switchAge.isOn = false
        switchWeight.isOn = false
        switchHair.isOn = false
        switchHeight.isOn = false
        switchProfession.isOn = false
        
        showAge.isHidden = true
        valueAge.isHidden = true
        showWeight.isHidden = true
        valueWeight.isHidden = true
        showHeight.isHidden = true
        valueHeight.isHidden = true
        hairDropDown.isHidden = true
        professionDropDown.isHidden = true
        
        delegate?.defaultFilter(true)
    }
    
    @IBAction func enableAge(_ sender: UISwitch) {
        valueAge.isUserInteractionEnabled = sender.isOn
        if !sender.isOn
        {
            showAge.isHidden = true
            valueAge.isHidden = true
            self.infoFilter["age"] = nil
        }
        else
        {
            showAge.isHidden = false
            valueAge.isHidden = false
            self.infoFilter["age"] = Int(valueAge.value)
        }
    }
    
    @IBAction func enableWeight(_ sender: UISwitch) {
        valueWeight.isUserInteractionEnabled = sender.isOn
        if !sender.isOn
        {
            showWeight.isHidden = true
            valueWeight.isHidden = true
            self.infoFilter["weight"] = nil
        }
        else
        {
            valueWeight.isHidden = false
            showWeight.isHidden = false
            self.infoFilter["weight"] = valueWeight.value
        }
    }
    
    @IBAction func enableheight(_ sender: UISwitch) {
        valueHeight.isUserInteractionEnabled = sender.isOn
        if !sender.isOn
        {
            showHeight.isHidden = true
            valueHeight.isHidden = true
            self.infoFilter["height"] = nil
        }
        else
        {
            showHeight.isHidden = false
            valueHeight.isHidden = false
            self.infoFilter["height"] = valueHeight.value
        }
    }
    
    @IBAction func enableHairColor(_ sender: UISwitch) {
        hairDropDown.isUserInteractionEnabled = sender.isOn
        if !sender.isOn
        {
            hairDropDown.isHidden = true
            self.infoFilter["hairColor"] = nil
        }
        else
        {
            hairDropDown.isHidden = false
        }
    }
    
    @IBAction func enableProfession(_ sender: UISwitch) {
        professionDropDown.isUserInteractionEnabled = sender.isOn
        if !sender.isOn
        {
            professionDropDown.isHidden = true
            self.infoFilter["profession"] = nil
        }
        else
        {
            professionDropDown.isHidden = false
        }
    }
}

protocol dataFiler: class {
    func infoFilter(_ data: [String:Any])
    func defaultFilter(_ flag: Bool)
}
