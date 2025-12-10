import UIKit

class FavoritesView: UIView {
    
    var navBar: TopNavigationBarView!
    var collectionViewFavorites: UICollectionView!
    var titleBackground: UIView!
    var favoritesLabel: UILabel!
    var subLabel: UILabel!
    var emptyStateView: UIView!
    var emptyStateLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 1.0, green: 0.953, blue: 0.851, alpha: 1.0)
        
        setupNavBar()
        setupCollectionView()
        setupRect()
        setupLabels()
        setupEmptyState()
        
        initConstraints()
    }
    
    func setupNavBar() {
        navBar = TopNavigationBarView()
        navBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(navBar)
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        collectionViewFavorites = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewFavorites.translatesAutoresizingMaskIntoConstraints = false
        collectionViewFavorites.backgroundColor = .clear
        collectionViewFavorites.register(FavoriteCardCell.self, forCellWithReuseIdentifier: FavoriteCardCell.identifier)
        self.addSubview(collectionViewFavorites)
    }
    
    func setupRect() {
        titleBackground = UIView()
        titleBackground.translatesAutoresizingMaskIntoConstraints = false
        titleBackground.backgroundColor = UIColor(red: 0.72, green: 0.21, blue: 0.055, alpha: 0.67)
        titleBackground.layer.cornerRadius = 12
        self.addSubview(titleBackground)
    }
    
    func setupLabels() {
        favoritesLabel = UILabel()
        favoritesLabel.text = "Favorites"
        favoritesLabel.font = UIFont.systemFont(ofSize: 30)
        favoritesLabel.textColor = .black
        favoritesLabel.textAlignment = .center
        favoritesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(favoritesLabel)
        
        subLabel = UILabel()
        subLabel.text = "Your saved lessons"
        subLabel.font = UIFont.systemFont(ofSize: 16)
        subLabel.textColor = .black
        subLabel.textAlignment = .center
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subLabel)
    }
    
    func setupEmptyState() {
        emptyStateView = UIView()
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.isHidden = true
        self.addSubview(emptyStateView)
        
        let emptyIcon = UIImageView()
        emptyIcon.image = UIImage(systemName: "star.slash")
        emptyIcon.tintColor = .systemGray3
        emptyIcon.contentMode = .scaleAspectFit
        emptyIcon.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.addSubview(emptyIcon)
        
        emptyStateLabel = UILabel()
        emptyStateLabel.text = "No Favorites Yet"
        emptyStateLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        emptyStateLabel.textColor = .systemGray
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.addSubview(emptyStateLabel)
        
        let emptySubLabel = UILabel()
        emptySubLabel.text = "Tap the star icon on lessons\nto add them to favorites"
        emptySubLabel.font = UIFont.systemFont(ofSize: 16)
        emptySubLabel.textColor = .systemGray2
        emptySubLabel.textAlignment = .center
        emptySubLabel.numberOfLines = 0
        emptySubLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.addSubview(emptySubLabel)
        
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            emptyIcon.topAnchor.constraint(equalTo: emptyStateView.topAnchor),
            emptyIcon.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyIcon.widthAnchor.constraint(equalToConstant: 80),
            emptyIcon.heightAnchor.constraint(equalToConstant: 80),
            
            emptyStateLabel.topAnchor.constraint(equalTo: emptyIcon.bottomAnchor, constant: 20),
            emptyStateLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptyStateLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            
            emptySubLabel.topAnchor.constraint(equalTo: emptyStateLabel.bottomAnchor, constant: 8),
            emptySubLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor),
            emptySubLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor),
            emptySubLabel.bottomAnchor.constraint(equalTo: emptyStateView.bottomAnchor)
        ])
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 60),
            
            titleBackground.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            titleBackground.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleBackground.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleBackground.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleBackground.heightAnchor.constraint(equalToConstant: 60),
            
            favoritesLabel.centerXAnchor.constraint(equalTo: titleBackground.centerXAnchor),
            favoritesLabel.centerYAnchor.constraint(equalTo: titleBackground.centerYAnchor),
            
            subLabel.topAnchor.constraint(equalTo: titleBackground.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            collectionViewFavorites.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 10),
            collectionViewFavorites.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionViewFavorites.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionViewFavorites.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func updateEmptyState(_ isEmpty: Bool) {
        emptyStateView.isHidden = !isEmpty
        collectionViewFavorites.isHidden = isEmpty
    }
    
    func setAccountTarget(_ target: Any?, action: Selector) {
        navBar.account.addTarget(target, action: action, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
