﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentProcessing.aspx.cs" Inherits="StayScape.PaymentProcessing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="./dist/output.css" rel="stylesheet" />
    <script src="https://js.stripe.com/v3/"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
<script>
    const stripePublicKey = '<%= Application["StripePublishableKey"] %>';
    const stripe = Stripe(stripePublicKey);

    // Wait for the DOM content to be fully loaded
    document.addEventListener("DOMContentLoaded", function () {
        checkStatus();
    });

    // Fetches the payment intent status after payment submission
    async function checkStatus() {
        const clientSecret = new URLSearchParams(window.location.search).get(
            "payment_intent_client_secret"
        );

        if (!clientSecret) {
            return;
        }

        const { paymentIntent } = await stripe.retrievePaymentIntent(clientSecret);

        try {
            const response = await fetch('CheckPaymentStatus.ashx', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(paymentIntent)
            });

            if (!response.ok) {
                throw new Error('Network response was not ok');
            }

            const data = await response.json();

            //Redirect to the appropriate page based on payment status
            if (data.paymentMessage === 'Payment successful!') {
                window.location.href = 'PaymentSuccessful.aspx'; // Redirect to success page
            } else {
                window.location.href = 'PaymentFailed.aspx'; // Redirect to failure page
            }
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
        }

        //switch (paymentIntent.status) {
        //    case "succeeded":
        //        showMessage("Payment succeeded!");
        //        break;
        //    case "processing":
        //        showMessage("Your payment is processing.");
        //        break;
        //    case "requires_payment_method":
        //        showMessage("Your payment was not successful, please try again.");
        //        break;
        //    default:
        //        showMessage("Something went wrong.");
        //        break;
        //}
    }

    function showMessage(messageText) {
        const messageContainer = document.querySelector("#payment-message");

        messageContainer.classList.remove("hidden");
        messageContainer.textContent = messageText;

        setTimeout(function () {
            messageContainer.classList.add("hidden");
            messageContainer.textContent = "";
        }, 4000);
    }
</script>
</html>
