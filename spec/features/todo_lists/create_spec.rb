require 'spec_helper'

describe "Create todo lists" do
    def create_todo_list(options={})
        options[:title] ||= "My todo list"
        options[:description] ||= "This is what I am doing today"
        
       visit "/todo_lists"
       click_link "New Todo list"
       expect(page).to have_content("New todo_list")
       
       fill_in "Title", with: options[:title]
       fill_in "Description", with: options[:description]
       click_button "Create Todo list"

    end
    
    
    
   it "redicrects to the todo list index page on success" do 
       create_todo_list
       expect(page).to have_content("My todo list")
    end
    
    
    
    it "Displays an error when he todo list has no title" do
        expect(TodoList.count).to eq(0) 
        create_todo_list title: ""
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 
        visit "/todo_lists"
        expect(page).to_not have_content("This is what I am doing today") 
    end
    
    
    
    it "Displays an error when the todo has a title less than 3 characters" do
        expect(TodoList.count).to eq(0)       
        create_todo_list title:"HI"
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 
        visit "/todo_lists"
        expect(page).to_not have_content("This is what I am doing today") 
    end
    
    
      
    it "Displays an error when the Description is empty" do
        expect(TodoList.count).to eq(0)        
        create_todo_list description:""
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 
        visit "/todo_lists"
        expect(page).to_not have_content("Grocery List") 
    end
    
    
    
    it "Displays an error when the Description is less than five characters" do
        expect(TodoList.count).to eq(0)  
        create_todo_list description:"four"        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 
        visit "/todo_lists"
        expect(page).to_not have_content("Grocery List") 
    end
end