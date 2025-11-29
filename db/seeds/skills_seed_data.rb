# Skills Seed Data
# Run with: rails db:seed or rails runner db/seeds/skills_seed_data.rb
#
# Categories:
# - language: Programming languages
# - framework: Web/mobile frameworks and major libraries
# - database: Databases and data stores
# - tool: Development tools, platforms, and specific software
# - cloud: Cloud platforms and services
# - methodology: Development practices, architectural patterns, disciplines
# - soft_skill: People skills, leadership, and management

SKILLS_DATA = [
  # ==================== PROGRAMMING LANGUAGES ====================
  {
    name: "Ruby",
    slug: "ruby",
    aliases: [],
    category: "language"
  },
  {
    name: "Python",
    slug: "python",
    aliases: [],
    category: "language"
  },
  {
    name: "JavaScript",
    slug: "javascript",
    aliases: ["JS"],
    category: "language"
  },
  {
    name: "TypeScript",
    slug: "typescript",
    aliases: ["TS"],
    category: "language"
  },
  {
    name: "Java",
    slug: "java",
    aliases: [],
    category: "language"
  },
  {
    name: "Go",
    slug: "go",
    aliases: ["Golang"],
    category: "language"
  },
  {
    name: "C#",
    slug: "csharp",
    aliases: ["C Sharp", "CSharp"],
    category: "language"
  },
  {
    name: "PHP",
    slug: "php",
    aliases: [],
    category: "language"
  },
  {
    name: "Elixir",
    slug: "elixir",
    aliases: [],
    category: "language"
  },
  {
    name: "SQL",
    slug: "sql",
    aliases: [],
    category: "language"
  },
  {
    name: "Bash",
    slug: "bash",
    aliases: ["Shell", "Shell Scripting"],
    category: "language"
  },
  {
    name: "HTML",
    slug: "html",
    aliases: [],
    category: "language"
  },
  {
    name: "ES6",
    slug: "es6",
    aliases: [],
    category: "language"
  },

  # ==================== FRAMEWORKS ====================
  {
    name: "Ruby on Rails",
    slug: "ruby-on-rails",
    aliases: %w[Rails RoR],
    category: "framework"
  },
  {
    name: "React",
    slug: "react",
    aliases: ["React.js", "ReactJS"],
    category: "framework"
  },
  {
    name: "Vue.js",
    slug: "vuejs",
    aliases: ["Vue"],
    category: "framework"
  },
  {
    name: "Angular",
    slug: "angular",
    aliases: ["AngularJS"],
    category: "framework"
  },
  {
    name: "Next.js",
    slug: "nextjs",
    aliases: %w[Next NextJS],
    category: "framework"
  },
  {
    name: "Svelte",
    slug: "svelte",
    aliases: ["SvelteKit"],
    category: "framework"
  },
  {
    name: "Django",
    slug: "django",
    aliases: [],
    category: "framework"
  },
  {
    name: "Flask",
    slug: "flask",
    aliases: [],
    category: "framework"
  },
  {
    name: "FastAPI",
    slug: "fastapi",
    aliases: [],
    category: "framework"
  },
  {
    name: "Node.js",
    slug: "nodejs",
    aliases: %w[Node NodeJS],
    category: "framework"
  },
  {
    name: "Express.js",
    slug: "expressjs",
    aliases: ["Express"],
    category: "framework"
  },
  {
    name: "NestJS",
    slug: "nestjs",
    aliases: ["Nest", "Nest.js"],
    category: "framework"
  },
  {
    name: ".NET",
    slug: "dotnet",
    aliases: ["ASP.NET", "Dot Net"],
    category: "framework"
  },
  {
    name: "Sinatra",
    slug: "sinatra",
    aliases: [],
    category: "framework"
  },
  {
    name: "Phoenix",
    slug: "phoenix",
    aliases: [],
    category: "framework"
  },
  {
    name: "Remix",
    slug: "remix",
    aliases: [],
    category: "framework"
  },
  {
    name: "Hotwire",
    slug: "hotwire",
    aliases: [],
    category: "framework"
  },
  {
    name: "Stimulus",
    slug: "stimulus",
    aliases: [],
    category: "framework"
  },
  {
    name: "Turbo",
    slug: "turbo",
    aliases: [],
    category: "framework"
  },
  {
    name: "Tailwind",
    slug: "tailwind",
    aliases: ["Tailwind CSS"],
    category: "framework"
  },
  {
    name: "Redux",
    slug: "redux",
    aliases: [],
    category: "framework"
  },
  {
    name: "ActiveRecord",
    slug: "activerecord",
    aliases: [],
    category: "framework"
  },
  {
    name: "React Native",
    slug: "react-native",
    aliases: [],
    category: "framework"
  },
  {
    name: "Flutter",
    slug: "flutter",
    aliases: [],
    category: "framework"
  },

  # ==================== DATABASES ====================
  {
    name: "PostgreSQL",
    slug: "postgresql",
    aliases: %w[Postgres psql PostgresSQL],
    category: "database"
  },
  {
    name: "MySQL",
    slug: "mysql",
    aliases: [],
    category: "database"
  },
  {
    name: "MongoDB",
    slug: "mongodb",
    aliases: ["Mongo"],
    category: "database"
  },
  {
    name: "Redis",
    slug: "redis",
    aliases: [],
    category: "database"
  },
  {
    name: "Elasticsearch",
    slug: "elasticsearch",
    aliases: ["Elastic"],
    category: "database"
  },
  {
    name: "DynamoDB",
    slug: "dynamodb",
    aliases: [],
    category: "database"
  },
  {
    name: "Aurora",
    slug: "aurora",
    aliases: ["AWS Aurora"],
    category: "database"
  },
  {
    name: "RDS",
    slug: "rds",
    aliases: ["AWS RDS"],
    category: "database"
  },
  {
    name: "SQL Server",
    slug: "sql-server",
    aliases: ["Microsoft SQL Server", "MSSQL"],
    category: "database"
  },
  {
    name: "Cassandra",
    slug: "cassandra",
    aliases: [],
    category: "database"
  },
  {
    name: "Neo4j",
    slug: "neo4j",
    aliases: [],
    category: "database"
  },
  {
    name: "BigQuery",
    slug: "bigquery",
    aliases: [],
    category: "database"
  },
  {
    name: "Snowflake",
    slug: "snowflake",
    aliases: [],
    category: "database"
  },

  # ==================== TOOLS ====================
  {
    name: "Git",
    slug: "git",
    aliases: [],
    category: "tool"
  },
  {
    name: "Docker",
    slug: "docker",
    aliases: [],
    category: "tool"
  },
  {
    name: "Kubernetes",
    slug: "kubernetes",
    aliases: ["K8s"],
    category: "tool"
  },
  {
    name: "Terraform",
    slug: "terraform",
    aliases: [],
    category: "tool"
  },
  {
    name: "Ansible",
    slug: "ansible",
    aliases: [],
    category: "tool"
  },
  {
    name: "GitHub",
    slug: "github",
    aliases: [],
    category: "tool"
  },
  {
    name: "GitHub Actions",
    slug: "github-actions",
    aliases: [],
    category: "tool"
  },
  {
    name: "GitLab",
    slug: "gitlab",
    aliases: ["GitLab CI"],
    category: "tool"
  },
  {
    name: "Jenkins",
    slug: "jenkins",
    aliases: [],
    category: "tool"
  },
  {
    name: "CircleCI",
    slug: "circleci",
    aliases: ["Circle CI"],
    category: "tool"
  },
  {
    name: "Jira",
    slug: "jira",
    aliases: [],
    category: "tool"
  },
  {
    name: "Confluence",
    slug: "confluence",
    aliases: [],
    category: "tool"
  },
  {
    name: "Slack",
    slug: "slack",
    aliases: [],
    category: "tool"
  },
  {
    name: "Linear",
    slug: "linear",
    aliases: [],
    category: "tool"
  },
  {
    name: "Notion",
    slug: "notion",
    aliases: [],
    category: "tool"
  },
  {
    name: "Grafana",
    slug: "grafana",
    aliases: [],
    category: "tool"
  },
  {
    name: "Prometheus",
    slug: "prometheus",
    aliases: [],
    category: "tool"
  },
  {
    name: "Datadog",
    slug: "datadog",
    aliases: [],
    category: "tool"
  },
  {
    name: "New Relic",
    slug: "new-relic",
    aliases: [],
    category: "tool"
  },
  {
    name: "Sentry",
    slug: "sentry",
    aliases: [],
    category: "tool"
  },
  {
    name: "GraphQL",
    slug: "graphql",
    aliases: [],
    category: "tool"
  },
  {
    name: "REST APIs",
    slug: "rest-apis",
    aliases: ["REST", "RESTful", "API management", "RESTful APIs", "APIs"],
    category: "tool"
  },
  {
    name: "gRPC",
    slug: "grpc",
    aliases: [],
    category: "tool"
  },
  {
    name: "Postman",
    slug: "postman",
    aliases: [],
    category: "tool"
  },
  {
    name: "Selenium",
    slug: "selenium",
    aliases: [],
    category: "tool"
  },
  {
    name: "Cypress",
    slug: "cypress",
    aliases: [],
    category: "tool"
  },
  {
    name: "Jest",
    slug: "jest",
    aliases: [],
    category: "tool"
  },
  {
    name: "Playwright",
    slug: "playwright",
    aliases: [],
    category: "tool"
  },
  {
    name: "RSpec",
    slug: "rspec",
    aliases: [],
    category: "tool"
  },
  {
    name: "PyTest",
    slug: "pytest",
    aliases: [],
    category: "tool"
  },
  {
    name: "Sidekiq",
    slug: "sidekiq",
    aliases: [],
    category: "tool"
  },
  {
    name: "Resque",
    slug: "resque",
    aliases: [],
    category: "tool"
  },
  {
    name: "Kafka",
    slug: "kafka",
    aliases: [],
    category: "tool"
  },
  {
    name: "Nginx",
    slug: "nginx",
    aliases: [],
    category: "tool"
  },
  {
    name: "Apache",
    slug: "apache",
    aliases: [],
    category: "tool"
  },
  {
    name: "Linux",
    slug: "linux",
    aliases: [],
    category: "tool"
  },
  {
    name: "HAML",
    slug: "haml",
    aliases: [],
    category: "tool"
  },
  {
    name: "Pandas",
    slug: "pandas",
    aliases: [],
    category: "tool"
  },
  {
    name: "Scikit-learn",
    slug: "scikit-learn",
    aliases: [],
    category: "tool"
  },
  {
    name: "Spark",
    slug: "spark",
    aliases: [],
    category: "tool"
  },
  {
    name: "Salesforce",
    slug: "salesforce",
    aliases: [],
    category: "tool"
  },
  {
    name: "ServiceNow",
    slug: "servicenow",
    aliases: [],
    category: "tool"
  },
  {
    name: "NetSuite",
    slug: "netsuite",
    aliases: [],
    category: "tool"
  },
  {
    name: "Stripe",
    slug: "stripe",
    aliases: [],
    category: "tool"
  },

  # ==================== CLOUD ====================
  {
    name: "AWS",
    slug: "aws",
    aliases: ["Amazon Web Services"],
    category: "cloud"
  },
  {
    name: "Google Cloud Platform",
    slug: "gcp",
    aliases: ["GCP", "Google Cloud"],
    category: "cloud"
  },
  {
    name: "Microsoft Azure",
    slug: "azure",
    aliases: ["Azure"],
    category: "cloud"
  },
  {
    name: "Lambda",
    slug: "lambda",
    aliases: ["AWS Lambda"],
    category: "cloud"
  },
  {
    name: "S3",
    slug: "s3",
    aliases: ["AWS S3"],
    category: "cloud"
  },
  {
    name: "EC2",
    slug: "ec2",
    aliases: ["AWS EC2"],
    category: "cloud"
  },
  {
    name: "ECS",
    slug: "ecs",
    aliases: ["AWS ECS"],
    category: "cloud"
  },
  {
    name: "EKS",
    slug: "eks",
    aliases: ["AWS EKS"],
    category: "cloud"
  },
  {
    name: "CloudFormation",
    slug: "cloudformation",
    aliases: ["AWS CloudFormation"],
    category: "cloud"
  },
  {
    name: "CloudWatch",
    slug: "cloudwatch",
    aliases: ["AWS CloudWatch"],
    category: "cloud"
  },
  {
    name: "SNS",
    slug: "sns",
    aliases: ["AWS SNS"],
    category: "cloud"
  },
  {
    name: "SQS",
    slug: "sqs",
    aliases: ["AWS SQS"],
    category: "cloud"
  },
  {
    name: "IAM",
    slug: "iam",
    aliases: ["AWS IAM"],
    category: "cloud"
  },
  {
    name: "VPC",
    slug: "vpc",
    aliases: ["AWS VPC"],
    category: "cloud"
  },
  {
    name: "AppSync",
    slug: "appsync",
    aliases: ["AWS AppSync"],
    category: "cloud"
  },
  {
    name: "Amplify",
    slug: "amplify",
    aliases: ["AWS Amplify"],
    category: "cloud"
  },
  {
    name: "Bedrock",
    slug: "bedrock",
    aliases: ["AWS Bedrock"],
    category: "cloud"
  },
  {
    name: "SageMaker",
    slug: "sagemaker",
    aliases: ["AWS SageMaker"],
    category: "cloud"
  },
  {
    name: "GKE",
    slug: "gke",
    aliases: ["Google Kubernetes Engine"],
    category: "cloud"
  },
  {
    name: "Vertex",
    slug: "vertex",
    aliases: ["Vertex AI"],
    category: "cloud"
  },
  {
    name: "Heroku",
    slug: "heroku",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Vercel",
    slug: "vercel",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Netlify",
    slug: "netlify",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Railway",
    slug: "railway",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Render",
    slug: "render",
    aliases: [],
    category: "cloud"
  },
  {
    name: "DigitalOcean",
    slug: "digitalocean",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Cloudflare",
    slug: "cloudflare",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Firebase",
    slug: "firebase",
    aliases: [],
    category: "cloud"
  },
  {
    name: "Supabase",
    slug: "supabase",
    aliases: [],
    category: "cloud"
  },

  # ==================== METHODOLOGIES ====================
  {
    name: "DevOps",
    slug: "devops",
    aliases: [],
    category: "methodology"
  },
  {
    name: "Platform Engineering",
    slug: "platform-engineering",
    aliases: ["Cloud Infrastructure"],
    category: "methodology"
  },
  {
    name: "Site Reliability Engineering",
    slug: "sre",
    aliases: ["SRE", "Site Reliability"],
    category: "methodology"
  },
  {
    name: "Infrastructure as Code",
    slug: "infrastructure-as-code",
    aliases: ["IaC"],
    category: "methodology"
  },
  {
    name: "CI/CD",
    slug: "cicd",
    aliases: ["Continuous Integration", "Continuous Deployment", "CICD"],
    category: "methodology"
  },
  {
    name: "GitOps",
    slug: "gitops",
    aliases: [],
    category: "methodology"
  },
  {
    name: "Agile",
    slug: "agile",
    aliases: ["Agile Methodologies", "Agile Development"],
    category: "methodology"
  },
  {
    name: "Scrum",
    slug: "scrum",
    aliases: ["Scrum Master"],
    category: "methodology"
  },
  {
    name: "Test-Driven Development",
    slug: "tdd",
    aliases: ["TDD"],
    category: "methodology"
  },
  {
    name: "Behavior-Driven Development",
    slug: "bdd",
    aliases: ["BDD"],
    category: "methodology"
  },
  {
    name: "Microservices",
    slug: "microservices",
    aliases: ["Microservice Architecture", "Micro-services"],
    category: "methodology"
  },
  {
    name: "System Design",
    slug: "system-design",
    aliases: ["Software Design", "System Architecture"],
    category: "methodology"
  },
  {
    name: "Object-Oriented Programming",
    slug: "oop",
    aliases: ["OOP"],
    category: "methodology"
  },
  {
    name: "MVC",
    slug: "mvc",
    aliases: ["Model-View-Controller"],
    category: "methodology"
  },
  {
    name: "Software Development Life Cycle",
    slug: "sdlc",
    aliases: ["SDLC"],
    category: "methodology"
  },
  {
    name: "A/B Testing",
    slug: "ab-testing",
    aliases: [],
    category: "methodology"
  },
  {
    name: "Data Modeling",
    slug: "data-modeling",
    aliases: [],
    category: "methodology"
  },

  # ==================== SOFT SKILLS ====================
  {
    name: "Engineering Management",
    slug: "engineering-management",
    aliases: ["engineering leadership", "managing engineering teams", "people management", "team management",
              "managing multiple, large, cross-functional teams", "management experience",
              "leading and managing software engineering teams", "experience managing"],
    category: "soft_skill"
  },
  {
    name: "Technical Leadership",
    slug: "technical-leadership",
    aliases: ["technology leadership", "technical lead", "senior executive roles", "Tech Leadership"],
    category: "soft_skill"
  },
  {
    name: "Mentorship",
    slug: "mentorship",
    aliases: %w[Mentoring Coaching],
    category: "soft_skill"
  },
  {
    name: "Communication",
    slug: "communication",
    aliases: ["Written Communication", "Verbal Communication"],
    category: "soft_skill"
  },
  {
    name: "Collaboration",
    slug: "collaboration",
    aliases: ["Teamwork", "Cross-functional Collaboration"],
    category: "soft_skill"
  },
  {
    name: "Problem Solving",
    slug: "problem-solving",
    aliases: ["Analytical Thinking", "Critical Thinking"],
    category: "soft_skill"
  },
  {
    name: "Project Management",
    slug: "project-management",
    aliases: ["PM"],
    category: "soft_skill"
  },
  {
    name: "Code Review",
    slug: "code-review",
    aliases: ["Peer Review"],
    category: "soft_skill"
  },
  {
    name: "Technical Writing",
    slug: "technical-writing",
    aliases: ["Documentation"],
    category: "soft_skill"
  },
  {
    name: "Pair Programming",
    slug: "pair-programming",
    aliases: ["Pairing"],
    category: "soft_skill"
  },
  {
    name: "Remote Work",
    slug: "remote-work",
    aliases: ["Remote", "Distributed Team"],
    category: "soft_skill"
  },
  {
    name: "Startup Experience",
    slug: "startup-experience",
    aliases: ["startup environments", "startup environment", "Start up experience", "Startup"],
    category: "soft_skill"
  },
  {
    name: "Software Engineering",
    slug: "software-engineering",
    aliases: ["software development", "software engineer", "Technology", "Information and Internet experience"],
    category: "soft_skill"
  },
  {
    name: "Full Stack Engineering",
    slug: "full-stack-engineering",
    aliases: ["full-stack", "full stack", "full-stack development", "full web application stack",
              "front-end and back-end programming", "full stack development",
              "building software products end-to-end", "Full Stack"],
    category: "soft_skill"
  },
  {
    name: "Frontend Engineering",
    slug: "frontend-engineering",
    aliases: ["frontend architecture", "front-end", "Front End Development"],
    category: "soft_skill"
  },
  {
    name: "Backend Engineering",
    slug: "backend-engineering",
    aliases: ["Back End Development", "backend development"],
    category: "soft_skill"
  },
  {
    name: "Mobile Development",
    slug: "mobile-development",
    aliases: ["Mobile", "Mobile application development"],
    category: "soft_skill"
  },
  {
    name: "Web Development",
    slug: "web-development",
    aliases: ["web application development"],
    category: "soft_skill"
  },
  {
    name: "Quality Assurance",
    slug: "qa",
    aliases: ["QA", "Testing", "Test Automation", "SDET"],
    category: "soft_skill"
  },

  # ==================== DOMAINS & INDUSTRIES ====================
  {
    name: "FinTech",
    slug: "fintech",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "E-Commerce",
    slug: "ecommerce",
    aliases: ["e-commerce"],
    category: "soft_skill"
  },
  {
    name: "SaaS",
    slug: "saas",
    aliases: ["Software-as-a-Service"],
    category: "soft_skill"
  },
  {
    name: "B2B",
    slug: "b2b",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "B2C",
    slug: "b2c",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "CRM",
    slug: "crm",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "ERP",
    slug: "erp",
    aliases: ["Enterprise Resource Planning"],
    category: "soft_skill"
  },
  {
    name: "Web3",
    slug: "web3",
    aliases: ["DeFi"],
    category: "soft_skill"
  },
  {
    name: "AI/ML",
    slug: "ai-ml",
    aliases: ["Artificial Intelligence", "Machine Learning", "AI", "ML", "Agentic AI", "LLM", "LLMs",
              "Large Language Models", "Neural Networks"],
    category: "soft_skill"
  },
  {
    name: "OpenAI",
    slug: "openai",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "Anthropic",
    slug: "anthropic",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "GitHub Copilot",
    slug: "github-copilot",
    aliases: ["Copilot"],
    category: "soft_skill"
  },
  {
    name: "RAG",
    slug: "rag",
    aliases: ["Retrieval-Augmented Generation"],
    category: "soft_skill"
  },
  {
    name: "IoT",
    slug: "iot",
    aliases: ["Internet of Things"],
    category: "soft_skill"
  },
  {
    name: "Real-time Data Streaming",
    slug: "real-time-data-streaming",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "Data Warehouse",
    slug: "data-warehouse",
    aliases: ["data management", "data warehouses"],
    category: "soft_skill"
  },

  # ==================== COMPLIANCE & STANDARDS ====================
  {
    name: "HIPAA",
    slug: "hipaa",
    aliases: [],
    category: "soft_skill"
  },
  {
    name: "PCI",
    slug: "pci",
    aliases: ["PCI Compliance"],
    category: "soft_skill"
  },
  {
    name: "SOC 2",
    slug: "soc2",
    aliases: %w[SOC-2 SOC],
    category: "soft_skill"
  },
  {
    name: "ITIL",
    slug: "itil",
    aliases: [],
    category: "soft_skill"
  }
].freeze

# Seed the database
Rails.logger.debug "Seeding skills..."

SKILLS_DATA.each do |skill_data|
  skill = Skill.find_or_initialize_by(slug: skill_data[:slug])
  skill.assign_attributes(skill_data)

  if skill.save
    Rails.logger.debug { "✓ #{skill.name} (#{skill.category})" }
  else
    Rails.logger.debug { "✗ Failed to save #{skill_data[:name]}: #{skill.errors.full_messages.join(", ")}" }
  end
end

Rails.logger.debug { "\nSeeding complete! Total skills: #{Skill.count}" }
Rails.logger.debug "\nBreakdown by category:"
Skill.group(:category).count.sort.each do |category, count|
  Rails.logger.debug "  #{category.ljust(20)}: #{count}"
end
