﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Data.Common;
using System.Security.Cryptography;

namespace StayScape
{
    public partial class AddVoucher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProperty();
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Voucher.aspx");
        }

        protected void toggleDDLPanel_ValueChanged(object sender, EventArgs e)
        {
            if (rbAll.Checked)
            {
                pnlHostProperty.Visible = false;
            }
            else
            {
                pnlHostProperty.Visible = true;
            }
        }

        private void resetFields()
        {
            // reset the form
            txtVoucherName.Text = "";
            txtTotalVoucher.Text = "";
            txtRedeemLimit.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            txtMinSpend.Text = "";
            txtDiscountRate.Text = "";
            txtDiscountValue.Text = "";
            txtCapAt.Text = "";
        }

        private string generateVoucherCode()
        {
            Random random = new Random();
            string characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            string voucherCode = "";

            bool codeExists = true;
            while (codeExists)
            {
                voucherCode = new string(Enumerable.Repeat(characters, 8).Select(s => s[random.Next(s.Length)]).ToArray());
                codeExists = IsVoucherCodeExistsInDatabase(voucherCode);
            }

            return voucherCode;
        }

        private bool IsVoucherCodeExistsInDatabase(string voucherCode)
        {
            DBManager dbConnection = new DBManager();
            dbConnection.createConnection();

            string query = "SELECT COUNT(*) FROM Voucher WHERE voucherCode = @voucherCode";
            SqlParameter parameter = new SqlParameter("@voucherCode", voucherCode);
            SqlCommand command = dbConnection.ExecuteQuery(query, new SqlParameter[] { parameter });

            int count = (int)command.ExecuteScalar();
            dbConnection.closeConnection();

            return count > 0;
        }

        private void LoadProperty()
        {
            DBManager dbConnection = new DBManager();
            dbConnection.createConnection();

            string query = "SELECT propertyID, propertyName FROM Property";

            SqlCommand command = dbConnection.ExecuteQuery(query);

            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable dt = new DataTable();

            adapter.Fill(dt);

            dbConnection.closeConnection();

            if (dt.Rows.Count > 0)
            {
                ddlHostProperty.DataSource = dt;
                ddlHostProperty.DataTextField = "propertyName";
                ddlHostProperty.DataValueField = "propertyID";
                ddlHostProperty.DataBind();

                // TODO: Validation for no properties available
                ddlHostProperty.Items.Insert(0, new ListItem("Select Property", ""));
            }
            else
            {
                // Handle the case when no properties are available
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // TODO: Replace session host id
            int hostID = 1;

            DBManager dbConnection = new DBManager();

            string sqlCommand = "INSERT INTO Voucher (voucherName, voucherCode, totalVoucher, redeemLimitPerCustomer, startDate, expiredDate, activeStatus, discountType, minSpend, discountRate, discountPrice, capAt, createdBy, hostID, propertyID) " +
                "Values (@voucherName, @voucherCode, @totalVoucher, @redeemLimitPerCustomer, @startDate, @expiredDate, @activeStatus, @discountType, @minSpend, @discountRate, @discountPrice, @capAt, @createdBy, @hostID, @propertyID)";
            SqlParameter[] parameters;

            string selectedValue = rbSpecific.Checked && ddlHostProperty != null && ddlHostProperty.Items.Count > 1 ? ddlHostProperty.SelectedValue : "";

            if (hdnDiscountType.Value == "Money Value Off")
            {
                parameters = new SqlParameter[]
                {
                    // User Input Values
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = txtStartDate.Text },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = txtEndDate.Text },
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@discountPrice", Convert.ToDouble(txtDiscountValue.Text)),
                    // Auto Generated Values
                    new SqlParameter("@voucherCode", generateVoucherCode()),
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountType", "Value Off"),
                    new SqlParameter("@discountRate", DBNull.Value),
                    new SqlParameter("@capAt", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", hostID),
                    selectedValue != "" ? new SqlParameter("@propertyID",  Convert.ToInt32(selectedValue)): new SqlParameter("@propertyID",DBNull.Value)
            };

            }
            else
            {
                parameters = new SqlParameter[]
                {
                    // User Input Values
                    new SqlParameter("@voucherName", txtVoucherName.Text),
                    new SqlParameter("@totalVoucher", Convert.ToInt32(txtTotalVoucher.Text)),
                    new SqlParameter("@redeemLimitPerCustomer", Convert.ToInt32(txtRedeemLimit.Text)),
                    new SqlParameter("@startDate", SqlDbType.DateTime) {Value = txtStartDate.Text },
                    new SqlParameter("@expiredDate", SqlDbType.DateTime) {Value = txtEndDate.Text },
                    new SqlParameter("@minSpend", Convert.ToDouble(txtMinSpend.Text)),
                    new SqlParameter("@discountRate", Convert.ToDouble(txtDiscountRate.Text)),
                    new SqlParameter("@capAt", Convert.ToDouble(txtCapAt.Text)),
                    // Auto Generated Values
                    new SqlParameter("@voucherCode", generateVoucherCode()),
                    new SqlParameter("@activeStatus", 1),
                    new SqlParameter("@discountType", "Discount Off"),
                    new SqlParameter("@discountPrice", DBNull.Value),
                    new SqlParameter("@createdBy", SqlDbType.DateTime) {Value = DateTime.Now },
                    new SqlParameter("@hostID", hostID),
                    selectedValue != "" ? new SqlParameter("@propertyID",  Convert.ToInt32(selectedValue)): new SqlParameter("@propertyID",DBNull.Value)
                };
            }

            dbConnection.createConnection();
            bool isBool = dbConnection.ExecuteNonQuery(sqlCommand, parameters);
            dbConnection.closeConnection();
            resetFields();
            Response.Redirect("~/Voucher.aspx");
        }

    }
}