//
//  MockData.swift
//  Group6_RyuKoi
//
//  Created by R M on 12/8/25.
//

import Foundation

// MARK: Placeholder Image Data
let placeholderImageData = Data(base64Encoded: "iVBORw0KGgoAAAANSUhEUgAAAAUA")!

let mockCategories: [Categories] = [

    // --------------------------------------------------
    // 1. TAEKWONDO
    // --------------------------------------------------
    Categories(
        name: .Taekwondo,
        lesson: [
            Lesson(
                title: "Intro to Taekwondo",
                description: "Learn history, etiquette, and basic stances.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Stay relaxed and learn the basic stances.")
            ),
            Lesson(
                title: "Basic Footwork",
                description: "Learn stepping, pivoting, and fighting stance.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Keep your guard up and your weight centered.")
            ),
            Lesson(
                title: "Essential Kicks",
                description: "Master front kick, roundhouse, and side kick.",
                progressState: .notStarted,
                progressPercentage: 35,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Drive your knee upward before extending the kick.")
            ),
            Lesson(
                title: "Blocking Techniques",
                description: "Learn rising block, inside block, and low block.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Rotate your shoulders during each block.")
            ),
            Lesson(
                title: "Poomsae Basics",
                description: "Perform the first Taekwondo form (Taegeuk Il Jang).",
                progressState: .notStarted,
                progressPercentage: 100,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Focus on rhythm and breathing.")
            )
        ]
    ),

    // --------------------------------------------------
    // 2. KARATE
    // --------------------------------------------------
    Categories(
        name: .Karate,
        lesson: [
            Lesson(
                title: "Karate Fundamentals",
                description: "Learn the core principles of Karate movement.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Keep posture straight and hips forward.")
            ),
            Lesson(
                title: "Stances Training",
                description: "Practice front stance, horse stance, and back stance.",
                progressState: .notStarted,
                progressPercentage: 20,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Distribute weight properly across both feet.")
            ),
            Lesson(
                title: "Basic Strikes",
                description: "Learn jab, reverse punch, and knife-hand strike.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Rotate hips to generate power.")
            ),
            Lesson(
                title: "Kata Introduction",
                description: "Learn Taikyoku Shodan, the first kata.",
                progressState: .notStarted,
                progressPercentage: 10,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Maintain strong stances throughout.")
            ),
            Lesson(
                title: "Self-Defense Basics",
                description: "Introduction to distance, timing, and awareness.",
                progressState: .notStarted,
                progressPercentage: 100,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "React calmly and move off the attack line.")
            )
        ]
    ),

    // --------------------------------------------------
    // 3. BOXING
    // --------------------------------------------------
    Categories(
        name: .Boxing,
        lesson: [
            Lesson(
                title: "Boxing Stance",
                description: "Learn balance, guard position, and mobility.",
                progressState: .notStarted,
                progressPercentage: 100,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Stay light on your toes.")
            ),
            Lesson(
                title: "Footwork Essentials",
                description: "Practice moving forward, backward, and side-to-side.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Avoid crossing your feet.")
            ),
            Lesson(
                title: "Fundamental Punches",
                description: "Master jab, cross, hook, and uppercut.",
                progressState: .notStarted,
                progressPercentage: 50,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Twist your hips with each punch.")
            ),
            Lesson(
                title: "Defensive Techniques",
                description: "Learn slips, rolls, blocks, and parries.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Synchronize head movement with footwork.")
            ),
            Lesson(
                title: "Punch Combinations",
                description: "Learn 1-2-3, 1-2-slip-2, and other combos.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Keep elbows in and stay tight.")
            ),
            Lesson(
                title: "Heavy Bag Training",
                description: "Develop power, endurance, and timing.",
                progressState: .notStarted,
                progressPercentage: 15,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Don't push the bag—snap your punches."
                )
            )
        ]
    ),

    // --------------------------------------------------
    // 4. JUJUTSU
    // --------------------------------------------------
    Categories(
        name: .Jujutsu,
        lesson: [
            Lesson(
                title: "Ukemi (Breakfalls)",
                description: "Learn front, back, and side breakfalls.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Slap the ground with your arms to absorb impact.")
            ),
            Lesson(
                title: "Basic Grips",
                description: "Learn sleeve grip, collar grip, and overhooks.",
                progressState: .notStarted,
                progressPercentage: 100,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Stay relaxed—do not squeeze too hard.")
            ),
            Lesson(
                title: "Joint Locks",
                description: "Practice wrist locks, elbow locks, and control holds.",
                progressState: .notStarted,
                progressPercentage: 25,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Use leverage, not strength.")
            ),
            Lesson(
                title: "Throws Introduction",
                description: "Learn hip toss, foot sweep, and shoulder throw.",
                progressState: .notStarted,
                progressPercentage: 40,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Break opponent balance (kuzushi) first.")
            ),
            Lesson(
                title: "Ground Control Basics",
                description: "Learn mount, guard, and side control.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Keep your weight centered.")
            )
        ]
    ),

    // --------------------------------------------------
    // 5. OTHER
    // --------------------------------------------------
    Categories(
        name: .Other,
        lesson: [
            Lesson(
                title: "Meditation Basics",
                description: "Breathing and focus techniques.",
                progressState: .notStarted,
                progressPercentage: 100,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Relax your jaw and breathe naturally.")
            ),
            Lesson(
                title: "Stretching Fundamentals",
                description: "Improve flexibility and reduce injury.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Hold each stretch for at least 20 seconds.")
            ),
            Lesson(
                title: "Strength Training",
                description: "Bodyweight exercises for martial artists.",
                progressState: .notStarted,
                progressPercentage: 30,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Maintain proper form over speed.")
            ),
            Lesson(
                title: "Balance Training",
                description: "Improve stability and posture.",
                progressState: .notStarted,
                progressPercentage: 0,
                practice: Practice(PracticeMove: placeholderImageData,
                    tips: "Focus on one unmoving point ahead of you.")
            )
        ]
    )
]
