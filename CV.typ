#let primary_colour = rgb("#3E0C87") // vivid purple
#let link_colour = rgb("#12348e") // blue
#let light_purple = rgb("#975bf1") // light purple

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
      linebreak()
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
  text(light_purple,9pt)[#icon("calendar") #period #h(1fr) /* #icon("location") #location */]
}

#let styled-link(dest, content) = emph(text(
    fill: link_colour,
    link(dest, content) 
  ))


#let workplace(jobName, imageName, period, sidebarWidth: 30pt, location: "Chisinau, MD") = {
   grid(
    columns: (sidebarWidth, auto),
    gutter: 5pt,
    image("icons/" + imageName),
    [
      #v(3pt) 
      #heading(level: 3, jobName) \
      #term[#period][]
    ])
}

#let positions(items: (), sidebarWidth: 30pt) = { layout(size => style(styles => {
  let n = 0
  for item in items {
    let sidebarCircle = box(
      width: sidebarWidth,
      align(center + top,
        circle(radius: 2.5pt, stroke: light_purple)
      )
    )
    let positionHeader = [
      #heading(level: 4,item.name)
      #linebreak()
      ]
    stack(dir: ltr,
    sidebarCircle,
    positionHeader)

    let positionDescription = [
      #item.description
    ]
    let heightOfTitle = measure(block(width: size.width, positionHeader), styles).height
    let heightOfDescription = measure(block(width:size.width, positionDescription), styles).height

    let continuationLine = [
      #if (n < items.len() - 1) {
        block(
          width: sidebarWidth,
          inset: 0pt,
          align(center + top, 
            {
              v(-heightOfTitle)
              rect(width: 1pt,height: heightOfDescription+heightOfTitle, fill: light_purple)
            })
          )
      } else {
        block(width: sidebarWidth)
      }
    ]

    box(stack(dir: ltr,
    continuationLine,
    positionDescription))
    n += 1;
  }
}))}


#let cv(
  name: "",
  links: (),
  content,
) = {
  set document(
    title: name + "'s CV",
    author: name,
  )
  set text(9.8pt, font: "Lato")
  set page(
    margin: (x: 46pt, y: 46pt),
  )

   show heading.where(
    level: 1
  ): it => {
    text(
      fill: primary_colour,
      it.body
  )}
  
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
  ): it => text(
    fill: primary_colour,
    it.body
  )

  show heading.where(
    level: 4
  ): it => text(it.body)

  stack(dir: ltr, spacing: 5pt,
  image(width: 60pt,
  "icons/" + "photo.jpg"),
  stack(dir: ttb,
    v(3pt),
    [= #name],
    findMe(links)
  ))
  content
}

#cv(
  name: "Nichita Cebotari",
  links: (
    (name: "email", link: "mailto:example@gmail.com"),
    // (name: "website", link: "https://example.com/", display: "example.com"),
    (name: "github", link: "https://github.com/nichitacebotari0", display: "@nichitacebotari0"),
    (name: "linkedin", link: "https://www.linkedin.com/in/nichita-cebotari-015b15176/", display: "Nichita Cebotari"),
  ),
  [
    == Experience
    #workplace("Alvys", "alvys.jpg","Feb 2023 --- Present", sidebarWidth: 30pt)
    #positions(items: (
      (name: "Senior Software Engineer",
       description: [Project was a Transportation Management System for truck freight in USA. Working for over half a year on a *ASP .NET 7 Web Api* written in *C\#*. The Web Api was hosted in *Azure* Web App with *Cosmos Db* as the main data store and azure yaml pipelines for CI and classic releases for CD. Responsible for implementing the communication protocol *AS2* and business logic used for integrating with third parties, also served as a point of contact for said third parties.]),
      ))

    #workplace("Endava", "endava.jpg","Mar 2018 --- Mar 2022", sidebarWidth: 30pt)
    #positions(items: (
      (name: "Software Engineer",
       description: [Most recent project was a clearing bank *SOA* multi-tenant application. I was involved in the data team where we would gather data from other services that communicated over *Azure Service Bus* and process it with streaming jobs written in *Scala* using *Databricks*. Also was responsible for writing scheduled jobs that would run daily using *Azure Functions*. Deployments were done using *Terraform* and azure *Yaml pipelines*.]),
      (name: "Software Developer",
       description: [Worked for over 2 years on financial derivatives trading platform made up of *Windows Services* wrttien in *.NET Framework 4.6* communicating over a pub-sub *Message Bus*. Main storage was *MySQL* with data being served by a specific service. Responsibilities included imiplementing new features, fixing bugs inlegacy code, rewriting components or entire services when needed, updating *WCF* contracts exposed to upstream providers of pricing data,etc.]),
       (name: "Junior Software Developer",
       description: [One of the earliest projects I was involved in was a desktop app *Windows Forms*, used by brokers to approve/reject trades.Application was written in *C\#* using a *Model-View-Presenter* architecture, it communicated with backend services over a a message bus.]),
       (name: "Intern",
       description: [As part of internship had to implement an *MVC* backend app used for an internal library app meant for inventory tracking and allowing borrowing of books. It was written in *C\#*, using code-first *Entity Framework* to communicate with an *MSSQL* database.])
    ))
   
    References available on request 

    #pagebreak()
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
    *Romanian:* Fluent \
    *Russian:* Fluent \

    // == Projects
    // ==== #link("https://example.com")[Some project]
    // #lorem(30)
    // #styled-link("https://example.com")[Example page]
  ]
)