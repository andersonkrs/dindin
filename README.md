### DinDin (Brazilian slang for money)

My family's personal budgeting app.

#### Motivation

I've created this app to help me and my wife to track our expenses, investments and goals. Before we were using a spreadsheet and a google form to to submit information, then I decided to create this PWA to tailor our needs.

As it is right now, it has very few features, it's basically logging expenses, on spare time I've been slowling working on it as we need. To analyze the data I've been simply analyzing the database with SQL for now. The goal is to become a installable budgeting app that you can run on your own server/Raspebery PI/etc and have control of your finances data.

The desing of this app is heavily inspired on [37signals](https://37signals.com/) products like [Hey Email](https://www.hey.com/), [Writebook](https://once.com/writebook), [Campfire](https://once.com/campfire), etc.

Bellow a demo with the features implemented so far.

<table>
  <tr>
    <th>Demo</th>
  </tr>  
  <tr>
    <td>
      <video src="https://github.com/user-attachments/assets/0530e145-746a-444b-8d8b-04758e03f75d" alt="App Demo" width="128" height="128">
    </td> 
  </tr>  
</table>


#### Built With

The idea is to keep it as close as possible to a [vanila Rails Stack](https://dev.37signals.com/a-vanilla-rails-stack-is-plenty/).

* Ruby on Rails
* SQLite3 
* Hotwire
* TailwindCSS + DaisyUI

Hosted on a VPS using [Kamal](https://kamal-deploy.org/).
