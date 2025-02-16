# StayScape

Technologies Used: 
![C# Badge](https://img.shields.io/badge/C%23-512BD4?logo=csharp&logoColor=fff&style=for-the-badge)
![.NET Badge](https://img.shields.io/badge/.NET-512BD4?logo=dotnet&logoColor=fff&style=for-the-badge)
![Tailwind CSS Badge](https://img.shields.io/badge/Tailwind%20CSS-06B6D4?logo=tailwindcss&logoColor=fff&style=for-the-badge)
![Microsoft SQL Server Badge](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?logo=microsoftsqlserver&logoColor=fff&style=for-the-badge)
![Stripe Badge](https://img.shields.io/badge/Stripe-008CDD?logo=stripe&logoColor=fff&style=for-the-badge)


# Slide
[Slide](Demo.pdf)

# Prerequisite
1. Node Installed https://nodejs.org/en/download/current
2. Visual Studio
3. Stripe API Key
<br/>

# Stripe API Key Setup
1. Setup a Stripe Developer Account
2. Get the test Publishable and Secret API key from the "API Keys" section
3. Create a .env file and put it on Web_Dev_Assignment/StayScape/StayScape
```
STRIPE_PUBLISHABLE_KEY=your_publishable_key
STRIPE_SECRET_KEY=your_secret_key
```

# How to Run Locally
1. git clone https://github.com/Fulim13/Web_Dev_Assignment.git
2. cd Web_Dev_Assignment
3. npm i
4. npm run build:css
5. Clean and Rebuild Solution in Visual Studio
6. Run the Program
7. If encounter error, you may consider to update the package
![error](error.png)
```
Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -r
```
<br/>


# Test Data
### Customer (Email & Pwd)
```
Customer@gmail.com
W123.90a

Customer2@gmail.com
W123.90a

Customer3@gmail.com
W123.90a

Customer4@gmail.com
W123.90a

Customer5@gmail.com
W123.90a
```

### Host (Email & Pwd)
```
Host@gmail.com
W123.90a

Host2@gmail.com
W123.90a
```

### Card Payment
```
Card Number: 4242424242424242
Expire Date: 12/34
CVC: 111
```
For more information: https://docs.stripe.com/testing
<br />

# Deployment Information
[Documentation](https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-dotnet-sqldatabase)

[Video](https://www.youtube.com/watch?v=TcghUb1NPCw)

# Extra Note on Tailwind CSS
CSS Builder
```
npm run build:css
```
Watch the CSS Update
```
npm run watch:css
```
