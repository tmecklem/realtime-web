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

# The Problem

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

---

# Realtime web apps can be amazing

<!--

Our industry has a good problem. Our languages, frameworks and tooling are more capable than they have ever been at giving people up to the second information. Used appropriately, we can use them to help people make better decisions, ease the experience of buying products, and improve interactions with other people. But as a whole, we've observed that teams are struggling in the execution of applying the former to improve the latter.

-->

---

# The One Thing

<!--

(Katie)

When we're talking about delivering information to users in real-time in a way that provides value to them—what information to expose when, how frequently, etc—it's easy to assign that responsibility to the UI/UX designers and move on. But, if there's only one thing you take away from this talk, let it be this. Building modern, trustworthy realtime web applications is not just a design concern. It's not even just a front-end concern. The problems we will describe might feel daunting, but we'll give you some tools and some things to consider when you encounter them.
 -->

<!--
(Tim)
One note: if you are a backend developer listening to this talk, don't tune out to the stuff that seems unrelated to your work. It's not. As we'll demonstrate, we can't meet users' realtime needs without end-to-end solutions.
-->

---

<iframe src="/products/scarce-scarf" style="width:40%" frameBorder="1"></iframe>

---
