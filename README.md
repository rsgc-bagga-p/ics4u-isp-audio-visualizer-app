# Grade 12 Computer Science ISP

Overall expectations being assessed in this independent study project:

* A1. 	demonstrate the ability to use different data types and expressions when creating computer programs;
* A2. 	describe and use modular programming concepts and principles in the creation of computer programs;
* A4. 	use proper code maintenance techniques when creating computer programs.
* B1. 	demonstrate the ability to manage the software development process effectively, through all of its stages – planning, development ... and closing;
* B2. 	apply standard project management techniques in the context of a student-managed ... project.
* C1. 	demonstrate the ability to apply modular design concepts in computer programs;

In all phases of this ISP, you will be guided by an exemplar produced by Mr. Gordon.

The emphasis in this ISP is on understanding and applying the process of software development. The greatest success has historically come to students who plan their deliverables according to a manageeable schedule and stick to their plan.

## Scope

Aim to create a modest application that solves a problem you care about. If you solve the problem well, it is highly likely that others will find your application useful as well. Challenge yourself with something new, but avoid overreaching.

## Due dates

Planning, development, and closing will occur by the start of March Break. You can set due dates for deliverables in your project. You are strongly recommended to plan deliverable dates by working around due dates for deliverables in your other classes.

Note that you will be granted significant opportunities to work in class, but that there is, like any Grade 12 university preparation course, an expectation that work be completed outside of class time as well.

## Proposal

Modify this document and add your responses to the following prompts below.

### What problem will your application solve?

*Write a paragraph to describe the utility of your application. This applies equally for games. When would someone use your application? Why would they use your application?*

My application is an audio visualizer. It takes frequencies and displays this in many cool patterns which can be cast onto large displays. This application would be used by most people but my target group are young adults and teenagers. This application could be used in most situations mainly for parties when music is playing or when DJs play music for their shows. This could also be generally used by anyone listening to music. They would use my applications because it would provide beautiful patterns and images that would appeal to many people. This application would be an improvement versus many applications on the market that used generalized and not very appealing (not anymore at least) sinusoidal waves instead of interesting and new images created by different mathematical patterns. 

### What is your inspiration for this project?

*Have you seen another application that you wish to improve on? Has someone asked you to create this?*

In previous years I saw students in Mr. D'Arcy's software class program Mandelbrot and Julia fractal sets. I have wanted to program one of those sets since then and learn about the math behind it. Furthermore, I have wanted to create a professional audio visualizer that acurately analyzes music and displays in such patterns; making it an improvement to the applications already available on the market. Furthermore, this application is also inspired by my time building a similar product I am doing for Engineering Club in which I am solving a similar problem of synchronizing audio with a display but my solution for that problem is more hardware related. 

### What is your prior experience in this area?

*Have you written an application like this before? Have you made use of any required APIs before?*

A similar application I wrote was with processing in grade 10 software. I used processing to analyze song files and display the frequencies as a part of a sine wave (the frequencies matched the amplitudes of the wave). I have not designed a product like this using swift but I have tried using particle lab and AudioKit in a similar project where sound is analyzed and displayed with interesting patterns. 

### What are skills do you hope to acquire by completing this project?

*For example, you might be writing a networked application for the first time. Or, you may be writing an application that requires a particularly well designed user interface. Describe what you expect to learn by writing this application.*

With this project I expect to learn more about using audio analysis APIs, designing appealing user interfaces and creating mathematical patterns such as fractals to display my data. I will also gain knowledge about creating visually appealing live animations. I expect to become more comfortable and familiar with such skills after this project.

### What dependencies, if any, will be required to complete your project?

*If you are writing a networked application, you might be using an API like Alamofire to simplify that part of the implementation. If you are writing an application that communicates over Bluetooth, you may be using the Core Bluetooth framework. Please list any expected dependencies for your project.*

I will probably be using the standard MacOS APIs, AudioKit and a graphics API such as Metal or Sprite Kit to analyze my music and display it visually.

### Rate the personal difficulty level of this project.

This project will be very tough because this is the first time I will be working with AudioKit, Metal/Sprite Kit and programming fractal patterns (which I have heard are pretty difficult) in Swift. The logic and data display will be the most challenging part of this project because I am least familiar with the mathematical algorithims needed for this project. I will also be using APIs that I have not used before so it will be fairly challenging to complete this project.

### Identify what you think your biggest challenge for successfully completing this ISP will be.

My biggest challenge in completing this ISP will be to manage my time. I have many extra curricular activities and projects in this week that I will need to manage my time effectively to complete this project. I will be able to do this by completing time based goals set by myself. By doing this I can get my project completed without stressing or completing it the night before. 


### Make storyboards to indicate the user interface and/or functionality of your application.

*In the section below, sketch out a plan for your application. This is where you will spend the majority of your time in completing the ISP proposal. Think through what you hope to create and as needed, adjust your responses to the questions above.*

 1. When the app is first launched the it will ask the user if they want to analyze the music live through the microphone or through their music library (pre-chosen songs).
 
 ![Initial Screen](https://github.com/rsgc-bagga-p/ics4u-isp-audio-visualizer-app/blob/master/Audio%20Visualizer/SoftwareISPPhoto1.jpeg?raw=true)

 2. If Library option is chosen
 
 ![Library Option](https://github.com/rsgc-bagga-p/ics4u-isp-audio-visualizer-app/blob/master/Audio%20Visualizer/SoftwareISPLibrary.jpg?raw=true)
 
 3. Future functionality would be adding a drag and drop feature if possible
 
 ![Drag and Drop](https://github.com/rsgc-bagga-p/ics4u-isp-audio-visualizer-app/blob/master/Audio%20Visualizer/SoftwareISPDragandDrop.jpg?raw=true)
 
 4. Then it would ask if they want to use the Mandelbrot or Julia (maybe another pattern set) to display the audio analysis with. 
 
 ![Mandelbrot or Julia](https://github.com/rsgc-bagga-p/ics4u-isp-audio-visualizer-app/blob/5edeedc892f5b1c2edb6a4ed576a42952235ce4d/Audio%20Visualizer/SoftwareISPPhoto2.jpeg?raw=true)

 5. The program would then, depending on the user's choices display the audio analysis using different patterns and such. The frequencies would affect the colours and the zoom speed would be affected by the amplitude. Furthermore, there are things I do not know about these sets and I could possibly affect other parts of the set with these audio analysis values.
 
 a) Mandelbrot
 
 ![Mandelbrot](https://github.com/rsgc-bagga-p/ics4u-isp-audio-visualizer-app/blob/5edeedc892f5b1c2edb6a4ed576a42952235ce4d/Audio%20Visualizer/SoftwareISPMandelbrot.jpeg?raw=true)
 
 b) Julia
 
 ![Julia](https://github.com/rsgc-bagga-p/ics4u-isp-audio-visualizer-app/blob/5edeedc892f5b1c2edb6a4ed576a42952235ce4d/Audio%20Visualizer/SoftwareISPJulia.jpeg?raw=true)

