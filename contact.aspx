<!------------------------------------------------------------------------------
  Modification Log
  Date           Name            Description
  ----------    -------------   -----------------------------------------------
  11-1-2019      Sam Shayan       coverting contact.html to contact.aspx
  ----------------------------------------------------------------------------->


<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data.SqlClient" %>

<!doctype html>
<%-- Adding scripts of dabase connection --%>
<script runat="server">

    protected void submitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            // Code that uses the data entered by the user
            // Define data objects
            SqlConnection conn;
            SqlCommand comm;
            // Read the connection string from Web.config
            string connectionString =
                ConfigurationManager.ConnectionStrings[
                "ContactPage"].ConnectionString;
            // Initialize connection
            conn = new SqlConnection(connectionString);
            // Create command, getting the data from the form saving them in database using stored proc
            comm = new SqlCommand("EXEC InsContact @fullName,@email, @phone ,@dropDown,  @msg", conn);
            comm.Parameters.Add("@fullName", System.Data.SqlDbType.NVarChar, 50);
            comm.Parameters["@fullName"].Value = fullName.Text;
            comm.Parameters.Add("@email", System.Data.SqlDbType.NVarChar, 50);
            comm.Parameters["@email"].Value = email.Text;
            comm.Parameters.Add("@phone", System.Data.SqlDbType.NVarChar, 50);
            comm.Parameters["@phone"].Value = phone.Text;

            comm.Parameters.Add("@dropDown", System.Data.SqlDbType.NVarChar, 50);
            comm.Parameters["@dropDown"].Value = dropDown.Text;


            comm.Parameters.Add("@msg", System.Data.SqlDbType.NVarChar, 200);
            comm.Parameters["@msg"].Value = msg.Text;

            // Enclose database code in Try-Catch-Finally
            try
            {
                // Open the connection
                conn.Open();
                // Execute the command
                comm.ExecuteNonQuery();
                // Reload page if the query executed successfully
                Response.Redirect("thankyou.html");
            }
            catch (SqlException ex)
            {
                // Display error message
                dbErrorMessage.Text =
                   "Error submitting the data!" + ex.Message.ToString();

            }
            finally
            {
                // Close the connection
                conn.Close();
            }
        }
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">

<%-- Adding runat to head tag of the page --%>
<head runat="server" />

<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="description" content="personal business page" />
<meta name="author" content="Sam Shayan" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="css/bizStyle.css" type="text/css" />

</head>

<body>
    <nav class="horizontal">
        <a id="navicon" href="#">
            <img src="images/navi.png" alt="icon" /></a>
        <ul class="menu">
            <li><a href="index.html">Home</a></li>
            <li><a href="Newslette.html">E-Newslette</a></li>
            <li><a href="Car.html">Our Cars</a></li>
            <li><a href="contact.aspx">Contact Us</a></li>

        </ul>
    </nav>
    <main>
        <form runat="server" class="ContactForm">
            <br>
            <div>
                <label class="info" for="name">Full Name</label>
                <%-- Adding asp tag for full name box--%>
                <asp:TextBox ID="fullName" runat="server" />

            </div>
            <br>
            <div>
                <label class="info" for="email">E-mail</label>
                <%-- Adding asp tag for email box --%>
                <asp:TextBox ID="email" runat="server" />


            </div>
            <div>
                <label class="info" for="phone">Telephone No</label>
                <%-- Adding asp tag for phone box --%>
                <asp:TextBox ID="phone" runat="server" />

                <br>
            </div>
            <br>
            <div>
                <br>
                <label class="info" for="contact">Reason for contact</label>
                <%-- Adding asp:dropdown  for dropdown list--%>
                <asp:DropDownList ID="dropDown" runat="server">
                    <asp:ListItem Text="General Question" Value="General Question" />
                    <asp:ListItem Text="Sales" Value="Sales " />
                    <asp:ListItem Text="Services" Value=" Services" />
                </asp:DropDownList>


                <div class="textArea">
                    <label for="message" class="info">Message</label>
                    <%-- Adding asp textbox for message box --%>
                    <asp:TextBox ID="msg" runat="server" Height="200px" Width="250px" />

                </div>
                <br>
                <br>
                <div>
                    <%-- Adding asp tag for submit button --%>
                    <asp:Button ID="submitButton" runat="server"
                        Text="Submit" OnClick="submitButton_Click" />
                    <br />
                    <%-- Getting an error if the information doesn't go through--%>
                    <asp:Label ID="dbErrorMessage" runat="server"></asp:Label>
                </div>
        </form>
        <br>
        <div>
            <img id="tires" src="images/tires.png" alt="tires" height="300px">
        </div>
    </main>
    <footer>
        <p id="leftfooter">
            Email me: <a href="mailto:samirshayan@mycwi.cc">samirshayan@mycwi.cc</a><br>
            <br>
            Official website: <a href="www.bmw.us">www.bmw.us</a>
        </p>
        <!--social network logos-->
        <a href="https://www.linkedin.com/" class="logos" target="_blank">
            <img src="images/linin.png" height="50px"></a>
        <a href="https://github.com/" class="logos" target="_blank">
            <img src="images/github.png" height="56px"></a>
        <a href="https://plus.google.com/" class="logos" target="_blank">
            <img src="images/google.png" height="50px"></a>
        <a href="https://twitter.com/" class="logos" target="_blank">
            <img src="images/twitter.png" height="50px"></a>
        <a href="https://facebook.com/" class="logos" target="_blank">
            <img src="images/facebook.png" height="50px"></a>

        <p id="rightfooter">
            Phone No: <a href="tel:+1555555555">555-555-5555</a>
            <br>
            <br>
            Fax No: <a href="tel:+1555555555">555-555-5555</a>
        </p>

    </footer>
</body>

</html>
