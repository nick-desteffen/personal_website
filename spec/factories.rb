FactoryGirl.define do
  sequence :title do |n|
    "Blog Post #{n}"
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryGirl.define do
  factory :user do
    first_name "Nick"
    last_name "DeSteffen"
    email
    password "secret1"
    created_at { Time.now }
    updated_at { Time.now }
  end

  factory :contact_message do
    name "John Doe"
    email "jdoe@gmail.com"
    message "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dolor tortor, tincidunt non tincidunt a, pellentesque non eros. Aenean condimentum molestie tristique. Sed convallis pulvinar nulla, auctor vestibulum tellus iaculis eu. Mauris consequat laoreet eros eget interdum. Suspendisse potenti."
    user_agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:6.0) Gecko/20100101 Firefox/6.0"
    subject "Lorem ipsum"
    phone_number "3129142323"
    created_at { Time.now }
    updated_at { Time.now }
  end
  
  factory :post do
    title
    body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dolor tortor, tincidunt non tincidunt a, pellentesque non eros. Aenean condimentum molestie tristique. Sed convallis pulvinar nulla, auctor vestibulum tellus iaculis eu. Mauris consequat laoreet eros eget interdum. Suspendisse potenti."
    published_at { 1.week.ago }
    created_at { Time.now }
    updated_at { Time.now }
  end
  
  factory :comment do
    post
    name "Payton Dog"
    email "payton@dog.com"
    body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dolor tortor, tincidunt non tincidunt a, pellentesque non eros. Aenean condimentum molestie tristique. Sed convallis pulvinar nulla, auctor vestibulum tellus iaculis eu. Mauris consequat laoreet eros eget interdum. Suspendisse potenti."
    url "http://www.paytondog.com"
    gravatar_hash "400741f047e4a0e6d3c5d5b962dba6c5"
    created_at { Time.now }
    updated_at { Time.now }
  end
  
  factory :tag do
    post
    name "rails"
    created_at { Time.now }
    updated_at { Time.now }
  end
  
  factory :related_link do
    post
    title "Google"
    url "http://www.google.com"
    created_at { Time.now }
    updated_at { Time.now }
  end
  
end