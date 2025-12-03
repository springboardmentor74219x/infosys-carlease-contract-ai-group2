class Classifier:
    def __init__(self):
        pass
    
    def train(self, X_train, y_train):
        """Train the classifier"""
        raise NotImplementedError
    
    def predict(self, X):
        """Make predictions"""
        raise NotImplementedError
    
    def evaluate(self, X_test, y_test):
        """Evaluate classifier performance"""
        raise NotImplementedError