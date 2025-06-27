    import UIKit

    final class MovieQuizViewController: UIViewController {
        
        struct QuizQuestion {
            let image: String
            let text: String
            let correctAnswer: Bool
        }
        
        struct QuizStepViewModel {
            let image: UIImage
            let question: String
            let questionNumber: String
        }
        
        @IBOutlet private var imageView: UIImageView!
        @IBOutlet private var textLabel: UILabel!
        @IBOutlet private var counterLabel: UILabel!
        @IBOutlet private var noButton: UIButton!
        @IBOutlet private var yesButton: UIButton!
        
        private var currentQuestionIndex = 0
        private var correctAnswer = 0
        
        private let questions: [QuizQuestion] = [
            QuizQuestion(image: "The Godfather",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: true),
            QuizQuestion(image: "The Dark Knight",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: true),
            QuizQuestion(image: "Kill Bill",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: true),
            QuizQuestion(image: "The Avengers",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: true),
            QuizQuestion(image: "Deadpool",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: true),
            QuizQuestion(image: "The Green Knight",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: true),
            QuizQuestion(image: "Old",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: false),
            QuizQuestion(image: "The Ice Age Adventures of Buck Wild",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: false),
            QuizQuestion(image: "Tesla",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: false),
            QuizQuestion(image: "Vivarium",
                         text: "Рейтинг этого фильма больше чем 6?",
                         correctAnswer: false)
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let currentQuestion = convert(model: questions[currentQuestionIndex])
            show(quiz: currentQuestion) }
        
        private func convert(model: QuizQuestion) -> QuizStepViewModel {
           
            let quizStep = QuizStepViewModel(
                image: UIImage(named: model.image) ?? UIImage(),
                question: model.text,
                questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)"
            )
            
            return quizStep
        }
        
        private func show(quiz step: QuizStepViewModel) {
            imageView.image = step.image
            imageView.layer.cornerRadius = 20
            textLabel.text = step.question
            counterLabel.text = step.questionNumber
        }
        
        private func showAnswerResult(isCorrect: Bool) {
            noButton.isEnabled = false
            yesButton.isEnabled = false
            
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 8
            imageView.layer.cornerRadius = 20
            imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
            
            if isCorrect {
                correctAnswer += 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
               self.showNextQuestionOrResults()
            }
        }
        
        private func showNextQuestionOrResults() {
            noButton.isEnabled = true
            yesButton.isEnabled = true
            
            if currentQuestionIndex == questions.count - 1 {
                let alert = UIAlertController(
                    title: "Этот раунд окончен!",
                    message: "Ваш результат \(correctAnswer)",
                    preferredStyle: .alert)

                let action = UIAlertAction(title: "Сыграть еще раз?", style: .default) { _ in
                    self.currentQuestionIndex = 0
                    
                    self.correctAnswer = 0
                    
                    let firstQuestion = self.questions[self.currentQuestionIndex]
                    let viewModel = self.convert(model: firstQuestion)
                    self.show(quiz: viewModel)
                    
                }
                
                alert.addAction(action)

                self.present(alert, animated: true, completion: nil)
                imageView.layer.borderWidth = 0
                
            } else {
                currentQuestionIndex += 1
                imageView.layer.borderWidth = 0
                let nextQuestion = convert(model: questions[currentQuestionIndex])
                show(quiz: nextQuestion)
            }
        }
        
        @IBAction private func noButtonClick(_ sender: UIButton) {
            let currentQuestion = questions[currentQuestionIndex]
            let givenAnswer = false
            
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        }
        
        @IBAction private func yesButtonClick(_ sender: UIButton) {
            let currentQuestion = questions[currentQuestionIndex]
            let givenAnswer = true
            
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        }
    }

