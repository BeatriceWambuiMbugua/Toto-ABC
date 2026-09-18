//
//  TraceLetterView.swift
//  Toto ABC
//
//  Created by Bobo on 17/09/26.
//


import SwiftUI
import UIKit

struct TraceLetterView: View {
    let letter: String
    let backgroundAsset: String
    let completedLetterColor: Color

    var onClose: () -> Void = {}
    var onAudioTap: (Bool) -> Void = { _ in }

    @State private var isMuted = false

    init(
        letter: String = "A",
        backgroundAsset: String = "bgPastelCoral",
        completedLetterColor: Color = Color(hex: "#B4233B"),
        onClose: @escaping () -> Void = {},
        onAudioTap: @escaping (Bool) -> Void = { _ in }
    ) {
        self.letter = letter
        self.backgroundAsset = backgroundAsset
        self.completedLetterColor = completedLetterColor
        self.onClose = onClose
        self.onAudioTap = onAudioTap
    }

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let height = proxy.size.height

            // Designed to stay huge on an ~874 × 402 landscape reference frame,
            // while still adapting to other iPhones.
            let letterSize = min(height * 0.76, width * 0.36)
            let controlSize = max(48, min(58, height * 0.14))
            let sidePadding = max(20, width * 0.035)
            let topPadding = max(14, height * 0.035)

            ZStack {
                background

                // Keep the center calm: the letter is the single primary action.
                letterLayer(size: letterSize)

                controls(
                    size: controlSize,
                    sidePadding: sidePadding,
                    topPadding: topPadding
                )
            }
            .frame(width: width, height: height)
            .clipped()
            .ignoresSafeArea()
        }
        .background(Color(hex: "#FFADAD"))
        .onAppear {
            LandscapeOrientation.request()
        }
    }

    // MARK: - Background

    private var background: some View {
        Image(backgroundAsset)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .accessibilityHidden(true)
    }

    // MARK: - Letter

    @ViewBuilder
    private func letterLayer(size: CGFloat) -> some View {
        ZStack {
            // Waiting-state letter:
            // completed color at 12–18% opacity, as defined in the design guide.
            Text(letter)
                .font(.system(size: size, weight: .black, design: .rounded))
                .foregroundStyle(completedLetterColor.opacity(0.16))
                .shadow(
                    color: .white.opacity(0.75),
                    radius: 8,
                    x: 0,
                    y: 2
                )
                .shadow(
                    color: Color.black.opacity(0.10),
                    radius: 8,
                    x: 0,
                    y: 5
                )

            // First implementation covers A.
            // The tracing engine will later provide per-letter stroke definitions.
            if letter.uppercased() == "A" {
                ATraceGuide()
                    .frame(
                        width: size * 0.72,
                        height: size * 0.86
                    )
                    .offset(y: size * 0.015)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Letter \(letter)")
        .accessibilityHint("Trace the letter")
    }

    // MARK: - Controls

    private func controls(
        size: CGFloat,
        sidePadding: CGFloat,
        topPadding: CGFloat
    ) -> some View {
        VStack {
            HStack {
                TraceControlButton(
                    systemName: "xmark",
                    size: size,
                    accessibilityLabel: "Close"
                ) {
                    onClose()
                }

                Spacer()

                TraceControlButton(
                    systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill",
                    size: size,
                    accessibilityLabel: isMuted ? "Turn sound on" : "Mute sound"
                ) {
                    isMuted.toggle()
                    onAudioTap(isMuted)
                }
            }

            Spacer()
        }
        .padding(.horizontal, sidePadding)
        .padding(.top, topPadding)
    }
}

// MARK: - A tracing guide

/// The first-screen tracing guide for A.
///
/// This intentionally shows a simple three-stroke path:
/// 1. Top → lower-left
/// 2. Top → lower-right
/// 3. Left → right crossbar
///
/// It is only the visual guide. Finger hit-testing and progressive fill
/// belong to the next implementation step.
private struct ATraceGuide: View {
    @State private var pulse = false

    var body: some View {
        GeometryReader { proxy in
            let w = proxy.size.width
            let h = proxy.size.height

            // Normalized center-line points chosen to sit inside an SF Rounded Black "A".
            let top = CGPoint(x: w * 0.50, y: h * 0.08)
            let leftBottom = CGPoint(x: w * 0.12, y: h * 0.92)
            let rightBottom = CGPoint(x: w * 0.88, y: h * 0.92)
            let crossLeft = CGPoint(x: w * 0.31, y: h * 0.62)
            let crossRight = CGPoint(x: w * 0.69, y: h * 0.62)

            ZStack {
                dottedSegment(from: top, to: leftBottom)
                dottedSegment(from: top, to: rightBottom)
                dottedSegment(from: crossLeft, to: crossRight)

                // The child gets one obvious starting cue rather than lots of text.
                Circle()
                    .fill(Color.green)
                    .frame(width: 16, height: 16)
                    .overlay {
                        Circle()
                            .stroke(.white, lineWidth: 4)
                    }
                    .shadow(color: .green.opacity(0.35), radius: 6)
                    .scaleEffect(pulse ? 1.28 : 1.0)
                    .position(top)
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 0.85)
                            .repeatForever(autoreverses: true)
                        ) {
                            pulse = true
                        }
                    }
            }
        }
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }

    private func dottedSegment(
        from start: CGPoint,
        to end: CGPoint,
        spacing: CGFloat = 19
    ) -> some View {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let distance = hypot(dx, dy)
        let count = max(2, Int(distance / spacing))

        return ZStack {
            ForEach(0...count, id: \.self) { index in
                let progress = CGFloat(index) / CGFloat(count)
                let x = start.x + dx * progress
                let y = start.y + dy * progress

                Circle()
                    .fill(Color.white.opacity(0.82))
                    .frame(width: 9, height: 9)
                    .shadow(color: .white.opacity(0.35), radius: 2)
                    .position(x: x, y: y)
            }
        }
    }
}

// MARK: - Shared control

private struct TraceControlButton: View {
    let systemName: String
    let size: CGFloat
    let accessibilityLabel: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: size * 0.38, weight: .bold))
                .foregroundStyle(Color(hex: "#4B0082"))
                .frame(width: size, height: size)
                .background(.white.opacity(0.92), in: Circle())
                .shadow(
                    color: Color.black.opacity(0.12),
                    radius: 8,
                    x: 0,
                    y: 4
                )
        }
        .buttonStyle(.plain)
        .contentShape(Circle())
        .accessibilityLabel(accessibilityLabel)
    }
}

// MARK: - Landscape orientation

@MainActor
enum LandscapeOrientation {
    static func request() {
        guard
            let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first
        else {
            return
        }

        windowScene.requestGeometryUpdate(
            .iOS(interfaceOrientations: .landscape)
        ) { error in
            print("Landscape orientation request failed: \(error.localizedDescription)")
        }
    }
}

// MARK: - Hex colors

extension Color {
    init(hex: String) {
        let value = hex
            .trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        var integer: UInt64 = 0
        Scanner(string: value).scanHexInt64(&integer)

        let r, g, b, a: UInt64

        switch value.count {
        case 3:
            (r, g, b, a) = (
                (integer >> 8) * 17,
                (integer >> 4 & 0xF) * 17,
                (integer & 0xF) * 17,
                255
            )
        case 6:
            (r, g, b, a) = (
                integer >> 16,
                integer >> 8 & 0xFF,
                integer & 0xFF,
                255
            )
        case 8:
            (r, g, b, a) = (
                integer >> 24,
                integer >> 16 & 0xFF,
                integer >> 8 & 0xFF,
                integer & 0xFF
            )
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - Preview

#Preview("A — Landscape") {
    TraceLetterView()
        .previewInterfaceOrientation(.landscapeLeft)
}
