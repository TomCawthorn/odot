require 'spec_helper'

describe "Create todo lists" do
   it "redicrects to the todo list index page on success" do 
       
       visit "/todo_lists"
       click_link "New Todo list"
       expect(page).to have_content("New todo_list")
       
       fill_in "Title", with: "My todo list"
       fill_in "Description", with: "This is what I am doing today"
       click_button "Create Todo list"
       
       expect(page).to have_content("My todo list")

    end
    
    
    
    it "Displays an error when he todo list has no title" do
        expect(TodoList.count).to eq(0) 
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")
        
        fill_in "Title", with: ""
        fill_in "Description", with: "This is what I am doing today"
        click_button "Create Todo list"
        
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 

        visit "/todo_lists"
        expect(page).to_not have_content("This is what I am doing today") 
    end
    
    
    
    it "Displays an error when the todo has a title less than 3 characters" do
        expect(TodoList.count).to eq(0) 
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")
        
        fill_in "Title", with: "Hi"
        fill_in "Description", with: "This is what I am doing today"
        click_button "Create Todo list"
        
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 

        visit "/todo_lists"
        expect(page).to_not have_content("This is what I am doing today") 
    end
    
    
      
    it "Displays an error when the Description is empty" do
        expect(TodoList.count).to eq(0) 
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")
        
        fill_in "Title", with: "Grocery List"
        fill_in "Description", with: ""
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 

        visit "/todo_lists"
        expect(page).to_not have_content("Grocery List") 
    end
    
    
    
    it "Displays an error when the Description is less than five characters" do
        expect(TodoList.count).to eq(0) 
        
        visit "/todo_lists"
        click_link "New Todo list"
        expect(page).to have_content("New todo_list")
        
        fill_in "Title", with: "Grocery List"
        fill_in "Description", with: "Hi"
        click_button "Create Todo list"
        
        expect(page).to have_content("error")
        expect(TodoList.count).to eq(0) 

        visit "/todo_lists"
        expect(page).to_not have_content("Grocery List") 
    end
end