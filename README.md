# Ruby Web Scraper
> For educational purposes. This code is useful for scraping the [stackoverflow](https://stackoverflow.com/search?q=)  website


## Built With

- Ruby 2.6.5
- VS Code


## How to Install

- Install Ruby in your system. To install Ruby, you can read the [Documentation](https://www.ruby-lang.org/en/documentation/installation/)
- Download it as a [Zip File](https://github.com/sergiomauz/Ruby-Web-Scraper/archive/development.zip). If you have installed Git in your system, you can clone it using **git clone** command.
- For Windows users, open Command Prompt and run:
    ```console
    C:\>cd Tic-Tac-Toe-folder
    C:\Tic-Tac-Toe-folder>ruby bin/main.rb
    ```
- For Linux and Mac users, open a Terminal and run:
    ```console
    $ cd Tic-Tac-Toe-folder
    $ ruby ./bin/main.rb
    ``` 
- Enjoy!

## How to Test the Methods

Install Rspec gem in your system. To do this:

- Open Command Prompt or Terminal and run:

  ```console
  gem install Rspec
  ```

- Navigate into the spec folder and run the following at the console:

   ```console
   rspec test_search.rb
   ```

## How to Use

Step 1.- Open Command Prompt or Terminal, move to the root folder and run:

    ```console
    $ cd Ruby-Web-Scraper-folder
    $ ruby bin/main.rb
    ``` 

Step 2.- Type 'y' to start a new search.

Step 3.- Type a topic of your interest. Example 'Google Calendar ruby'. Try to be specific and type more than one word.

Step 4.- The prompt will show you the number of results (Max. 500) and the available pages. If there were one page, the program will continue with the next step (5), opposite case, you should type a valid number page to display, or 'e' if you want to finish the current searching.

Step 5.- Now the program ask for a type of display: to get a file **(scrap/results.txt)** or prompt in your screen. You should choose an option.
    > If the request fails, it could be for 2 reasons:
    > - You should be more specific in your topic.
    > - The website requested a Human Verification using a Google Captcha through a browser.

Step 6.- Steps 4 and 5 could repeat, but if you type 'e' as option, the program will finish the current searching and ask you an answer if you want to continue with another searching or finish the program.

**Demo**
![Demo](https://user-images.githubusercontent.com/36812672/79068794-27e97400-7c8f-11ea-9535-fc7e49d6dec0.gif)
-------

## Author

👤 **Sergio Zambrano**

- Linkedin: [Sergio Zambrano](https://www.linkedin.com/in/sergiomauz/)
- Twitter: [@sergiomauz](https://twitter.com/sergiomauz)


## 🤝 Contributing

Contributions, issues and feature requests are welcome!. Feel free to check the [issues page](issues/).


## Show your support

Give a ⭐️ if you like this project!


## 📝 License

This project is [MIT](LICENSE) licensed.