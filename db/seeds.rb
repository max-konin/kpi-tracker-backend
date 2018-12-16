Doorkeeper::Application.destroy_all
Doorkeeper::Application.create(name: "starter_project_web", redirect_uri: "http://localhost:3000/")

Category.create name: 'Influencer outreach', kpi_day_period: 7, kpi_quantity_goal: 4
Category.create name: 'Facebook posting', kpi_day_period: 7, kpi_quantity_goal: 3
Category.create name: 'Influencer backlink exchange', kpi_day_period: 30, kpi_quantity_goal: 5