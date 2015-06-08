# GivingSmart

[Heroku link][heroku]

[heroku]: #

## Minimum Viable Product
GivingSmart is a p2p charity-fundraising platform built off of Catarse, an open-source Rails + Backbone framework.

The features will include:

- [x] User management system (Devise + OmniAuth)
- [x] Users can create fundraisers
- [x] Users can donate to fundraisers
- [x] Admin panel for approving/rejecting fundraisers
- [x] Payment processing
- [x] Automated e-mails, signup e-mails and password retrievals
- [x] Basic layout and design
- [ ] Users can customize the layout and color schemes of their pages
- [ ] Organizations can create accounts and log in
- [ ] Fundraising panel for organizations
- [ ] Organizations can run blogs
- [ ] Organizations can do accounting of offline and online donations
- [ ] Organizations can start fundraisers
- [ ] Users funneled toward participating in organization-run fundraisers
- [ ] Users can create fundraising teams

## Design Docs
* [View Wireframes][views]
* [DB schema][schema]

[views]: ./docs/views.md
[schema]: ./docs/schema.md

## Implementation Timeline

### Phase 1: Dependencies and Deployment (~0.75 days)
I will figure out all of the dependencies and how to deploy the project on a local server, as well as onto Heroku. This will be fairly involved as Catarse has a lot of dependencies, and I may have to set up an Ubuntu VM using Vagrant (their recommended solution).

### Phase 2: Translation (~1 day)
During this phase I will get a high-level overview of the codebase starting with the views and display logic. I will look up the standards for I18n internationalization that Rails uses. I will then go through and translate everything that is incorrectly translated into proper English (including comments), and translate the few pages (7-8 according to the Wiki) which are currently not translated. Will then issue a pull request on the Catarse project.

Doing some translation work should give me a cursory overview of the project and let me understand all (or most) of the views.

### Phase 3: Familiarization and Annotation (2 days)
In the next phase, I will deeply examine the codebase in two phases. First I will look over all of the libraries and annotate what they're used for, as well as look up their basic documentation. The gemfile is 160 lines long, so this will take some time.

I will then go over each file in the codebase and add my own annotations so that I can understand everything that the code is doing. This will include the DB and views. It will also likely entail looking up Ruby/Rails features with which I'm unfamiliar.

I'll have to read up on a number of patterns/technologies they implement in their codebase. They include:

 + observers
 + service objects
 + decorators
 + policies
 + workers
 + automated Rake tasks
 + HAML
 + front-end add-ons (jQuery plugins, skull.js (Backbone add-on), redactor)

I may also need to read up on Devise, OmniAuth, and their payment processing, as these are pretty involved and possibly integral to how the framework operates.

After this phase I may also be able to merge some of my additional documentation into the Catarse project.

### Phase 4: Organizations & Charities (I start making stuff!) (~1 day)

In this phase I add all of the database requirements to create organizations and charities. Because this product is intended to be used by a limited number of charities and organizations, they can for now be created manually through the terminal, so there's no need for a UI for the creation process. However, once charities/organizations exist, organizations will need a show and index view from the main page.

[Details][phase-four]

### Phase 5: Fundraising dashboard for Users and Organizations (~1.5 days)

The dashboard page for any user/fundraiser will essentially become its own Backbone app, from which they can track their fundraisers, alter their layouts, and manage any fundraising. In this phase I will make the skeleton of this app, which will be accessed by both organizations and by users.

These will replace Catarse's existing fundraising controls. Through this interface, users will be able to control whether their pages are live or not.

[Details][phase-five]

### Phase 6: Dynamic layout for fundraising pages (~2 days)

Through the dashboard, users will be able to change the layout and content of their fundraising page. This includes changing the colors (altering the CSS) of the background and key elements, filling in the text and headers, adding a video, etc. All of this gets persisted to the database and is live-previewed during editing.

[Details][phase-six]

### Phase 7: Fundraising features (~1.5 days)

Add charts for fundraising and the ability to add offline donations. Set it up so that organizations can create fundraisers and users can freely participate in those fundraisers using a template auto-populated by the organization. Users can essentially "fork" a fundraiser that an organization is running.

[Details][phase-seven]

### Phase 8: Team features (~1.5 days)

Add teams. Allow organizations to create teams, and for users to belong to teams on the same fundraiser. Create inter-relationships so teams are visible from organization page, and users can view their own teams.

[Details][phase-eight]


### Bonus Features (TBD)
- [ ] Generate dynamic subdomains
- [ ] Populate pre-selected high-impact charities
- [ ] Create signup track for charities
- [ ] "Getting started" tour upon creating a fundraising page
- [ ] Organizations can do basic analytics (graphs) on donations
- [ ] Add categories for fundraisers
- [ ] Add recurring donors
- [ ] Recent activity feed
- [ ] Sidebar with key metrics ($ raised, visitor count, days left, etc.)

### Bonus Tasks
- [ ] Elide Kickstarter-style reward system
- [ ] Sharpen up UX, consistent visual theme, logo
- [ ] Update admin page/processes to be in-line with new design
- [ ] Responsive design (where not already)
- [ ] Clean up database remnants of Catarse (particularities of Brazilian payment processing, translate database column names into English, etc.)
- [ ] Use ruby-prof / rack-mini-profiler for optimization
- [ ] Add test coverage
- [ ] Refactor fat views into partials
- [ ] Refactor user model (god object)

[phase-four]: ./docs/phases/phase4.md
[phase-five]: ./docs/phases/phase5.md
[phase-six]: ./docs/phases/phase6.md
[phase-seven]: ./docs/phases/phase7.md
[phase-eight]: ./docs/phases/phase8.md
