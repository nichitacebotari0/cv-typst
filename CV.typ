#let primary_colour = rgb("#3E0C87") // vivid purple
#let link_colour = rgb("#12348e") // blue
#let dark_gray = rgb("#414161")

#let icon(name, shift: 1.5pt) = {
  box(
    baseline: shift,
    height: 10pt,
    image("icons/" + name + ".svg")
  )
  h(3pt)
}

#let findMe(services) = {
  set text(8pt)
  let icon = icon.with(shift: 2.5pt)

  services.map(service => {
      icon(service.name)

      if "display" in service.keys() {
        link(service.link)[#{service.display}]
      } else {
        link(service.link)
      }
    }).join(h(10pt))
  [
    
  ]
}

#let term(period, location) = {
  text(9pt)[#icon("calendar") #period #h(1fr) /* #icon("location") #location */]
}

#let styled-link(dest, content) = emph(text(
    fill: link_colour,
    link(dest, content)
  ))

#let alta(
  name: "",
  links: (),
  content,
) = {
  set document(
    title: name + "'s CV",
    author: name,
  )
  set text(9.8pt, font: "IBM Plex Sans")
  set page(
    margin: (x: 54pt, y: 52pt),
  )

  show heading.where(
    level: 2
  ): it => text(
      fill: primary_colour,
    [
      #{it.body}
      #v(-7pt)
      #line(length: 100%, stroke: 1pt + primary_colour)
    ]
  )

  show heading.where(
    level: 3
  ): it => text(it.body)
  
  show heading.where(
    level: 4
  ): it => text(
    fill: primary_colour,
    it.body
  )

  [= #name]

  findMe(links)

  columns(
    1,
    gutter: 15pt,
    content,
  )
}


#alta(
  name: "Nichita Cebotari",
  links: (
    (name: "email", link: "mailto:example@gmail.com"),
    // (name: "website", link: "https://example.com/", display: "example.com"),
    (name: "github", link: "https://github.com/nichitacebotari0", display: "@nichitacebotari0"),
    (name: "linkedin", link: "https://www.linkedin.com/in/nichita-cebotari-015b15176/", display: "Nichita Cebotari"),
  ),
  [
    == Experience

    === Senior Software Engineer \
    _Alvys_\
    #term[Feb 2023 --- Present][Chisinau, MD]

    - Project was a Transportation Management System for truck freight in USA. Working for over half a year on a *ASP .NET 7 Web Api* written in *C\#*. The Web Api was hosted in *Azure* Web App with *Cosmos Db* as the main data store and azure yaml pipelines for CI and classic releases for CD. Responsible for implementing the communication protocol *AS2* and business logic used for integrating with third parties, also served as a point of contact for said third parties.

    === Software Engineer \
    _Endava_\
    #term[Mar 2018 --- Mar 2022][Chisinau, MD]

    - Most recent project was a clearing bank *SOA* multi-tenant application. I was involved in the data team where we would gather data from other services that communicated over *Azure Service Bus* and process it with streaming jobs written in *Scala* using *Databricks*. Also was responsible for writing data integrity checks that would run daily using *Azure Functions*. Deployments were done using *Terraform* and azure *Yaml pipelines*.

    - Worked for over 2 years on financial derivatives trading platform made up of *Windows Services* wrttien in *.NET Framework 4.6* communicating over a pub-sub *Message Bus*. Main storage was *MySQL* with data being served by a specific service. Responsibilities included imiplementing new features, fixing bugs inlegacy code, rewriting components or entire services when needed, updating *WCF* contracts exposed to upstream providers of pricing data,etc.

    - One of the earliest projects I was involved in was a desktop app *Windows Forms*, used by brokers to approve/reject trades.Application was written in *C\#* using a *Model-View-Presenter* architecture, it communicated with backend services over a a message bus.

    - As part of initial internship had to implement an *MVC* backend app used for an internal library app meant for inventory tracking and allowing borrowing of books. It was written in *C\#*, using code-first *Entity Framework* to communicate with an *MSSQL* database.

    References available on request

    == Education

    === Associate Degree \
    _C.E.I.T.I._\
    #term[Sep 2019 --- Jul 2023][Location, UK]

    Professional Diploma in Computer Science.

    // == Interests

    // - Bouldering
    // - Video Game Development
    // - The Zig programming language

    == Languages

    *English:* Fluent \
    *Romanian:* Native \
    *Russian:* Fluent \

    // == Projects

    // ==== #link("https://example.com")[Some project]

    // #lorem(30)
    
    // #styled-link("https://example.com")[Example page]
  ],
)
