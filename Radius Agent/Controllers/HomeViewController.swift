//
//  ViewController.swift
//  Radius Agent
//
//  Created by Karthi CK on 19/01/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:  Properties

    private let cellReuseID = "reuseID"
    private var facilitiesList = FacilitiesModal()
    private var screenSize = UIScreen.main.bounds

    @IBOutlet weak var tableView: UITableView!

    private var selectedFacility = [Int : Exclusion]()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        fetchData()
    }
    
    // MARK: View Set Up
    
    private func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: Fetch Facilities and Exclusion Data

    private func fetchData() {
        NetworkManager.shared.fetchFacilities { [weak self] (error, facilitiesModal) in
            if let facilitiesModal = facilitiesModal {
                self?.facilitiesList = facilitiesModal
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Table View DataSource & Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return facilitiesList.facilities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView(frame: CGRect(origin: .zero, size: tableView.frame.size))
        headerView.facilityLabel.text = facilitiesList.facilities?[section].name
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facilitiesList.facilities?[section].options?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath) as! OptionsTableViewCell
                
        cell.selectionStyle = .none
        
        guard let facility = facilitiesList.facilities?[indexPath.section] else { return cell }
        guard let options = facility.options?[indexPath.row] else { return cell }

        cell.optionsImageView.image = UIImage(named: options.icon ?? "")
        cell.optionsLabel.text = options.name
        
        // Checking the selected option
        if (selectedFacility[indexPath.section] != nil &&
            selectedFacility[indexPath.section]?.optionsID == options.id) {
            cell.accessoryType = .checkmark
            cell.accessoryView?.backgroundColor = UIColor(named: "PeachGreenColor")
        } else {
            cell.accessoryType = .none
        }
        
        // To mask the corners of last cell
        if (indexPath.row == (facility.options?.count ?? 0) - 1) {
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.cornerRadius = 8
            cell.layer.masksToBounds = true
        } else {
            cell.layer.cornerRadius = 0
            cell.layer.masksToBounds = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let facility = facilitiesList.facilities?[indexPath.section] else { return }
        guard let option = facility.options?[indexPath.row] else { return }
        
        let exclusion = Exclusion(facilityID: facility.facilityID, optionsID: option.id)
        selectedFacility.updateValue(exclusion, forKey: indexPath.section)
        
        // Check for exclusions
        if let exclusions = facilitiesList.exclusions {
            var exludedFacilityOption = [Exclusion]()
            // assign the exclusion array that matches the selected option and facility from exclusion list
            exclusions.forEach { exclusion in
                if (exclusion.first { $0.facilityID == facility.facilityID  && $0.optionsID == option.id } != nil) {
                    exludedFacilityOption = exclusion
                }
            }
            
            // if there's exclusion, check whether options can be selected from the previous selected facility
            if (exludedFacilityOption.count > 0) {
                var filteredSelectedFacility = [Exclusion]()
                for exclusion in exludedFacilityOption {
                    for value in selectedFacility.values {
                        if (value.facilityID == exclusion.facilityID && value.optionsID == exclusion.optionsID) {
                            filteredSelectedFacility.append(value)
                        }
                    }
                }
                
                if (filteredSelectedFacility.count == exludedFacilityOption.count) {
                    selectedFacility.removeValue(forKey: indexPath.section)
                    showToast("Sorry, But it's a invalid combination", bgColor: .red.withAlphaComponent(0.8))
                }
            }
        }
        
        tableView.reloadData()
    }

}
