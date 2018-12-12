final class Toast {
	
	private var parentView: UIView!
	
	private var	toastLabel: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 0
		label.lineBreakMode = .byWordWrapping
		label.font = UIFont.systemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textAlignment = .center
		return label
	}()
	
	private var	toastView: UIView = {
		let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 260))
		v.translatesAutoresizingMaskIntoConstraints = false
		v.alpha = 0
		return v
	}()
	
	@discardableResult
	convenience init(display label: String, on vc: UIViewController) {
		self.init()
		parentView = vc.view
		toastLabel.text = label
		setupView()
		animateToast()
	}
	
	private func animateToast() {
		UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
			self.toastView.alpha = 1.0
		}, completion: { _ in
			UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
				self.toastView.alpha = 0.0
			}, completion: {_ in
				self.toastView.removeFromSuperview()
			})
		})
	}
	
	private func addVisualEffect() {
		toastView.backgroundColor = .clear
		let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.regular))
		visualEffectView.frame = toastView.bounds
		visualEffectView.layer.cornerRadius = 25
		visualEffectView.clipsToBounds = true
		visualEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		toastView.addSubview(visualEffectView)
	}
	
	private func setupView() {
		addVisualEffect()
		toastView.addSubview(toastLabel)
		parentView.addSubview(toastView)
		
		NSLayoutConstraint.activate([
			toastView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -75),
			toastView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: 65),
			toastView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -65),
			toastLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 15),
			toastLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -15),
			toastLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 15),
			toastLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -15)
		])
	}
}
