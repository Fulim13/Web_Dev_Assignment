﻿using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web;
using System.Web.Security;

namespace StayScape
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve user email instead since i cant retrieve id, will see what to do later
                string userId = HttpContext.Current.User.Identity.Name;
                string[] roles = Roles.GetRolesForUser(userId);

                // Retrieve user data from the database
                User userData = GetUserDataFromDatabase(userId);

                if (userData != null)
                {
                    // Display user data on the page
                    nameLabel.Text = userData.FullName;
                    emailLabel.Text = userData.Email;
                    phoneLabel.Text = userData.Phone;
                    genderLabel.Text = userData.Gender;
                    bDateLabel.Text = userData.bDate.ToString();
                    aDateLabel.Text = userData.aDate.ToString();

                    if (roles != null && roles.Length > 0)
                    {
                        roleLabel.Text = roles[0]; // Assuming the user has only one role
                    }
                    // You can add more elements to display other user data
                }
            }
        }

        private User GetUserDataFromDatabase(string userId)
        {
            string query = "";
            User result = null;

            // Check if the user is a host
            query = "SELECT hostName, hostPhoneNumber, hostEmail, birthDate, gender, createdAt FROM Host WHERE hostEmail = @userId";
            result = GetUserDataFromQuery(query, userId);

            // If no result from host, check if the user is a customer
            if (result == null)
            {
                query = "SELECT customerName, custPhoneNumber, custEmail, birthDate, gender, createdAt FROM Customer WHERE custEmail = @userId";
                result = GetUserDataFromQuery(query, userId);
            }

            return result;
        }

        private User GetUserDataFromQuery(string query, string userId)
        {
            User result = null;

            using (SqlConnection connection = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\desmo\Documents\Web_Dev_Assignment\StayScape\StayScape\App_Data\StayScapeDB.mdf;Integrated Security=True"))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@userId", userId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (Roles.IsUserInRole("Host"))
                            {
                                result = new User
                                {
                                    FullName = reader["hostName"].ToString(),
                                    Email = reader["hostEmail"].ToString(),
                                    Phone = reader["hostPhoneNumber"].ToString(),
                                    bDate = Convert.ToDateTime(reader["birthDate"]),
                                    Gender = reader["gender"].ToString(),
                                    aDate = Convert.ToDateTime(reader["createdAt"])
                                };
                            }

                            if (Roles.IsUserInRole("Customer"))
                            {
                                result = new User
                                {
                                    FullName = reader["customerName"].ToString(),
                                    Email = reader["custEmail"].ToString(),
                                    Phone = reader["custPhoneNumber"].ToString(),
                                    bDate = Convert.ToDateTime(reader["birthDate"]),
                                    Gender = reader["gender"].ToString(),
                                    aDate = Convert.ToDateTime(reader["createdAt"])
                                };
                            }

                        }
                    }
                }
            }

            return result;
        }

        public class User
        {
            public string FullName { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
            public DateTime bDate { get; set; }
            public string Gender { get; set; }
            public DateTime aDate { get; set; }
        }

        protected void pfpChange_Click(object sender, EventArgs e)
        {
            if (pfpUpload.HasFile)
            {
                // Read the file into a byte array
                byte[] imageData = pfpUpload.FileBytes;
                string userId = HttpContext.Current.User.Identity.Name;

                // Insert the image data into the database
                InsertImageDataIntoDatabase(userId, imageData);

                // Update the <img> tag to display the new image
                string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                string imageUrl = "data:image/jpeg;base64," + base64String;
                ((Customer)Master).ProfilePictureUrl = imageUrl;
            }
        }

        private void InsertImageDataIntoDatabase(string userId, byte[] imageData)
        {
            // Insert the image data into the database
            using (SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\desmo\Documents\Web_Dev_Assignment\StayScape\StayScape\App_Data\StayScapeDB.mdf;Integrated Security=True"))
            {
                con.Open();

                if (Roles.IsUserInRole("Host"))
                {
                    SqlCommand command = new SqlCommand("UPDATE Customer SET custProfilePic = @custProfilePic WHERE custEmail = @userId", con);
                    command.Parameters.AddWithValue("@custProfilePic", imageData);
                    command.Parameters.AddWithValue("@userId", userId);
                    command.ExecuteNonQuery();
                }

                if (Roles.IsUserInRole("Customer"))
                {
                    SqlCommand command = new SqlCommand("UPDATE Host SET hostProfilePic = @hostProfilePic WHERE hostEmail = @userId", con);
                    command.Parameters.AddWithValue("@hostProfilePic", imageData);
                    command.Parameters.AddWithValue("@userId", userId);
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}