# ProjectWeSplit1
Paul Hudson 100DaysOfSwiftUI


DAY 16



Modifying program state


There’s a saying among SwiftUI developers that our “views are a function of their state,”.
If you were playing a fighting game, you might have lost a few lives, we call these things state – the active collection of settings that describe how the game is right now.
When we say SwiftUI’s views are a function of their state, we mean that the way your user interface looks – the things people can see and what they can interact with – are determined by the state of your program. 

struct ContentView: View {
    var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
        }
    }
}

You see, ContentView is a struct, which might be created as a constant. If you think back to when you learned about structs, that means it’s immutable – we can’t change its values freely. When creating struct methods that want to change properties, we need to add the mutating keyword: mutating func doSomeWork(), for example. However, Swift doesn’t let us make mutating computed properties, which means we can’t write mutating var body: some View – it just isn’t allowed.

This might seem like we’re stuck at an impasse: we want to be able to change values while our program runs, but Swift won’t let us because our views are structs.


Fortunately, Swift gives us a special solution called a property wrapper: a special attribute we can place before our properties that effectively gives them super-powers. In the case of storing simple program state like the number of times a button was tapped, we can use a property wrapper from SwiftUI called @State, like this:

struct ContentView: View {
    @State var tapCount = 0

    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
}

@State allows us to work around the limitation of structs: we know we can’t change their properties because structs are fixed, but @State allows that value to be stored separately by SwiftUI in a place that can be modified. 


Binding state to user interface controls


If you wanted to create an editable text box that users can type into, you might create a SwiftUI view like this one: 

struct ContentView: View {
    var body: some View {
        Form {
            TextField("Enter your name")
            Text("Hello, world!")
        }
    }
}

That code won’t compile because SwiftUI wants to know where to store the text in the text field. Views are a function of their state – that text field can only show something if it reflects a value stored in your program. 

That adds a name property, then uses it to create the text field.

struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: name)
            Text("Hello, world!")
        }
    }
}


But that still isn’t enough, and our code still won’t compile.

The problem is that Swift differentiates between “show the value of this property here” and “show the value of this property here, but write any changes back to the property.”

In the case of our text field, Swift needs to make sure whatever is in the text is also in the name property, so that it can fulfill its promise that our views are a function of their state – that everything the user can see is just the visible representation of the structs and properties in our code.

This is what’s called a two-way binding: we bind the text field so that it shows the value of our property, but we also bind it so that any changes to the text field also update the property.

In Swift, we mark these two-way bindings with a special symbol so they stand out: we write a dollar sign before them.

struct ContentView: View {
    @State private var name = ""

    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            Text("Hello, world!")
        }
    }
}
