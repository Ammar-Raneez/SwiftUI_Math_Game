//
//  ContentView.swift
//  Assessment
//
//  Created by Visal Rajapakse on 2023-03-13.
//

// Assuming that all calculations are integers as stated in point 9

import SwiftUI

/// Add `enum` cases with `rawValues`  below.
/// Conform `Operator` to `CaseIterable`
///
enum Operator: String, CaseIterable {
    case add = "+"
    case subtract = "-"
    case multiply = "*"
    case divide = "/"
}

struct GameView: View {
    @AppStorage("points") var points = 0
    @AppStorage("titleTintColor") var titleTintColor = ""
    @AppStorage("fontSize") var fontSize = 14.0
    @AppStorage("systemColor") var systemColor = SystemColor.emerald
    
    // Hide keyboard on submit
    @FocusState private var fieldInFocus: Bool
    
    @State private var userAnswer: String = ""
    @State private var generatedOperator = Operator.subtract
    @State private var generatedOperandOne = 0
    @State private var generatedOperandTwo = 0
    @State private var actualAnswer: Int?
    @State var generatedQuestion = ""
    
    @State private var isAnswerValid = false
    @State private var isInputValid = false
    @State private var questionAnswered = false
    
    var body: some View {
        ScrollView{
            VStack {
                VStack(spacing: 30) {
                    Text("Guess the answer!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(systemColor.rawValue))
                    
                    Text("What is \(generatedQuestion)?")
                        .font(.largeTitle)
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                    
                    //NOTE
                    //Assumption or the case of a division that will result in a decimal point, enter the remainder value
                    HStack {
                        HStack {
                            TextField("Answer", text: $userAnswer)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.asciiCapable)
                                .focused($fieldInFocus)
                                .onChange(of: userAnswer) { _ in
                                    questionAnswered = false
                                }
                            
                            Button {
                                checkAnswer()
                            } label: {
                                Text("Submit")
                            }
                            .buttonStyle(.bordered)
                            .tint(.blue)
                            .disabled(questionAnswered)
                        }
                        .padding(.all)
                    }
                    .frame(height: 70)
                    .border(.black)
                    .padding(.horizontal)
                    
                    if questionAnswered{
                        if isAnswerValid {
                            Label("CORRECT ANSWER! WELL DONE!", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Label("Incorrect answer! The actual answer is \(actualAnswer!)", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                VStack(alignment: .center) {
                    Spacer()
                    
                    Text("\(points)")
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    VStack(spacing: 30) {
                        Text("Instructions")
                            .font(.system(size: fontSize))
                        Text("Submit the correct answer and gain 1 point. Submit a wrong answer or press on \"NEXT\" and you will lose 1 point.")
                            .multilineTextAlignment(.center)
                            .font(.system(size: fontSize))
                        
                        Button {
                            generatedQuestion = generateQuestion()
                            deductPoint()
                            userAnswer = ""
                            questionAnswered = false
                        } label: {
                            Text("NEXT")
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                    }
                }
                .padding(.horizontal)
            }
            .onAppear {
                generatedQuestion = generateQuestion()
            }
            .alert(isPresented: $isInputValid) {
                Alert(title: Text("Invalid input"), message: Text("Invalid input, please ensure that you entered a number. If the answer is a decimal number, enter the remainder value instead."), dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    // UNCOMMENT
    private func generateOperands() -> Int {
        return Int.random(in: 1...9)
    }
    
    // UNCOMMENT
    private func generateOperator() -> Operator {
        return Operator.allCases.randomElement()!
    }
    
    private func generateQuestion() -> String {
        generatedOperandTwo = generateOperands()
        generatedOperandOne = generateOperands()
        generatedOperator = generateOperator()
        return "\(generatedOperandOne) \(generatedOperator.rawValue) \(generatedOperandTwo)"
    }
    
    private func checkAnswer() {
        fieldInFocus = false
        isAnswerValid = false
        questionAnswered = false
        isInputValid = false
        
        guard let answer = Int(userAnswer) else {
            print("Invalid user input. Please enter an integer, if its a decimal number, enter the remainder")
            isInputValid = true
            return
        }
        
        switch generatedOperator {
        case .add:
            actualAnswer = generatedOperandOne + generatedOperandTwo
            
        case .subtract:
            actualAnswer = generatedOperandOne - generatedOperandTwo
            
        case .multiply:
            actualAnswer = generatedOperandOne * generatedOperandTwo
            
        case .divide:
            actualAnswer = generatedOperandOne / generatedOperandTwo
        }

        if answer == actualAnswer! {
            isAnswerValid = true
            addPoint()
        } else {
            isAnswerValid = false
            deductPoint()
        }
        
//        userAnswer = ""
        questionAnswered = true
        generatedQuestion = generateQuestion()
    }
    
    private func addPoint() {
        points += 1
    }
    
    private func deductPoint() {
        if points > 0 {
            points -= 1
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
