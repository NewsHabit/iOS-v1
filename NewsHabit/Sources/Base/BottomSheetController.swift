//
//  BottomSheetController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

import SnapKit
import Then

class BottomSheetController<View: UIView>: UIViewController {
    
    // MARK: - Properties
    
    var bottomSheetHeight: CGFloat
    
    // MARK: - UI Components
    
    let dimmedView = UIView().then {
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    let sheetView = View().then {
        $0.backgroundColor = .background
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // 왼쪽 위, 오른쪽 위 둥글게
    }
    
    let indicator = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 2
        $0.backgroundColor = .newsHabitLightGray
    }
    
    // MARK: - Initializer
    
    init(bottomSheetHeight: CGFloat) {
        self.bottomSheetHeight = bottomSheetHeight
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showBottomSheets()
    }
    
    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        view.addSubview(dimmedView)
        view.addSubview(sheetView)
        sheetView.addSubview(indicator)
    }
    
    private func setupLayout() {
        dimmedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        sheetView.snp.makeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bottomSheetHeight)
        }
        
        indicator.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(4)
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupGestureRecognizer() {
        // TapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDimmedViewTap))
        dimmedView.addGestureRecognizer(tapGesture)
        
        // SwipeGesture
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleDownGesture))
        swipeGesture.direction = .down
        view.addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Action Functions
    
    @objc private func handleDimmedViewTap(_ tapRecognizer: UITapGestureRecognizer) {
        hideBottomSheets()
    }
    
    @objc private func handleDownGesture(_ swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .ended {
            switch swipeRecognizer.direction {
            case .down:
                hideBottomSheets()
            default:
                break
            }
        }
    }
    
    // MARK: - Bottom Sheet Functions
    
    private func showBottomSheets() {
        sheetView.snp.remakeConstraints {
            $0.leading.bottom.trailing.equalToSuperview()
            $0.height.equalTo(bottomSheetHeight)
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.backgroundColor = .newsHabitDarkGray.withAlphaComponent(0.75)
            self.view.layoutIfNeeded()
        })
    }
    
    func hideBottomSheets() {
        sheetView.snp.remakeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(bottomSheetHeight)
        }
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.backgroundColor = .clear
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false)
            }
        }
    }
    
}
