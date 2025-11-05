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

#let positions(items: (), sidebarWidth: 30pt) = {
  layout(size => context {
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
      let heightOfTitle = measure(block(width: size.width, positionHeader)).height
      let heightOfDescription = measure(block(width:size.width, positionDescription)).height

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
})
}


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
    margin: (x: 36pt, y: 36pt),
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
    // == About
    // Software Engineer with 7 years of experience. I like bouldering, working out, D&D and video games.

    == Experience
    #workplace("Klimate", "KlimateIconDarkGrey.svg","Jan 2024 --- Present", sidebarWidth: 30pt)
    #positions(items: (
      (name: "Senior Software Engineer",
       description: [Developed carbon asset management platform in a team of 3 devs, building a backoffice system that managed inventory, procurement and customer orders using *C\#* *ASP .NET 9 Web Api* with *GraphQL* endpoints and a *Vue.js* frontend.

      Managed the database schema using code-first *EF Core* on a *PostgreSQL* database.

      Implemented invoice sending and validation to prevent over-allocation of carbon credits, using scheduled *Azure Functions* for the integrity checks, logging to *App Insights*, and alerting to Slack via a *Logic App*.
      
      All the CI/CD was handled via *Github workflows*, with the infra provisioned through *Terraform*. 
]),
      ))

    #workplace("Alvys", "alvys.jpg","Feb 2023 --- Jan 2024", sidebarWidth: 30pt)
    #positions(items: (
      (name: "Senior Software Engineer",
       description: [
        Developed features for SaaS Transportation Management System serving carriers, brokers, and shippers using *C\# ASP.NET 7 Web Api* hosted as *Azure Web App* with *Cosmos DB* serving over 300 customers. 

        Implemented *AS2* communication protocol using RFC specifications and *MimeKit* for MIME message parsing/generation, built *EDI* features for automated tender import and load acceptance/rejection with custom format translations for shippers like HEB. Served as technical point of contact for third parties during *AS2* implementation, testing, and some *EDI* format integrations.

        // Worked on a Transportation Management System for truck freight in USA for over half a year using *C\#* *ASP.NET 7 Web Api* . The Web Api was hosted in *Azure* Web App with *Cosmos Db* as the main data store and azure yaml pipelines for CI and classic releases for CD. Responsible for implementing the communication protocol *AS2* and business logic used for integrating with third parties, also served as a point of contact for said third parties.
        ]),
      ))

    #workplace("Endava", "endava.jpg","Mar 2018 --- Mar 2022", sidebarWidth: 30pt)
    #positions(items: (
      (name: "Software Engineer",
       description: [Worked on a clearing bank's *SOA* multi-tenant application. I was in the data team where we ingested data from other services that communicated over *Azure Service Bus* and processed it with streaming jobs written in *Scala* using *Databricks*. Also was responsible for writing scheduled jobs that would run daily using *Azure Functions*. Deployments were done using *Terraform* and azure *Yaml pipelines*.]),
      (name: "Software Developer",
       description: [For over 2 years worked on financial derivatives trading platform made up of *Windows Services* wrttien in  C\# *.NET Framework 4.6* communicating over a pub-sub *Message Bus*, with storage in *MySQL*. Responsibilities included implementing new features, fixing bugs in legacy code, rewriting components or services when needed, updating *WCF* contracts exposed to upstream providers of pricing data,etc.]),
       (name: "Junior Software Developer",
       description: [Desktop *Windows Forms* app, used by brokers to approve/reject trades. Application was written in *C\#* using a *Model-View-Presenter* architecture, it communicated with backend services over a message bus.Rewrote on of the views in *WCF*]),
       (name: "Intern",
       description: [Worked on *MVC* backend application for internal library app  meant for inventory tracking and borrowing books. Written in *C\#*, using code-first *Entity Framework* to communicate with an *MSSQL* database.
        
        // As part of internship implemented an *MVC* backend app used for an internal library app meant for inventory tracking and allowing borrowing of books. It was written in *C\#*, using code-first *Entity Framework* to communicate with an *MSSQL* database.
        ])
    ))

    #pagebreak()
    == Education

    === Associate Degree \
    _C.E.I.T.I._\
    #term[Sep 2014 --- Jul 2018][]

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