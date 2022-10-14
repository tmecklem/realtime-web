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

---

<!--
_class: 'title'
_footer: '![image](images/launchscout-logo_inverse.png)'
_backgroundColor: #190641
_color: white
-->
# Designing Realtime Web Apps
##### Katie Pohlman & Tim Mecklem

<!-- Test for presenter notes -->

---

# Do today's web apps support real-time decisions better than the technologies they replaced?

<!--

Tim

If you look back to pre-web days, many applications were rich client desktop apps that connected to internal servers, or a little further back there were dumb terminals that connected to a mainframe. The apps that ran on these platforms did not have the benefit of running on incredibly fast hardware or utilizing Internet speeds that are 10x of the old internal ethernet networks, but they were often more real-time than the typical web application. The move to web applications and the internet opened up a ton of new possibilities, but it also introduced new constraints, such as the request/response nature of HTTP. We became conditioned to see a snapshot of reality rather than a fluid picture.

But that doesn't mean that information behind the scenes remained static. In fact, nearly every modern web application is built on a mountain of changes that happen constantly. Inventory changes, database records backing tables of paged data shift as timestamps are updated and fields are modified. Fulfillment centers take orders and physically assemble them, changing the status as they go. Forum users post new comments, people add emoji reactions to friend's posts, and people engage in and are outbid in web auctions. Some apps handle this rapid change well because the business depends on it. Some ignore it. I'd argue that people's expectations are rising up, and a day is coming when web app developers will no longer be able to present static snapshots of realtim information and expect people to be satisfied.

The exciting news is that web technologies have advanced far enough to support seamless realtime interactions, and we've entered a new period that allows us the convenience of writing apps that reflect shift in reality without having to work much harder than we did before the advent of websockets and push notifications.

-->

---

# But we're just catching up to the capability of our tools 

<!--

Tim

Our industry has a good problem. Our languages, frameworks and tooling are more capable than they have ever been at giving people up to the second information. Used appropriately, we can use them to help people make better decisions, ease the experience of buying products, and improve interactions with other people. But as a whole, we've observed that teams are struggling in the execution of applying the former to improve the latter.

Sometimes we fail to understand the needs of our users and how to support them. Sometimes our tools are too complicated and new paradigms are needed. And sometimes we're stuck using older technologies that make it unnecessarily hard to deliver these rich experiences. Today, we will present some example problem scenarios along with an example solution, and along the way we'll address some basic principles and technologies that support better reailtime experiences.

-->

---

# The Takeaway

Katie

<!--
When we're talking about delivering information to users in real-time in a way that provides value to them—what information to expose when, how frequently, etc—it's easy to assign that responsibility to the UI/UX designers and move on. But, if there's only one thing you take away from this talk, let it be this. Building modern, trustworthy realtime web applications is not just a design concern. It's not even just a front-end concern. The problems we will describe might feel daunting, but we'll give you some tools and some things to consider when you encounter them.
 -->

<!--
One note: if you are a backend developer listening to this talk, don't tune out to the stuff that seems unrelated to your work. It's not. As we'll demonstrate, we can't meet users' realtime needs without end-to-end solutions.
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

# Problem 1 - Scarce Resources

Katie

Talk about the realtime implications of people trying to consume or purchase the same experience or physical products. Inventory management and out of stock situations.

Capacity constraints

Maybe the Seinfeld car parking scene?

---

# Example - low inventory on a commerce page

<iframe style="display:inline-block;float:left;width:33%;height:600px;"
  src="/commerce/products/scarce-scarf?user_id=11&user_name=Tim" frameBorder="1"></iframe>
<iframe style="display:inline-block;float:left;width:33%;height:600px;"
  src="/commerce/products/scarce-scarf?user_id=12&user_name=Katie" frameBorder="1"></iframe>

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

# What are the problems here

<!--
Ok so let's talk problems. You probably see the most obvious ones. There's a frustrated customer who won't be getting an item. There may be a fulfillment center customer service rep that has to call a customer to let them know that they in fact will not be receiving the order they placed (or sometimes an unceremonious email candeling the order). We've left a user at a UX dead end cart. They can't place the order for the thing in their cart, and we've given them an error that is technically accurate but they have no easy recourse. They can't do anything useful with the information except make a big ole pot of stew.
-->

<!--
Katie 

But let's look beyond the surface problems

**talk about empathy with the user and their goals and needs**

-->

---

# One potential solution

<iframe style="display:inline-block;float:left;width:33%;height:800px;"
  src="/commerce/better_products/rare-raincoat?user_id=110&user_name=Parker" frameBorder="1"></iframe>
<iframe style="display:inline-block;float:left;width:33%;height:800px;"
  src="/commerce/better_products/rare-raincoat?user_id=120&user_name=Andrew" frameBorder="1"></iframe>

Tim

Drive the demo of the cart that improves the experience

---
# Principles

Katie

Talk about how the solution improves the UX and why

---

Tell me if you can relate to any of these problems.

<!--

How many of you have been in the middle of reading a post or an article on the internet in a feed and had some late breaking new information come in and push down the content you were reading?

You're on an ecommerce site, you find an item that you want to buy that's in high demand, and in between the time you add it to your cart and go to checkout, the item has gone out of stock.

-->

---

![](images/github-new-project.png)

<!--

(Tim)

How many of you have made a shiny new project, created a repository for it on GitHub, pushed your code, and then stared blankly at this screen waiting for it to pick up your amazing code only to realize that unlike the rest of GitHub, this page does is not driven by the `git push` command you just ran. Maybe this one's just me, and I'll take an L on that one if so :D.

How about one final developer-centric one. How many of you have used a tool that has a hot-reload feature that supposed to update the browser when you save a file, only it's a Monday and for some reason the file watcher seems to be taking the day off?

-->

