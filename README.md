# Write Tibetan

### A Tibetan Keyboard App made with Dart and Flutter

Available on the [iOS](https://apps.apple.com/us/app/write-tibetan/id1615471990) and [Android](https://play.google.com/store/apps/details?id=com.RaymondWu.com.tibetan_handwriting_app_0_1&hl=en&gl=US)

Tibetan is a complex language: grammatically and phonetically, it is completely distinct from English. &nbsp;The written language is even more challenging. &nbsp;Originally inspired by sanskrit from India, modern day Tibetan retains its structure and spelling from its creation 1200 years ago.&nbsp; A tibetan character can be composed of multiple stacked letters and vowels, leading to hundreds of unique forms.&nbsp; This posed a considerable problem in creating a method to input Tibetan onto a computer.&nbsp; Various tibetan input methods have been created, some mapping english words to tibetan syllables, while others construct the character component by component with a custom keyboard.&nbsp; 

Despite these efforts, there still is a disconnect for Tibetans and students in using out the language.&nbsp; The most popular method, the english to tibetan mapping, only permits users like students to type in english to write in tibetan, abstracting them from the language.&nbsp; When writing the syllable "བསྐྱིས," they remember and type the unwieldy word "bskyis" as opposed to recalling its tibetan letters. &nbsp;Likewise, Tibetans fluent in their language must write it through a clunky set of words like "brgyud" and "brnyog."

Write Tibetan is an app that allows users to write Tibetan and learn basic Tibetan characters.&nbsp; Users write by drawing characters on the screen and are given a list of different characters from the suggestion bar.&nbsp; A textbox above displays the output text that can be copied and pasted into ones notes, messages, and other apps.&nbsp;


https://github.com/R-S-W/Write-Tibetan/assets/73966827/b93b54c4-8327-41cb-b626-f73eb715bfeb






## Making the App

The writing mode has 3 main features: the Writing Pad, the Suggestion Bar, and the Text Display.&nbsp; The App Brain behind the scenes handles the state of these three components and communicates between them.&nbsp; It also takes the user's drawing and identifies which character it is, including other possible characters that match the drawing within a certain tolerance.

The Writing Pad is built from the ground up.&nbsp; When a user touches and drags a finger across the screen, a gesture detector records its position every tenth of a second.&nbsp; Using that input data, the app paints a curve of the finger's path.&nbsp; I used bezier interpolation to create the curve using the data in order to create a smoother and less choppy path as well as to reduce the frequency of detecting touch inputs for added efficiency.&nbsp; Users can undo strokes with the Undo Button and clear the entire canvas with a long press.&nbsp; The Tseg/She Button on the right adds Tibetan punctuation directly to the Text Display.&nbsp; This custom button can be tapped or slid downwards to write, mimicking the actual way to write them down.&nbsp; The Writing Pad records each stroke and sends it to the app's main state.&nbsp;

The Suggestion Bar 





Small curves and taps to the writing pad are not recorded to ensure the program does not miscount the number of strokes and misclassify the input drawing.




to create an app that allows users to practice handwriting in Tibetan.

I created a handwriting recognition software that predicts and suggests characters as the user writes.

The software accounts for the complex, stacked composite characters and vowels unique to written Tibetan.

## A



- b

