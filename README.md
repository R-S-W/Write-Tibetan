# Write Tibetan

#### A Tibetan Keyboard App made with Dart and Flutter

Available on the [iOS](https://apps.apple.com/us/app/write-tibetan/id1615471990) and [Android](https://play.google.com/store/apps/details?id=com.RaymondWu.com.tibetan_handwriting_app_0_1&hl=en&gl=US)

Tibetan is a complex language: grammatically and phonetically, its structure is worlds apart from English . &nbsp;The written language is even more challenging: originally inspired by sanskrit from India, modern day Tibetan retains its structure and spelling from its creation 1200 years ago.&nbsp; A tibetan character can be composed of multiple stacked letters and vowels, leading to hundreds of unique forms.&nbsp; This posed a considerable problem in creating a method to input Tibetan onto a computer.&nbsp; Various tibetan input methods have been created, some mapping english words to tibetan syllables, while others construct the character component by component with a custom keyboard.&nbsp; 

Despite these efforts, there still is a disconnect for Tibetans and students in using out the language.&nbsp; The most popular method, the english to tibetan mapping, only permits users like students to type in english to write in tibetan, abstracting them from the language.&nbsp; When writing the syllable "བསྐྱིས," they remember and type the unwieldy word "bskyis" as opposed to recalling its tibetan letters. &nbsp;Likewise, Tibetans fluent in their language must write it through a clunky set of words like "brgyud" and "brnyog."

Write Tibetan is an app that allows users to write Tibetan and learn basic Tibetan characters.&nbsp; Users write by drawing characters on the screen and are given a list of different characters from the suggestion bar.&nbsp; A textbox above displays the output text that can be copied and pasted into ones notes, messages, and other apps.&nbsp; A Study Mode allows users to learn how to draw the basic Tibetan alphabet with step-by-step animations.


https://github.com/R-S-W/Write-Tibetan/assets/73966827/b93b54c4-8327-41cb-b626-f73eb715bfeb



## Table of Contents
1. [App Overview](#app-overview)
   *  Writing Mode
   *  Study Mode
2. [Suggestion Logic](#suggestion-logic)
   *  [Challenges](#challenges)
   *  [Solutions](#solutions)
   *  [Comparison Function](#comparison-function)
4. [Conclusion](#conclusion)

<br/>
<br/>

## App Overview
<br/>
### Writing Mode
Write Tibetan has a Writing and Study Mode.  The writing mode has 3 main features: the Writing Pad, the Suggestion Bar, and the Text Display.&nbsp; The App Brain behind the scenes handles the state of these three components and communicates between them.&nbsp; It also takes the user's drawing and identifies which character it is, including other possible characters that match the drawing within a certain tolerance.

The Writing Pad is built from the ground up.&nbsp; When a user touches and drags a finger across the screen, a gesture detector records its position every tenth of a second.&nbsp; Using that input data, the app paints a curve of the finger's path.&nbsp; I used bezier interpolation to create the curve using the data in order to create a smoother and less choppy path as well as to reduce the frequency of detecting touch inputs for added efficiency.&nbsp; Users can undo strokes with the Undo Button and clear the entire canvas with a long press.&nbsp; The Tseg/She Button on the right adds Tibetan punctuation directly to the Text Display.&nbsp; This custom button can be tapped or slid downwards to write, mimicking the actual way to write them down.&nbsp; The Writing Pad records each stroke and sends it to the app's main state.&nbsp;

The Suggestion Bar, controlled by the App Brain, displays different Tibetan characters based on the what the user draws.&nbsp; It updates for every stroke the user adds.  When the user selects a character from the bar, it is sent to the App Brain that displays the characters through the Text Display.

The Text Display outputs the written text.  Like a regular text box, sentences can be highlighted.  Editing control buttons allow the user to delete characters, copy the text, paste new text, and undo and redo actions.  The App Brain keeps a history of the Text Display for the undo and redo actions.  An interesting challenge arises because Tibetan characters can be composed of stacked letters of the Tibetan alphabet.  Usually, when pressing delete with most keyboards and input methods, the individual letters of the composite character are removed.  Other methods can allow new letters to be added to the original character.  This input method does not lend itself to edit characters in this way.  Deletion in this app will remove the entire character.  Thus, the number of alphabet letters for each character must be considered, since the built-in text component views each character as a combination of Tibetan characters and not a single symbol.  The App Brain contains a list of characters currently on the Text Display with a corresponding list that has the number of Tibetan letters in each character.  Deletion and addition of characters must update both lists.

<img width="450" alt="Composite character" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/9c00c904-fb54-42f9-b7a7-c9419eb0d3af">


The App Brain is an object that holds the state of the app and the three main components.  Datum like the user's strokelist, the list of suggested characters, the typed text and its history in the Text Display, and the position of the text cursor are stored in the App Brain.  This component uses this data along with custom helper classes, like a dictionary for the properly-drawn characters or Letter classes for Tibetan characters, in order to create suggestions for the user.  The process is described in the subsequent sections.  These comprise the main features of the Writing Mode of the app.  

<br/><br/><br/>

### Study Mode
The Study Mode is a simple tool for language students to learn the basic alphabet.  The full list of 34 letters and vowels is displayed.  Each letter has a page for itself including its transliterated english name and a large screen that for a step-by-step animation of the letter.  Controls at the bottom allow the user to go through the animations easily.

The animations are rendered in the app with a custom animation I made.  I used a combination of custom Flutter's basic animation packages, a custom font of Tibetan letters drawn stroke by stroke, and masking layers.  In the custom font I created, every tibetan letter has "partial letters" that is the character drawn partially without all its strokes.  

Every animated alphabet letter is a layer of images.  For example, if we are drawing the third stroke of a letter, the layers are created as such.  At the bottom is the white backround. On top of it is partial letter in black that shows the first two strokes animated before.  On top of it is Flutter's animated layer that paints a black and white image.  The final layer is a mask of another partial letter that has the third stroke, similar to a white page with a hole in the shape of the partial letter.  The final result is an animated picture.


<p align="center">
  <img width="1000" alt="study mode animation" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/8e751a38-4e57-4125-9dc6-c091aa0a80ae">
<p align="center">



<br/>
<br/>
<br/>


## Suggestion Logic
<br/>

### Challenges
How do you take what the user draws and create a list of characters that might fit it?  Various challenges arise: what happens if users draw the characters in different sizes and shapes?  How do you guess which character matches the user's drawing?  How do make sure the drawing is the correct character?  How do you compare Tibetan characters with the drawing?

The user's drawing is represented by it's position data.  Each character is made from multiple strokes.  Each stroke is a swipe across the screen, represented as a list of positions recorded multiple times a second by the app.  The user's drawing is recorded as a list of strokes, each stroke a list of position points with an X and Y value.  This is called a strokelist.

<img width="800" alt="strokelist" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/785bd509-06f6-4974-a938-d3c846103839">


In order to suggest possible characters the user may draw, we must compare the Tibetan characters with the drawing.  When we can compare them, we rank them by how well they fit the drawing. During development, each standard Tibetan character was drawn using this writing pad and recorded just like the input data, as a list of lists of positions.  This correctly drawn strokelists are used as a basis for what should represent the correctly-drawn characters.  

Comparing the user's input strokelist to the correct strokelists is a nontrivial task.  In the end, we must rank each character by suitability, thus this comparison method must output a number that represents how well or how poorly a character matches the user's drawing.  We can rank the characters from best to worst easily then.

 This comparison function could take the user's strokelist and one member of the correct strokelist, but it is difficult to compare with such dense and variable data.  Each character has a multitude of different position points, and deciding which points from both strokelists to compare is not evident.  Comparing every point in one list with every point in the other list would be a costly algorithm.  Not only that, roughly comparing all points in a strokelist doesn't reflect the nuances in the data: there would be difficulty discerning regions in the strokelist that are dense in position points.  Seeing as some Tibetan characters have many lines, curves, and shapes in a dense area, it would be a challenge in making a function that can differentiate between two dense symbols. 
 
<br/>
<br/>
<p align="center">
  <img width="650" alt="how to evaluate datapoints" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/48029d2d-7427-4cd9-8e84-edaf0915cb3f">
<p align="center">
<br/>
<br/>
<br/>

 Another problem is that characters can be written on the Writing Pad in any size, location, from taking only a fifth of the screen in the bottom left corner to occupying the entire right half of the screen.  Not only that, if someone draws a character slowly, more position points are recorded for the drawing, meaning a character can be drawn with little points or many points.  One cannot compare the data from each strokelist without processing it in some way.

<br/><br/>
<p align="center" float = "left">
  <img width="450" alt="different scale and pos" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/f8e25966-f2e7-476c-ae35-e9d0d7f584fd">
  <img width="550" alt="datapoint difference" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/a4abc507-5ec0-49ac-af1d-2920c0edd5a4">
</p>
<br/><br/><br/>


### Solutions
I use five powerful methods that simplify and fully utilize all of the information of a user's drawing:  nondimensionalizing and centering the position data, resolution reduction, counting strokes, using stroke order, and recording the path of the stroke.  To fix the problem of characters drawn in different sizes and locations on the Writing Pad, the program calculates the smallest rectangle that can fit the entire strokelist, called the smallest bounding rectangle. We partition the shape into a 3 x 3 grid of rectangles with the same aspect ratio.  These rectangles are labeled from 1 to 9.  We take each position from the stroke list and find which grid cell it belongs to.  By doing this we convert the strokelist into a simpler list of lists that have the gridnumbers instead of coordinates for position.  When we convert positions to grid cell numbers, we simplify the position coordinates that could have pairs with values ranging from 0 to the thousands and categorize them into only 9 different locations. This reduction of resolution greatly simplifies the complexity of the data.  However, its information is not lost and is still preserved by the other two methods.  This simplification allows for easier comparisons in the comparison function.  
 <br/><br/>
 <p align = "center">
   <img width="700" alt="points to 3x3" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/03d99b19-739f-4f15-b2fb-508f1088989b">
 </p>
<br/><br/><br/>

 The problem of comparing two characters of different sizes and positions is resolved with the smallest bounding rectangle and its 9 cells.  When we transform a position coordinate to a grid cell, mathematically, we move away from measuring the positions on the entire Writing Pad and instead replace them with grid numbers of regions in the smallest bounding rectangle. This is nondimensionalizing and centering the data.  Now the positions are dependent to the smallest bounding rectangle.  Two strokelists can be converted into this format and each position can be compared without worry of how it was drawn.  The comparison function needs only to consider if two strokelists each had a stroke that occupied the same grid cells and not similar position coordinates.

The next step in processing the data is to take each stroke (now a list of gridnumbers) and remove the duplicate adjacent gridnumbers (ex. the stroke 5555666333 becomes 563.)  This step simplifies the comparison process and ensures that two drawings of the same character that have varying amounts of position points in their strokelists are evaluated in the same way.  This final iteration of the data is called the pathlist, a list of 'paths,' each having a list of grid numbers.  


<p align = 'center'>
   <img width="625" alt="grid to path" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/89f5e438-aada-47fc-b76f-666f143cca48">
</p>

**_Optional addendum:_**&nbsp; the gridnumber is slightly more complex: if the stroke only hits a gridcell for only a short time (i.e. for only a small amount of datapoints,) the gridnumber is recorded, but is marked down as a stroke that was only there for a short time.  The gridnumber is recorded down as a letter from "A" to "I", where "A" equates to a cell with gridnumber "1", "B" corresponds to gridnumber "2," and so on.  It is an important distinction because it is factored in the metric function used by the comparison function.


<br/>
Nondimensionalization, centering, and resolution reduction solve issues in comparing the user's drawing and the correctly-drawn characters, but by themselves too much information is lost.  However, three other metrics, the number of strokes, stroke order, and stroke path, preserve and represent the input data effectively.  Trying to find appropriate suggestions to the user's input out of over a hundred Tibetan characters can pose a challenge.  A simple way of culling Tibetan characters unlikely to match with the user drawing is to count how many strokes the drawing has.  If some characters have too few or too many strokes, they will not be considered as possible candidates for the Suggestion Bar.  

<p align = 'center'>
  <img width="625" alt="stroke orders" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/e9a61562-5aaa-4b17-b7a9-c80e6e781994">
  <img width="500" alt="stroke path" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/148f142d-088a-4732-9626-e5f5b156640a">
</p>

One might ask when comparing pathlists which paths should be compared with which.  Pathlists are naturally ordered by stroke order, i.e. from first created stroke to last stroke.  The first path in one pathlist is compared with the first path of another, and so forth, simplifying the comparison method.  A third problem arises when we are given two strokes to compare.  How do we compare the grid numbers of both paths with each other?  The stroke's path, or the order in which it was drawn, gives us a way to pair up gridnumbers.  These paths are created in this order already, allowing easier comparisons to be made.  The strokes may have different numbers of gridnumbers, and picking which numbers to pair is handled by the comparison function.


These five methods order the data into meaningful metrics and give us an appropriate framework to compare user drawings with correctly-drawn characters.  


<br/><br/><br/>






### Comparison Function


The character recognition program that generates the suggestions takes all of the Tibetan characters, selects some of them and sorts them to find the characters that are closest to the user's drawing.  First, the list of characters are filtered by the number of their strokes; only ones with the same number of strokes of the user's drawing are compared.  The list is sorted with the comparison function that evaluates the differences between the drawing and one candidate character.  The function calculates difference ratings, stroke difference ratings, and distances to quantify the character's differences.


The comparison function takes two pathlists and returns the difference rating.  This nonnegative number is a measure for how different the character and drawing are.  The list of candidate characters are ordered from smallest to largest difference rating.  The difference of the characters is dependent on the differences between all the strokes of the characters.  In the same way, the difference rating is the sum the stroke difference ratings.  The strokes of each character are paired up by the order they were drawn and their stroke difference rating is calculated.

The stroke difference rating is a measure of the differences between two strokes.  The difference between two strokes is based on the differences between the gridnumbers of the strokes.  Thus the stroke difference rating is the sum of the "distances" between gridnumbers.  These distances are based on the positions the gridnumbers originally label.  We define how we choose which gridnumbers will be paired to make distances below.

In calculating the stroke difference rating, we pair gridnumbers in a specific way: the function shifts the lists of gridnumbers and pairs the elements so that the greatest amount of like grid numbers match up.  

<p align = 'center'>
  <img width="423" alt="comparison func 1" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/b62af09f-3721-4ac2-9b18-f72df8b21f2a">
</p>

The function then removes the matching numbers and splits the two paths into four  Matching numbers have no differences, so they do not contribute to the stroke difference rating and are removed.  The function then recurses and runs the same process for every pair of paths.  The recursion ends when there are no matching numbers in a path pair.  The result of this process is a list of pairs reduced to only the differences between their original paths.  Each element of a pair is a segment of its path.  For every pair, we quantify the difference between these path segments with another method called a metric function.  

The gridnumbers represent positions on the 3x3 grid, and the metric function simply calculates the distance between the centers of two cells on the grid.  A complication in the program is when two path segments have different amounts of gridnumbers.  In this case, the function calculates an average: it takes all combinations of gridnumber pairs by choosing one point from each segment, finds their difference, and takes the average of all of them.  


**_Optional addendum:_**&nbsp; The comparison function handles paths with letter gridnumbers (ex. 412**C**5**F**9) differently when calculating the difference rating.  If a pair of path segments do not match and have a letter gridnumber, its resultant distance from the metric function is weighted.  If a gridnumber pair lie on the same cell (like the pair 1 and A) then its distance is multiplied by two.  If the pair lie on different cells (like the numbers 2 and C) then the distance is multiplied by 3.  In this way more disparate gridnumbers contribute more to the stroke difference rating.

</br>



The distances of all path segment pairs are computed and sum up to the stroke difference rating for a pair of strokes.  Every pair of strokes in the compared characters have their stroke difference rating calculated that sum up to the final difference rating.  The list of candidate characters are sorted from smallest to largest difference rating, and this list is sent to the Suggestion Bar.

<img width="950" alt="difference rating" src="https://github.com/R-S-W/Write-Tibetan/assets/73966827/17865676-8de1-4449-b6d3-93efd5097e03">


The use of simplifying the original position data of the strokelists are essential in maintaining an efficient, fast, and smooth application.  Without simplification, the comparison function would have to take the original drawing and compare it with a scores of possible candidate characters. Both characters would range on average in having 50 to 100 position points.  Pairing each datapoint with this data would not necessarily be a linear operation.  To add onto this, this process of comparing dozens of characters occurs with every stroke the user creates.  It is essential that The character recognition program simplifies the original data into the gridnumber and pathlists to ensure efficiency.
<br/><br/>

## Conclusion

Write Tibetan has helped thousands of language students pick up the pen and learn a written language that continues to carry on and represent the history and culture of Tibet for over a millennia.  Tibetans and other ethnic groups struggle to preserve their identity, heritage, and language as the world modernizes and their mother tongue is used less and less often.  In a world dominated by smartphones and tablets, Write Tibetan and its character recognition software can help connect people to a language more than any keyboard ever could.


