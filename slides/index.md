---
marp: true
footer: '![image](images/launchscout-logo.png)'
style: |

  :root {
    font-family: Helvetica, Ariel, sans-serif
  }

  img {
    background-color: transparent;
  }

  section h1 {
    color: #6042BC;
  }

  section h3 {
    font-size: 1rem;
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

<!--
INTROS:

Katie

Hi! My name is Katie Pohlman and I am a Principal UX Designer at Launch Scout. Launch Scout is a custom software development agency based in Cincinnati, OH. And  
 -->

---

# Do today's web apps support real-time decisions better than the technologies they replaced?

<!--

Tim

If you look back to pre-web days, many applications were rich client desktop apps that connected to internal servers, or a little further back there were dumb terminals that connected to a mainframe. The apps that ran on these platforms did not have the benefit of running on incredibly fast hardware or utilizing Internet speeds that are 10x of the old internal ethernet networks, but they were often more real-time than the typical web application. The move to web applications and the internet opened up a ton of new possibilities, but it also introduced new constraints, such as the request/response nature of HTTP. We became conditioned to see a snapshot of reality rather than a fluid picture.

But that doesn't mean that information behind the scenes remained static. In fact, nearly every modern web application is built on a mountain of changes that happen constantly. Inventory changes, database records backing tables of paged data shift as timestamps are updated and fields are modified. Fulfillment centers take orders and physically assemble them, changing the status as they go. Forum users post new comments, people add emoji reactions to friend's posts, and people engage in and are outbid in web auctions. Some apps handle this rapid change well because the business depends on it. Some ignore it. I'd argue that people's expectations are rising up, and a day is coming when web app developers will no longer be able to present static snapshots of realtime information and expect people to be satisfied.

The exciting news is that web technologies have advanced far enough to support seamless realtime interactions, and we've entered a new period that allows us the convenience of writing apps that reflect shift in reality without having to work much harder than we did before the advent of websockets and push notifications.

-->

---

# But we're just catching up to the capability of our tools

<!--

Tim

Our industry has a good problem. Our languages, frameworks and tooling are more capable than they have ever been at giving people up to the second information. Used appropriately, we can use them to help people make better decisions, ease the experience of buying products, and improve interactions with other people. But as a whole, we've observed that teams are struggling in the execution of applying the former to improve the latter.

Sometimes we fail to understand the needs of our users and how to support them. Sometimes our tools are too complicated and new paradigms are needed. And sometimes we're stuck using older technologies that make it unnecessarily hard to deliver these rich experiences. Today, we will present some example problem scenarios along with an example solution, and along the way we'll address some basic principles and technologies that support better realtime experiences.

-->

---

### The takeaway
# Realtime user experiences require <u>end-to-end</u> solutions.

<!--
(Katie)
Before we dig in, though, there is something that I want to call attention to. As a designer, I know that when we're talking about delivering information in real-time in a way that provides value to our users—what information to expose to them, how frequently, when should we surface it, etc—it's easy to assign that responsibility to the UI/UX designers and move on. You know, it's the designers' responsibility to research, learn, and decide what the app should do and how it should look and how it should flow. But, if there's only one thing you take away from this talk, let it be this: Building modern, trustworthy realtime web applications is not just a design concern. **[repeat that].** It's not even just a front-end concern. It's a full stack, end-to-end concern—and everyone on the team should take ownership and responsibility for it.
 -->

<!--
So, regardless of your role on your team—designer, frontend developer, or backend developer, whatever it may be—don't tune out the stuff today that seems unrelated to your work. It's not. As we'll demonstrate, we can't meet users' realtime needs without end-to-end solutions.
-->

---

# How did we get here?

<!--

Tim

The web as we know it was formed around a request/response HTTP cycle that required the browser to initiate the conversation. Request some information, get a response, render, repeat. We added some powerful things along the way with javascript, XMLHTTPRequest (window.fetch and all the other ways to fetch data asynchronously), and great advancements in CSS and client side frameworks. But the idea of a server pushing data down to the browser based on events triggered by something other than a request is fairly modern. Before websockets, there were tricks like long-polling where a browser opened a request to a server and the server keeps the request open until there's data to send back, hooked up in a loop to keep the conversation bi-directional.

But in the earlier days, say back in the earlier 2000s, it was common to build the entire system around the request cycle and snapshots. We relied so much on these crisply rendered one-off pages that we built entire models on them that break down when the reality of constant change is introduced. Just look at paging for example. Most paging is still based around a query that utilizes a page size and offset. But when new records come in that interleave the existing records, the illusion of a snapshot of the paged data breaks down. Some records repeat across pages. Some data disappears because the offset shifted. I won't specifically discuss the solution to stale paging in this talk, but if you are struggling with that problem come talk and I'll give you a couple of good options to try.

So this talk is a little bit tactical and little bit strategic. It's built on pragmatism with a little philosophy baked in.

With that in mind, let's talk about the principles through some common problems for realtime apps.
 -->

---

### Problem:
# Scarce Resources

<!--

(Katie)

The first problem we want to highlight today is the problem of scarce resources. And this problem is probably most commonly seen in systems that handle inventory management, such as out of stock situations. There is a reality for most e-commerce sites, that customers are interacting with digital representations of a physical inventory. And that means there is a constraint, or a limit, to the number of items that can actually be sold. Take event tickets as an example. There is a limit to the number of tickets that can be sold for an event because there is a physical limit to the number of people who can attend that event. And it is our job as designers and developers to make sure customers have the right information about an item at the right time to make informed decisions about that buying process. So, what state or status is the item in? Is it available for pre-order, is it available to purchase, is it out of stock? All of these things and more are questions that a customer has during the buying process.

So let's take a look at what that may look like.
 -->

---

## Example - low inventory on a commerce page

<div style="display: flex; gap: 1rem;">
<iframe style="width:45%; height:30rem;"
  src="/commerce/products/scarce-scarf?user_id=11&user_name=Tim" frameBorder="1"></iframe>
<iframe style="display:inline-block;float:left;width:45%; height:30rem;"
  src="/commerce/products/scarce-scarf?user_id=12&user_name=Katie" frameBorder="1"></iframe>
</div>

<!--
Tim

Perhaps this is a good time to let you know that we're going to demonstrate the problems and solutions using an actual running webapp embedded in the slides. We spent quite a bit of time bending the markdown slide tool and the web app to our collective will, but there's always a risk that we messed up the tribute to the demo gods this morning. If that happens, things just get a little more... entertaining.

T**Talk through the scenario of two people visiting the same product pages in different sessions**
1) Add the product to cart A
2) Add the product to cart B
3) Checkout out from cart B
4) Attempt checkout from cart A, see error

Note that there's actually a worse scenario where both succeed but there's only one product to fulfill both orders

 -->

---

# What are the problems here?

<!--
Tim

Ok so let's talk problems. You probably see the most obvious ones. There's a frustrated customer who won't be getting an item. There may be a fulfillment center customer service rep that has to call a customer to let them know that they in fact will not be receiving the order they placed (or sometimes an unceremonious email canceling the order). We've left a user at a UX dead end cart. They can't place the order for the thing in their cart, and we've given them an error that is technically accurate but they have no easy recourse. They can't do anything useful with the information except make a big ole pot of stew.
-->

<!--
Katie

Those are all problems, for sure, but they're tactical problems about the system or create process problems outside of the system. I want to take us a little deeper and ask you all  put on your empathy hats, and think about how this is affecting the customer's **experience**. You have two people who are both trying to buy the same thing. They both add it to their cart and one gets distracted or something comes up and they decide they'll check out later. In the meantime, the other makes a decision and the item goes out of stock. Now, the first person comes back to the page and it still looks like the item is available and then they get hit with an error, seemingly out of nowhere. The person who ended up not being able to purchase the scarf may feel a sense of betrayal or frustration. The entire time while shopping, they had no reason to believe that they should have acted faster.

Maybe they were wanting to buy that scarf as a birthday present for their grandmother. And if they had known it was the last one, they would have acted faster. Or if they had known they only had a certain amount of time to keep that item in their cart, they would have made a different decision. Now, because we didn't provide the user with accurate, realtime information, We've now created a problem for the user that they could have avoided had they had all the information when they needed it.

So, while the solution prevents a system problem of two people purchasing the same item, it actually ignores the people problem that it creates by not allowing them to make informed decisions based on accurate information.  

So what does a better solution look like?

-->

---

# One potential solution

<div style="display: flex; gap: 1rem;">
<iframe style="width:45%; height:30rem;"
  src="/commerce/better_products/rare-raincoat?user_id=110&user_name=Parker" frameBorder="1"></iframe>
<iframe style="width:45%; height:30rem;"
  src="/commerce/better_products/rare-raincoat?user_id=120&user_name=Andrew" frameBorder="1"></iframe>
</div>

<!-- Tim

Drive the demo of the cart that improves the experience -->

---
### Why is this better?
# Exposes the state of things to the user

<!--
(Katie)

Why is this better? While there is still a bit of a race condition in that someone's "Add to Cart" button is disabled when they may be moving their cursor to click it, they at least are not able to to move forward in that process under false pretenses. Think of it as two people reaching for the same item on a shelf at the store. And the other person grabs it before you can get to it. While that may be awkward or frustrating and even rude, you at least know immediately that you can't get the thing that you were reaching for, so you go look for something else.

We're mimicking reality in this situation and letting users know the information as we know it so that they are aware of what they're actually able to do in the system. And we're not allowing them to move forward in the process under false pretenses. So they know when an item is "claimed" by another customer. And that other customer knows that they have a set amount of time to decide before they no longer have "dibs" on that item. So, it's really important in these types of situations, to make sure you are exposing the state of an item to the user, so that they know what they are able to do with it.

-->

---
### Problem:
# Rapid influx of data

<!--
(Katie)

Alright, we've talked about systems that manage resources and making sure that we are exposing the realtime state or status of those resources to the user. And there are other types of systems that benefit from realtime data, as well. And one of the others that we want to highlight today are systems that handle rapidly changing data—so things like social media, or a news site, or maybe a polling system, or a dashboard of some sort. There are lots of examples of these types of systems. But the problem that presents itself in these systems is that we need to decide how to display the data to the user in a way that is not overwhelming. So, you can forgo it entirely and not worry about updating in real time. Which is bad because then your users don't know if the data their seeing is accurate and could be making a bad decision based on it or are just unaware of something that is happening. Or, you can decide to display the data coming in in realtime, which then raises the question of how to do that well.

But, let's take a look first:
 -->

---
# Example -
Tim - Social media/twitter feed that is moving too fast?

---
# What are the problems here?

<!--
So, that seems pretty obvious, right? In this example, if you decide to just display everything as it comes in, you have to think about how that may work when the influx of data varies. What happens when the data comes in at a slower pace? At a higher pace? Or at a an insanely high pace? There is a threshold where this solution of "just show it to the user" doesn't work. And we have to make sure we identify it and address it. So, how do we do this better?
 -->


---
# One potential solution
Tim - Shows a counter of new messages with the option to display them

---
### Why is this better?
# Considers the intent of the data

<!--
(Katie)

Why is this better? This is better because it considers the intent of the data. In this example, the data coming in is meant to be read. So instead of just displaying the posts as they come in and pushing everything down to where it's not readable because it is constantly moving—we're keeping everything in its place so that it can be consumed. And we're also letting you know that there is more to be seen when you are ready to see it.

So, with our empathy hats on, we're thinking about what the user is intending to do with the data. Like I said, this example shows data that is meant to be read, so we are letting that happen—we're letting the user do what they need to do with the data, while also updating the page in realtime to let them know what is happening without interrupting them. So you have to think about what your user is trying to accomplish and make sure your solution supports that. You can't just spew a bunch of data on the screen and say, "Tada, it's realtime!" Because, depending on how you do it, it can actually be a bad thing.

There are other intentions with data, as well, obviously, and those intentions should inform how you display the data to your users. So perhaps you have an email campaign that went out and you're really interested about where the campaign was most effective. You're getting data about who opened the emails, where they are, what time they opened them, etc. But it's likely not going to be helpful to see that data in a table in realtime because you can't really do anything with it without manipulating the data. What may actually be more helpful is to display that on a map and have sort of like a heat map of where emails are being opened geographically, and as they're being opened the heat map would adjust. This actually makes me think about the political maps everyone sees during an election. You could have the states gradually turning blue or red as votes are counted and you can visualize how the votes are shaping up in realtime.

All of this to say, that when you are displaying realtime data to your users, it's crucial to consider how that data is intended to be used. Because if you show them the data in realtime in a way that doesn't consider their intentions, you're actually going to cause them frustration instead of helping them.

We've been talking a lot about how to best display data in realtime, and it's been heavily focused on the design/front-end side of things. And I told you this is a end-to-end responsibility. So, let's bring it full-circle.
 -->

---
# Tie all together with the backend stuff
Tim

---
### Something to keep in mind
# Disconnections and partial realtime
Tim

<!-- If you decide to tackle this, there will be a transition period where you have some 'dead' views and some realtime views—make it obvious which is which. Talk about Github page-->

---

![](images/github-new-project.png)

<!--

(Tim)

How many of you have made a shiny new project, created a repository for it on GitHub, pushed your code, and then stared blankly at this screen waiting for it to pick up your amazing code only to realize that unlike the rest of GitHub, this page does is not driven by the `git push` command you just ran. Maybe this one's just me, and I'll take an L on that one if so :D.

How about one final developer-centric one. How many of you have used a tool that has a hot-reload feature that supposed to update the browser when you save a file, only it's a Monday and for some reason the file watcher seems to be taking the day off?

-->

---
<!--
_class: 'closing'
_footer: '![image](images/launchscout-logo_inverse.png)'
_backgroundColor: #190641
_color: white
 -->
# Questions?
### launchscout.com



---

Tell me if you can relate to any of these problems.

<!--

How many of you have been in the middle of reading a post or an article on the internet in a feed and had some late breaking new information come in and push down the content you were reading?

You're on an ecommerce site, you find an item that you want to buy that's in high demand, and in between the time you add it to your cart and go to checkout, the item has gone out of stock.

-->
