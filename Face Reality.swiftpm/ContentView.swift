import SwiftUI
import RealityKit

struct ContentView : View {
    @ObservedObject var arViewModel : ARViewModel = ARViewModel()
    @State private var showWelcomeScreen = true
    @State private var showSmilingMuscles = false
    @State private var showScowlingMuscles = false
    @State private var phase = "smiling emotion 😊"
    
    var body: some View {
        ZStack {
            ARViewContainer(arViewModel: arViewModel).edgesIgnoringSafeArea(.all)
            
            // Show the welcome screen only if the `showWelcomeScreen` variable is `true`
            if showWelcomeScreen {
                WelcomeScreenView(dismissAction: {
                    showWelcomeScreen = false
                    showSmilingMuscles = true
                })
            }
            
            if showSmilingMuscles == true {
                SmilingMusclesView(dismissAction: {
                    showSmilingMuscles = false
                    showScowlingMuscles = true
                })
            }
            
            if showScowlingMuscles == true {
                ScowlingMusclesView(dismissAction: {
                    showScowlingMuscles = false
                    
                })
            }
            
            VStack {
                Text(phase  == "smiling emotion 😊" ? smileChecker() : scowlChecker())
                    .padding()
                    .foregroundColor(arViewModel.isSmiling && phase  == "smiling emotion 😊" ? .green : .red)
                    .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
                Spacer()
                
                
                if showWelcomeScreen == false {
                    
                    Button("Go to \(phase == "smiling emotion 😊" ? "scowl emotion 😡" : "smiling emotion 😊")") {
                        if (phase == "smiling emotion 😊") {
                            phase = "scowl emotion 😡"
                        } else {
                            phase = "smiling emotion 😊"
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    
    
    func scowlChecker() -> String {
        if arViewModel.isScowling {
            return "We're angry now! 😡"
        }
        else {
            return "Neutral 😐"
            
        }
    }
    
    func smileChecker() -> String {
        if arViewModel.isSmiling {
            if arViewModel.genuineSmiling {
                return "Genuine smile! 🤩"
            }
            else {
                return "Smiling 😊"
            }
        }
        else {
            return "Neutral 😐"
        }
    }
}

struct WelcomeScreenView: View {
    var dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            // Dim the AR view behind the welcome screen
            Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Welcome to Face Reality!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(50)
                
                Text("This experiment will show how our facial expression muscles are directly related to the human ability to show emotion.")
                    .font(.title)
                    .padding(.horizontal, 50)
                
                Button("Start!") {
                    dismissAction()
                }
                .font(.title2)
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(RoundedRectangle(cornerRadius: 30).fill(.regularMaterial))
                .padding(.bottom, 40)
            }
            .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
            .padding()
        }
    }
}

struct SmilingMusclesView: View {
    var dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text("To smile, we need at least four pairs of facial expression muscles: the zygomatic major and minor, upper lip and nose wing lifter, and upper lip lifter.")
                    .padding(25)
                HStack {
                    Image("smile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                    Image("smileMuscles")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                }
            
                Text("Smiling a little wider also activates the orbicular muscles of the eyes, bringing even more joy to our face and achieving the famous eye-smile look")
                    .padding(25)
                HStack {
                    Image("eyeSmile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                    Image("eyeSmileMuscles1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                    Image("eyeSmileMuscles2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                }

                Button("Next") {
                    dismissAction()
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(RoundedRectangle(cornerRadius: 30).fill(.regularMaterial))
                .padding(.bottom, 40)
                
                
                
                
            }
            .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
            .padding()
        }
    }
}

struct ScowlingMusclesView: View {
    var dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            VStack {
                Text("Look how many muscles we activate when we're angry!")
                    .padding(25)
                Text("Anger is a very complex emotion and it needs the action of muscles like the procerus and corrugator of the eyebrow to draw our eyebrows together and wrinkle our nose, the upper lip-lift and nose-wing muscle to inflate our nostrils, we use the depressor of the lower lip, depressor of the corner of the mouth and mentonians to scowl at the mouth and even the platysma, in the neck, gets involved.")
                    .padding(.horizontal, 25)
                    .padding(.bottom, 25)
                HStack {
                    Image("scowl")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                    Image("scowlMuscles")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(10)
                }
                Text("Gee, that tires us out too much. Better to smile, huh?")
                    .padding(25)
                
                Button("Next") {
                    dismissAction()
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 20)
                .background(RoundedRectangle(cornerRadius: 30).fill(.regularMaterial))
                .padding(.bottom, 40)
                
                
                
                
            }
            .background(RoundedRectangle(cornerRadius: 25).fill(.regularMaterial))
            .padding()
        }
    }
}


struct ARViewContainer: UIViewRepresentable {
    var arViewModel: ARViewModel
    
    func makeUIView(context: Context) -> ARView {
        arViewModel.startSessionDelegate()
        return arViewModel.arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

