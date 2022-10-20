---
marp: true
footer: '![image](images/launchscout-logo.png)'
style: |

  @font-face {
    font-family: "Museo Sans";
    src: url(fonts/MuseoSans_300.otf) format("otf");
    font-weight: 300;
  }

  @font-face {
    font-family: "Museo Sans";
    src: url(fonts/MuseoSans_500.otf) format("otf");
    font-weight: 500;
  }

  @font-face {
    font-family: "Museo Sans";
    src: url(fonts/MuseoSans_700.otf) format("otf");
    font-weight: 700;
  }

  @font-face {
    font-family: "Museo Sans";
    src: url(fonts/MuseoSans_900.otf) format("otf");
    font-weight: 900;
  }

  @font-face {
    font-family: "Oswald";
    src: url(fonts/Oswald-Bold.ttf) format("ttf");
    font-weight: bold;
  }

  :root {
    font-family: Museo Sans, Helvetica, Ariel, sans-serif
  }

  img {
    background-color: transparent;
  }

  section h1 {
    color: #6042BC;
    font-size: 1.9rem;
    line-height: 1.2;
  }

  section h2 {
    font-weight: 500;
  }

  section h3 {
    font-family: Oswald, Helvetica, Ariel, sans-serif;
    font-size: .9rem;
    margin: 0;
    text-transform: uppercase;
  }

  h3 ~ h1 {
    margin-top: 10px;
  }

  section code {
    background-color: #e0e0ff;
  }

  footer {
    height: 100px;
    display: flex;
      justify-content: end;
    padding: .5rem;
    position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
  }

  footer img {
    height: 100%;
  }

  section.title h5 {
    color: #9B74E8;
    margin-top: 0;
  }

  section.title footer {
    height: 220px;
    justify-content: start;
  }

  section.closing {
    text-align: center;
  }

  section.closing footer {
    justify-content: center;
    height: 200px;
    padding-bottom: 2rem;
  }

---

<!--
_class: 'title'
_footer: '![image](images/launchscout-logo_inverse.png)'
_backgroundColor: #190641
_color: white
-->
# Designing Realtime Web Apps
##### Katie Pohlman & Tim Mecklem

---

<iframe src="https://wall.sli.do/event/m8rbTQytmGvESi6kW9HjF5?section=97e4b684-b7ed-41cf-9917-b60f4a485ca2" style="height:33rem;"></iframe>

<!-- 
(Tim)

Let's start today's real-time talk with a little real-time poll. What is your primary role in software development?

Thank you for those answers. I think we have a little something for everyone today, so let's get started!

 -->

---

# Do today's web apps support real-time decisions better than the technologies <br/>they replaced?

<!-- Tim - Approx 2 minutes -->

<!--

Here's a question to ponder

Before the web, rich client apps connected to on premise databases
Green screen apps connected to mainframes
Slower hardware, but often more up to the minute information for important decisions

Web based on request from browser triggering a response is more constrained
Conditioned us to expect a static snapshot of information rather than the fluid reality

But information isn't static.
We know data in our systems changes constantly
Inventory changes, 
forum users posting, emoji reactions flying all over the place
simultaneous document editing

Some apps had to be realtime from the start due to the domain, others have been able to sidestep it.

I'd argue that we're entering a stage in web product development that users are beginning to expect relevant information to be updated as it changes, not as they request it.

The exciting news is that web technologies have advanced far enough to support seamless realtime interactions, and we've entered a new period that allows us the convenience of writing apps that reflect shift in reality with a similar effort to the days before websockets and push notifications.

Next Slide: (Tim) Our industry has a good problem.
-->

---

# We're just catching up to the <br/>capability of our tools

<!-- Tim  Approx 1 minute -->

<!--

Our industry has a good problem. 
Fully capable languages and frameworks to solve the real-time needs of our users.
What I've observed in working across business domains with large and small multidisciplinary teams alike
Struggling in the execution of applying technology to improve the experience.

Sometimes we're stuck using technologies that are less fit to deliver this different paradigm where these rich experiences are first class citizens of the technical architecture. 
Sometimes we fail to understand the needs of our users and how to support them.

I think most of our difficulties lie in the paradigm shift. 

Need new vocabulary for this kind of real-time experience, and today I'll use the phrase "conversation-capable" to describe technology that has built-in support for a constant bidirectional conversation between the information and the user.

But languages and frameworks are only a part of building real-time experiences. Other factors are more important, and they should be driving our decisions about technology.

Next slide: (Katie) Segue into the takeaway and intros
-->

---

### The takeaway
# Realtime user experiences require <br/><u>end-to-end</u> solutions.

<!--
INTROS:

Segue into the takeaway and intros

Katie

Hi! My name is Katie Pohlman and I am a Principal UX Designer at Launch Scout. Launch Scout is a custom software development agency based in Cincinnati, OH. And we build custom web applications for our clients. My role there, as a Principal UX Designer, is two fold—as a member of the Principal Group, I am helping to grow and improve our team's skillset and helping to shape and define what it means to deliver well on projects at Launch Scout. As a UX Designer, I am leading the UX and UI design and then implementing those designs with HTML and CSS. So, I am on the front-end of things, and I'll let Tim introduce himself.

Tim 

VP of Engineering and Delivery
Worked in enterprise Java, led native mobile teams, and have fallen in love with small mighty teams solving big problems with innovative technology.
20 years of experience
excited to talk about this, because we're on the cusp of something as momentous to the web industry as asynchronous json was more than a decade ago.
-->

<!--
(Katie)
Before we dig in, though, there is something that I want to call attention to. As a designer, I know that when we're talking about delivering information in real-time in a way that provides value to our users—what information to expose to them, how frequently, when should we surface it, etc—it's easy to assign that responsibility to the UI/UX designers and move on. You know, it's the designers' responsibility to research, learn, and decide what the app should do and how it should look and how it should flow. But, if there's only one thing you take away from this talk, let it be this: Building modern, trustworthy realtime web applications is not just a design concern. **[repeat that].** It's not even just a front-end concern. It's a full stack, end-to-end concern—and everyone on the team should take ownership and responsibility for it.
 -->

<!--
So, regardless of your role on your team—designer, frontend developer, or backend developer, whatever it may be—don't tune out the stuff today that seems unrelated to your work. It's not. As we'll demonstrate, we can't meet users' realtime needs without end-to-end solutions.

Next slide: (Tim) If web technologies were a step backward in...
-->

---

# The state of real-time web applications

<!-- Tim  approx 3 minutes -->
<!--

If web technologies were a step backward in building soft realtime apps, why are we using them?

Let's go back to the fundamentals of what makes the web powerful as the building blocks of our modern tools.

The web as we know it was formed around a request cycle that required the browser to initiate the conversation. 

Request some information, render a response, repeat. 

Added powerful things along the way with javascript, especially this XMLHTTPRequest thing over a decade ago that we hijacked to let us make asynchronous background JSON calls.

Improved CSS to let us build beautifully rich interactions.

Web is this ubiquitous, massive applications without independent installs

But the idea of a server pushing data down to the browser based on events triggered by something other than a request is fairly modern for the web. 
Before websockets, tricks like long-polling to mimic server push.

But the thing is that most modern web tooling, especially for backed web frameworks, assumes this basic request model is still the foundation of everything. 

Server and client technologies are still primarily concerned with routing requests and rendering pages, not with fully utilizing web sockets and other constant conversation methods.

A lot of problems exist becuase of the mismatch of the abstraction between what the web was built upon and what users need and have grown to expect.

With that in mind, let's talk about the principles through some common problems for realtime apps.

Next slide: (Katie) The first problem we want to highlight today...
 -->

---

### Problem:
# Scarce Resources

<!--

(Katie)

The first problem we want to highlight today is the problem of scarce resources. And this problem is probably most commonly seen in systems that handle inventory management, and an example of how that manifests itself is out of stock situations on ecommerce sites. So, let's look at ecommerce specifically. There is a reality for most e-commerce sites, that customers are interacting with digital representations of a physical inventory. And that means there is a constraint, or a limit, to the number of items that can actually be sold. Take event tickets as an example. There is a limit to the number of tickets that can be sold for an event because there is a physical limit to the number of people who can attend that event. And it is our job as designers and developers to make sure customers have the right information about an item at the right time to make informed decisions about that buying process. So, what state or status is the item in? Is it available for pre-order, is it available to purchase, is it out of stock? All of these things and more are questions that a customer has during the buying process.

So let's take a look at what that may look like.

Next slide: (Tim) commerce example
 -->

---

<div style="display: flex; justify-content: space-between; align-items: center;">
<h2>Example - low inventory on a commerce page</h2>
<iframe style="width: 23%; height: 3rem; border: none;" src="/commerce/inventory/scarce-scarf"></iframe>
</div>

<div style="display: flex; gap: 1rem;">
<iframe style="width:45%; height:30rem; border: 3px solid lightgray; border-radius: 10px;"
  src="/commerce/products/scarce-scarf?user_id=11&user_name=Tim"></iframe>
<iframe style="display:inline-block;float:left;width:45%; height:30rem; border: 3px solid lightgray; border-radius: 10px;"
  src="/commerce/products/scarce-scarf?user_id=12&user_name=Katie"></iframe>
</div>

<!--

*Tim, stick the the description of what you're doing, not a lot of narrative. Katie does this in hers!*

Note that there's actually a worse scenario where both succeed but there's only one product to fulfill both orders

Next slide: (Tim) Ok, so let's talk problems

 -->

---

# What are the problems here?

<!--
Tim

Ok so let's talk problems. You probably see the most obvious ones.
* We're soft-committing inventory that we don't have.
* If we don't catch it here, the customer service department has to send a difficult email that we've missed the customer's expectations and have to cancel and potentially refund the order
* The user is at a UX dead end.

Not great!

Next slide: (Katie) Those are all problems...

-->

<!--
Katie

Those are all problems, for sure, but they're tactical problems about the system or create process problems outside of the system. I want to take us a little deeper and ask you all  put on your empathy hats, and think about how this is affecting the customer's **experience**. You have two people who are both trying to buy the same thing. They both add it to their cart and one gets distracted or something comes up and they decide they'll check out later. In the meantime, the other makes a decision and the item goes out of stock. Now, the first person comes back to the page and it still looks like the item is available and then they get hit with an error, seemingly out of nowhere. The person who ended up not being able to purchase the scarf may feel a sense of betrayal or frustration. The entire time while shopping, they had no reason to believe that they should have acted faster.

Maybe they were wanting to buy that scarf as a birthday present for their grandmother. And if they had known it was the last one, they would have acted faster. Or if they had known they only had a certain amount of time to keep that item in their cart, they would have made a different decision. Now, because we didn't provide the user with accurate, realtime information, We've now created a problem for the user that they could have avoided had they had all the information when they needed it.

So, while the solution prevents a system problem of two people purchasing the same item, it actually ignores the people problem that it creates by not allowing them to make informed decisions based on accurate information.  

So what does a better solution look like?

Next slide: (Tim) demo of better solution

-->

---
<div style="display: flex; justify-content: space-between; align-items: center;">
  <h2>One potential solution</h2>
  <iframe style="width: 23%; height: 3rem; border: none;" src="/commerce/inventory/rare-raincoat"></iframe>
</div>

<div style="display: flex; gap: 1rem;">
<iframe style="width:45%; height:30rem; border: 3px solid lightgray; border-radius: 10px;"
  src="/commerce/better_products/rare-raincoat?user_id=110&user_name=Parker"></iframe>
<iframe style="width:45%; height:30rem; border: 3px solid lightgray; border-radius: 10px;"
  src="/commerce/better_products/rare-raincoat?user_id=120&user_name=Andrew"></iframe>
</div>

<!-- Tim

Drive the demo of the cart that improves the experience 

Two things to note:
1: Entire system updates to reflect inventory ups and downs
2: User with item in cart has a visual timer to let them know they are on a time limit

Next slide: (Katie) Why is this better?

-->

---
### Why is this better?
# Exposes the state of things to the user

<!--
(Katie)

Why is this better? While there is still a bit of a race condition in that someone's "Add to Cart" button is disabled when they may be moving their cursor to click it, they at least are not able to to move forward in that process under false pretenses. Think of it as two people reaching for the same item on a shelf at the store. And the other person grabs it before you can get to it. While that may be awkward or frustrating and even rude, you at least know immediately that you can't get the thing that you were reaching for, so you go look for something else.

We're mimicking reality in this situation and letting users know the information as we know it so that they are aware of what they're actually able to do in the system. And we're not allowing them to move forward in the process under false pretenses. So they know when an item is "claimed" by another customer. And that other customer knows that they have a set amount of time to decide before they no longer have "dibs" on that item. So, it's really important in these types of situations, to make sure you are exposing the state of an item to the user, so that they know what they are able to do with it.

We haven't given them a dead end

Next slide: (Katie) Alright, we've talked about systems that manage resources...

-->

---
### Problem:
# Rapid influx of data

<!--
(Katie)

Alright, we've talked about systems that manage resources and making sure that we are exposing the realtime state or status of those resources to the user. And there are other types of systems that benefit from realtime data, as well. And one of the others that we want to highlight today are systems that handle rapidly changing data—so things like social media, or a news site, or maybe a polling system, or a dashboard of some sort. There are lots of examples of these types of systems. But the problem that presents itself in these systems is that we need to decide how to display the data to the user in a way that is not overwhelming. So, you can forgo it entirely and not worry about updating in real time. Which is bad because then your users don't know if the data their seeing is accurate and could be making a bad decision based on it or are just unaware of something that is happening. Or, you can decide to display the data coming in in realtime, which then raises the question of how to do that well.

But, let's take a look first:

Next slide: (Tim) social demo
-->

---
<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 0;">
  <h2 style="padding-right: 150px; padding-bottom: 30px;">Example</h2>
  <iframe style="height: 4rem; border: none;" src="/social/rate_intensity"></iframe>
</div>

<iframe style="width: 45%; height: 50rem; border: 3px solid lightgray; border-radius: 10px;" src="/social/posts"></iframe>

<!--
(Tim)

**Stick to the literal description**

_Start out slowly with the data rate_

We have here a social media timeline of friends of this user
Four pieces of information: 
friend's username, 
content of the post (They all like Shakespeare!)
location
data science team's relevancy score

This is just a great feed of wonderful content, lots of tragedy quotes, perfect for doomscrolling

Decent rate of information, can read it and stay connected with the whereabout of that Romeo character

But what happens when the garden hose becomes a firehose?

Next slide: (Katie) What are the problems? So, that seems pretty obvious...
-->

---
# What are the problems here?

<!--

So, that seems pretty obvious, right? In this example, if you decide to just display everything as it comes in, you have to think about how that may work when the influx of data varies. What happens when the data comes in at a slower pace? At a higher pace? Or at a an insanely high pace? There is a threshold where this solution of "just show it to the user" doesn't work. And we have to make sure we identify it and address it. So, how do we do this better?

Next slide: (Tim) demonstration of potential fixes
 -->


---
<div style="display: flex; justify-content: space-between; align-items: center;">
  <h2>One potential solution</h2>
  <iframe style="height:3rem; border: none;" src="/social/rate_intensity"></iframe>
</div>

<div style="display: flex; gap: 1rem;">
  <iframe style="display:inline-block; float:left; width:45%; height:30rem; border: 3px solid lightgray; border-radius: 10px;" src="/social/posts" frameBorder="1"></iframe>
  <iframe style="display:inline-block; float:left; width:45%; height:30rem; border: 3px solid lightgray; border-radius: 10px;" src="/social/better_posts" frameBorder="1"></iframe>
</div>

<!--
(Tim)

I'll share a little secret with you. We shopped this problem around internally, and we struggled to find a really great catchall solution. 

Think about how Facebook solves this problem by curating the list dropp what the algorithm finds less "engaging".

Twitter lets you scratch that chronoligical completionist itch but you have to set aside time on your calendar to get through it all. 

Couple of options

First, we pause the feed if it exceeds more than a post eveery 4-5 seconds. 
This lets you catch up your reading and choose to load the rest.
There are plently of clever ways to do this, including infinite scrolling and paging. Our example keeps it simple with a single button to load the latest

A more interesting solution is to utilize the metadata of the posts.
Explain metadata

The second thing that we did was put some of the filtering control in the user's hands. We allow the user to filter out enything that has lower than a 90% relevancy score.

_Increase rate slider until it's moving too fast even for the relevancy filter_

As you can see, everything has limits, including our solution. Data firehose problems present an especially hard balance to strike to find what the user really needs to be able to do. 

Next slide: (Katie) Why is this better?

-->

---
### Why is this better?
# Considers the intent of the data

<!--
(Katie)

Why is this better? This is better because it considers the intent of the data. In this example, the data coming in is meant to be read. So instead of just displaying the posts as they come in and pushing everything down to where it's not readable because it is constantly moving—we're keeping everything in its place so that it can be consumed. And we're also letting you know that there is more to be seen when you are ready to see it.

So, with our empathy hats on, we're thinking about what the user is intending to do with the data. Like I said, this example shows data that is meant to be read, so we are letting that happen—we're letting the user do what they need to do with the data, while also updating the page in realtime to let them know what is happening without interrupting them. So you have to think about what your user is trying to accomplish and make sure your solution supports that. You can't just spew a bunch of data on the screen and say, "Tada, it's realtime!" Because, depending on how you do it, it can actually be a bad thing.

There are other intentions with data, as well, obviously, and those intentions should inform how you display the data to your users. So perhaps you have an email campaign that went out and you're really interested about where the campaign was most effective. You're getting data about who opened the emails, where they are, what time they opened them, etc. But it's likely not going to be helpful to see that data in a table in realtime because you can't really do anything with it without manipulating the data. What may actually be more helpful is to display that on a map and have sort of like a heat map of where emails are being opened geographically, and as they're being opened the heat map would adjust. This actually makes me think about the political maps everyone sees during an election. You could have the states gradually turning blue or red as votes are counted and you can visualize how the votes are shaping up in realtime.

All of this to say, that when you are displaying realtime data to your users, it's crucial to consider how that data is intended to be used. Because if you show them the data in realtime in a way that doesn't consider their intentions, you're actually going to cause them frustration instead of helping them.

Next slide: (Tim) But wait there's more!

 -->
 
---

# But wait, there's more!

* Seamless Session Handoff Between Devices
* Collaborative Editing/Drawing
* Handling Disconnects Gracefully
* Managing Notifications Across Multiple Connected Devices
* Integrating IoT and Other Non-web Events
* Dynamic Maps and Location Based Services
* Paging Data

<!--
(Tim or Katie?) In our experiences building real-time applications, we've run into a bunch of different problems. These range from managing how to update blockchain explorers with the latest transactions and smart contracts, handling disconnects for users bidding in web auctions, tracking vehicle position data and updating maps, and managing other IoT event data. We don't have time to talk through more examples, but we've got a bunch of experiences to share and we'd love to connect after the talk.
 -->

<!--
(Katie)
We've been talking a lot about how to best display data in realtime, and it's been heavily focused on the design/front-end side of things. And I told you this is a end-to-end responsibility. So, let's bring it full-circle.

<!-- Move the slido to the word cloud section -->

---

<iframe src="https://wall.sli.do/event/m8rbTQytmGvESi6kW9HjF5?section=97e4b684-b7ed-41cf-9917-b60f4a485ca2" style="height:33rem;"></iframe>

<!-- (Tim)

But first, a quick poll! We'll hang out here for a minute or so while you add your answers

Thank you for sharing! This is really interesting!

Next slide: (Tim) We had a lot of fun...

-->

---

# Web technologies, revisited

<!--
(Tim)

We had a lot of fun building the slides for this talk, because we chose technologies that support the end-to-end user experience as part of the framework.

Perhaps more interesting is that there isn't a single line of javascript that we wrote to support any of this real-time behavior. 

There's only one templating language for the server and client, and no duplicated logic between frontend and backend layers

Handling click events in the browser is 99% identical to handling events generated from backend actions, in the same context, with the same bidirectional conversation paradigm built into the framework.

Information over the wire is compressed and handled incredibly efficiently in DOM updates

This is powerful. Which leads me to make this case:

Next slide: (Tim) In our case...
-->

---

# The case for something different 

* Elixir, Phoenix, and LiveView
* Ruby, Rails, and Hotwire
* PHP, Laravel, and Livewire
* next.js and SSR React
* .NET and Blazor

<!--
In our case, we chose Phoenix and LiveView for this demo. There are other approximations to this technology in other stacks.

Without going into the nitty gritty details, the thing that makes LiveView stand out from even the others on this list is its foundation on an Erlang technology called OTP. OTP allows us to have thousands or even millions of tiny lightweight processes holding state and sending each other messages and events, with sophisticated lifecycle management.

Because these processes power the backend business layer as well as each individual conversation with the clients over channels and websockets, the entire system looks a bit different than the typical n-tier architecture. Instead of layer by layer calls and responses, think neurons and synapses where some of those signals travel directly to the browser of every connected user in real-time vs waiting for client-side action.

Okay, I'll end my little love note here and get back on track.

Next slide: (Tim) Can you build a...
-->

---

# Keys to the technology decision

<!--
Can you build a realtime app with more traditional front and backend technologies that are overwhelmingly popular today? Yes, of course, and to great success.

Is my favorite technology the right choice for every problem at every scale? Of course not. 

But I'm convinced after working with
enterprise stacks
frontend stacks
backend stacks
pancake stacks

Choosing a "conversation capable" solution that combines channels and websockets alongside requests and responses seamlessy is a game-changer that we haven't seen in over a decade since we discovered ajax.

Beyond the technological advances, there's something else that makes adopting something like LiveView a force multiplier.

If Conway's Law is real, which asserts that we tend to build systems and applications that mirror our organization's communication structure... 

then it means that isolated and compartmentalized teams each focusing on their own disciplines tend to create products that include these communication bottlenecks and choke points. There's nothing wrong with having different disciplines, in fact you need that for modern applications.

But if you can choose a technology and form team structures that 
value the end to end experience and 
combine the backend team's knowledge of changing information
with the frontend team's rich interactivity
and closely involve the designers of both the architecture and the user experience...

You get a cohesive application with loose coupling throughout. Not only a more maintainable system, but a better experience all around. 

Pick you a technology that enables your team to work at its best, if you are able to make that decision.

Next slide: (Tim) One final consideration

-->

---
### One Final Consideration
# The Real-time Uncanny Valley

<!--

(Tim)

Okay, let's get hypothetical for a second. You want to transition your app to a real-time experience. There's a pitfall to be aware of.

Let's call this the "Realtime uncanny valley". At some point, without careful planning you will have a app-in-transition, that sometimes feels real-time and sometimes doesn't. This can be confusing for a user. For example, how many of you have encountered this page?
-->

---

![](images/github-new-project.png)

<!--
(Tim)

Now I don't claim to be the smartest person on the planet, but I've spent more time staring at this screen than I care to admit.

You create a shiny new repository, and you craft a beautiful first commit message. You dutifully follow the instructions on the screen and you push that perfect commit up to the repo and then... you wait.

Why do you wait? If all of GitHub was one and done rendered pages, you'd know to click the refresh button. But almost all of GitHub is real-time! You submit a PR and _stuff happens_. People comment, CI builds update colors telling you how well your code performed with tests. It's lively, it's dynamic! But not this screen.

It's the uncanny valley. Everything else convinces you that you've got a realtime experience, and then you encounter this non-player character that's staring right past you.

Here's the danger of being in the realtime uncanny valley for too long. 

It erodes the user's confidence that your app is giving them the information they need when they need it.

Losing confidence means loss of trust. Loss of trust means users begin to treat your app as untrustworthy, refreshing pages that are real-time and telling people about the substandard experience. I have an app like this that I use weekly, and I'll guess that you could also come up with one like it if you thought for a minute.
-->
---

### Our advice:
# Avoid the Uncanny Valley
<!--Plan for the transition, communicate clearly to your users, and don't spend long in the uncanny real-time valley.-->

<!-- Move the slido to the feedback section -->

---

<iframe src="https://wall.sli.do/event/m8rbTQytmGvESi6kW9HjF5?section=97e4b684-b7ed-41cf-9917-b60f4a485ca2" style="height:33rem;"></iframe>

---

<!--
_class: 'closing'
_footer: '![image](images/launchscout-logo_inverse.png)'
_backgroundColor: #190641
_color: white
 -->

# Questions?
### launchscout.com


