<%@ Page Title="" Language="C#" MasterPageFile="Main.Master" AutoEventWireup="true" CodeBehind="AddVoucher.aspx.cs" Inherits="StayScape.AddVoucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <script>
        function validateDateRange() {
            var startDate = document.getElementById('<%= txtStartDate.ClientID %>');
            var endDate = document.getElementById('<%= txtEndDate.ClientID %>');
            var errorMessage = document.getElementById('endcannotgreaterthanstart');

            var startDateTime = new Date(startDate.value);
            var endDateTime = new Date(endDate.value);

            if (endDateTime < startDateTime) {
                errorMessage.textContent = "End date should be greater than Start date";
                startDate.value = '';
                endDate.value = '';
                return false;
            }

            errorMessage.textContent = '';
            return true;
        }
        function toggleLabels() {
            const labelValue = document.querySelector('#lbl-value');
            const labelPercentage = document.querySelector('#lbl-percentage');
            const svgValueCheckCircle = document.querySelector('#value-check-circle');
            const svgPercentageCheckCircle = document.querySelector('#percentage-check-circle');
            const discountRate = document.querySelector('#discount-rate');
            const discountValue = document.querySelector('#discount-value');
            const capAt = document.querySelector('#cap-at');
            const hdnDiscountType = document.getElementById("<%= hdnDiscountType.ClientID %>");

            const valueValidator = document.getElementById("<%= RequiredFieldValidator5.ClientID %>");
            const rateValidator = document.getElementById("<%= rfvDisRate.ClientID %>");
            const capAtValidator = document.getElementById("<%= RequiredFieldValidator4.ClientID %>");

            // Check if svgValueCheckCircle is visible
            const isVisible = !svgValueCheckCircle.classList.contains('invisible');


            // Toggle visibility of labels
            if (isVisible) {

                // Percentage on
                svgValueCheckCircle.classList.add('invisible');
                labelValue.classList.remove('border-indigo-500', "ring-2", "ring-indigo-500");

                svgPercentageCheckCircle.classList.remove('invisible');
                labelPercentage.classList.add('border-indigo-500', "ring-2", "ring-indigo-500");

                // hidden discount value column
                discountValue.classList.add('hidden', "sm:hidden");

                // display disocunt rate column
                discountRate.classList.remove('hidden', "sm:hidden");

                // display cap at column
                capAt.classList.remove('hidden', "sm:hidden");

                hdnDiscountType.value = "Percentage Discount Off";
                //document.getElementById('RequiredFieldValidator5').ValidationGroup = '';
                //document.getElementById('rfvDisRate').ValidationGroup = 'VoucherValidation';
                //document.getElementById('RequiredFieldValidator4').ValidationGroup = 'VoucherValidation';

                //ValidatorEnable(valueValidator, false);
                //ValidatorEnable(rateValidator, true);
                //ValidatorEnable(capAtValidator, true);

                valueValidator.validationGroup = '';
                rateValidator.validationGroup = 'VoucherValidation';
                capAtValidator.validationGroup = 'VoucherValidation';

                //put the value textbox to 0
                document.getElementById('<%= txtDiscountValue.ClientID %>').value = 0;

                //put the rate textbox to empty string
                document.getElementById('<%= txtDiscountRate.ClientID %>').value = '';

                //put the cap at textbox to empty string
                document.getElementById('<%= txtCapAt.ClientID %>').value = '';



                

            } else {
                // Value on
                svgPercentageCheckCircle.classList.add('invisible');
                labelPercentage.classList.remove('border-indigo-500', "ring-2", "ring-indigo-500");

                svgValueCheckCircle.classList.remove('invisible');
                labelValue.classList.add('border-indigo-500', "ring-2", "ring-indigo-500");

                // hidden discount percentage column
                discountRate.classList.add('hidden', "sm:hidden");

                // hidden  cap at column
                capAt.classList.add('hidden', "sm:hidden");

                // display disoucnt value column
                discountValue.classList.remove('hidden', "sm:hidden");

                hdnDiscountType.value = "Money Value Off";
                //document.getElementById('RequiredFieldValidator5').ValidationGroup = 'VoucherValidation';
                //document.getElementById('rfvDisRate').ValidationGroup = '';
                //document.getElementById('RequiredFieldValidator4').ValidationGroup = '';
                //ValidatorEnable(valueValidator, true);
                //ValidatorEnable(rateValidator, false);
                //ValidatorEnable(capAtValidator, false);

                valueValidator.validationGroup = 'VoucherValidation';
                rateValidator.validationGroup = '';
                capAtValidator.validationGroup = '';

                //put the value textbox to empty string
                document.getElementById('<%= txtDiscountValue.ClientID %>').value = '';

                //put the rate textbox to 0
                document.getElementById('<%= txtDiscountRate.ClientID %>').value = 0;

                //put the cap at textbox to 0
                document.getElementById('<%= txtCapAt.ClientID %>').value = 0;

            }
        }
        

    </script>
    <div class="lg:mx-24 xl:mx-48 py-2">
        <div class="space-y-8 divide-y divide-gray-200 sm:space-y-5">
            <div>
                <div>
                    <h3 class="text-lg leading-6 font-medium text-gray-900">Voucher Information</h3>
                    <p class="mt-1 max-w-2xl text-sm text-red-500">* Indicates required field.</p>
                </div>
                <div class="mt-6 sm:mt-5 space-y-6 sm:space-y-5">
                    <%-- Voucher Name --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Voucher Name </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtVoucherName"
                                runat="server"
                                placeholder="Enter voucher name"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                ValidationGroup="VoucherValidation"
                                class="text-sm italic" runat="server"
                                ControlToValidate="txtVoucherName"
                                ErrorMessage="Please enter a voucher name."
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <%-- Total Voucher to be Issued --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">
                            Total Voucher to be Issued
                        </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtTotalVoucher"
                                runat="server"
                                TextMode="Number"
                                min="1"
                                placeholder="Enter Total Voucher"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                                ValidationGroup="VoucherValidation"
                                class="text-sm italic" runat="server"
                                ControlToValidate="txtTotalVoucher"
                                ErrorMessage="Total Voucher cannot be blank"
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator1"
                                ValidationGroup="VoucherValidation"
                                class="text-sm italic"
                                runat="server"
                                ControlToValidate="txtTotalVoucher"
                                Type="Integer"
                                MinimumValue="1"
                                MaximumValue="1000000"
                                ErrorMessage="Total Voucher must be a valid integer and cannot be less than 1"
                                Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                        </div>
                    </div>

                    <%-- Redeem Limit Per Customer --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Redeem Limit Per Customer </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtRedeemLimit"
                                runat="server"
                                TextMode="Number"
                                min="1"
                                placeholder="Enter Redeem limit"
                                CssClass="py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                ValidationGroup="VoucherValidation"
                                class="text-sm italic" runat="server"
                                ControlToValidate="txtRedeemLimit"
                                ErrorMessage="Redeem Limit Per Customer cannot be blank"
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator2"
                                ValidationGroup="VoucherValidation"
                                class="text-sm italic"
                                runat="server"
                                ControlToValidate="txtRedeemLimit"
                                Type="Integer"
                                MinimumValue="1"
                                MaximumValue="1000000"
                                ErrorMessage="Redeem Limit must be a valid integer and cannot be less than 1"
                                Display="Dynamic" ForeColor="Red"></asp:RangeValidator>
                        </div>
                    </div>

                    <%-- Redeem Period --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Redeem Period </label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2 flex justify-between">
                            <asp:TextBox
                                ID="txtStartDate"
                                runat="server"
                                TextMode="DateTimeLocal"
                                CssClass="w-2/5 py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500"></asp:TextBox>
                            <div class="text-3xl">
                                -
                            </div>
                            <asp:TextBox
                                ID="txtEndDate"
                                runat="server"
                                TextMode="DateTimeLocal"
                                CssClass="w-2/5 py-2 px-3 block w-full border-gray-300 shadow-sm text-md rounded-lg focus:border-indigo-500 focus:ring-indigo-500"></asp:TextBox>
                        </div>
                        <div>
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" class="text-sm italic"
                            ValidationGroup="VoucherValidation"
                            runat="server" ControlToValidate="txtStartDate"
                            ErrorMessage="Please enter a start date."
                            Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" class="text-sm italic"
                            ValidationGroup="VoucherValidation"
                            runat="server" ControlToValidate="txtEndDate"
                            ErrorMessage="Please enter a end date."
                            Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="CustomValidator1"
                            ValidationGroup="VoucherValidation"
                            class="text-sm italic"
                            runat="server"
                            ControlToValidate="txtEndDate"
                            OnServerValidate="CustomValidator_ServerValidate"
                            ClientValidationFunction="validateDateRange"
                            ErrorMessage="End date must be greater than or equal to start date"
                            Display="Dynamic" ForeColor="Red"></asp:CustomValidator>
                        <span class="text-sm italic text-red-500" id="endcannotgreaterthanstart"></span>
                    </div>

                    <asp:UpdatePanel ID="updatePanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <%-- Apply To  --%>
                            <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 mb-5 sm:pt-5">
                                <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Apply To</label>
                                <div class="mt-1 sm:mt-0 sm:col-span-2 sm:pt-2">
                                    <asp:RadioButton ID="rbAll" runat="server" GroupName="ApplyToGroup" Text="&nbsp; &nbsp;All Properties" Checked="true" OnCheckedChanged="toggleDDLPanel_ValueChanged" AutoPostBack="True" />
                                    <asp:RadioButton ID="rbSpecific" runat="server" GroupName="ApplyToGroup" Text="&nbsp; &nbsp;Specific Property" CssClass="pl-5" OnCheckedChanged="toggleDDLPanel_ValueChanged" AutoPostBack="True" />
                                </div>
                            </div>
                            <%-- Property Drop Down List: Only Display Whne user Choose Specific Property --%>
                            <asp:Panel runat="server" ID="pnlHostProperty" Visible="false" CssClass="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                                <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Select Property</label>
                                <div class="mt-1 sm:mt-0 sm:col-span-2 sm:pt-2">
                                    <asp:DropDownList ID="ddlHostProperty" runat="server" CssClass="rounded-md border border-gray-300 focus:outline-none focus:border-indigo-500 focus:ring-indigo-500"></asp:DropDownList>
                                </div>
                            </asp:Panel>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="rbAll" EventName="CheckedChanged" />
                            <asp:AsyncPostBackTrigger ControlID="rbSpecific" EventName="CheckedChanged" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <%-- Discount Type --%>
                    <div class="sm:border-t sm:border-gray-200 sm:pt-4">
                        <div class="mt-4 grid grid-cols-1 gap-y-6 sm:grid-cols-2 sm:gap-x-4">
                            <asp:CheckBox ID="chkMoneyValueOff" runat="server" AutoPostBack="True" OnCheckedChanged="chkMoneyValueOff_CheckedChanged" CssClass="sr-only" />
                            <%-- Money Value Offf --%>
                            <label id="lbl-value" class="relative bg-white border rounded-lg shadow-sm p-4 flex cursor-pointer focus:outline-none border-indigo-500 ring-2 ring-indigo-500">
                                <input onclick="toggleLabels()" type="radio" name="project-type" value="Newsletter" class="sr-only" aria-labelledby="project-type-0-label" aria-describedby="project-type-0-description-0 project-type-0-description-1">
                                <div class="flex-1 flex">
                                    <div class="flex">
                                        <span id="project-type-0-label" class="block text-sm font-medium text-gray-900">Money Value Off</span>
                                    </div>
                                </div>
                                <svg id="value-check-circle" class="h-5 w-5 text-indigo-600" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                                </svg>
                                <div class="absolute -inset-px rounded-lg border-2 pointer-events-none" aria-hidden="true"></div>
                            </label>
                            <%-- Percentage Discount Off --%>
                            <asp:CheckBox ID="chkPercentageDiscountOff" runat="server" AutoPostBack="True" OnCheckedChanged="chkPercentageDiscountOff_CheckedChanged" CssClass="sr-only" />
                            <label id="lbl-percentage" class="relative bg-white border rounded-lg shadow-sm p-4 flex cursor-pointer focus:outline-none">
                                <input onclick="toggleLabels()" type="radio" name="project-type" value="Existing Customers" class="sr-only" aria-labelledby="project-type-1-label" aria-describedby="project-type-1-description-0 project-type-1-description-1">
                                <div class="flex-1 flex">
                                    <div class="flex flex-col">
                                        <span id="project-type-1-label" class="block text-sm font-medium text-gray-900">Percentage Discount Off</span>
                                    </div>
                                </div>
                                <svg id="percentage-check-circle" class="h-5 w-5 text-indigo-600 invisible" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                                </svg>
                                <div class="absolute -inset-px rounded-lg border-2 pointer-events-none" aria-hidden="true"></div>
                            </label>
                        </div>
                    </div>
                    <asp:HiddenField ID="hdnDiscountType" runat="server" Value="Money Value Off" />

                    <%-- Min Spend --%>
                    <div class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">If Order Min.Spend</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtMinSpend"
                                runat="server"
                                placeholder="Enter Min Spend"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" class="text-sm italic"
                                ValidationGroup="VoucherValidation"
                                runat="server" ControlToValidate="txtMinSpend"
                                ErrorMessage="Please enter a min spend."
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <%-- Discount Value --%>
                    <div id="discount-value" class="sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Discount Value (RM)</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtDiscountValue"
                                runat="server"
                                placeholder="Enter Discount Value (RM)"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" class="text-sm italic"
                                ValidationGroup="VoucherValidation"
                                runat="server" ControlToValidate="txtDiscountValue"
                                ErrorMessage="Please enter a discount value."
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <%-- Discount Rate --%>
                    <div id="discount-rate" class="hidden sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5 sm:hidden">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Discount Rate %</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtDiscountRate"
                                runat="server"
                                TextMode="Number"
                                min="1"
                                max="99"
                                placeholder="Enter Discount Rate"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDisRate" class="text-sm italic hidden"
                                ValidationGroup=""
                                runat="server" ControlToValidate="txtDiscountRate"
                                ErrorMessage="Please enter a discount rate." Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <%-- Cap At --%>
                    <div id="cap-at" class="hidden sm:grid sm:grid-cols-3 sm:gap-4 sm:items-start sm:border-t sm:border-gray-200 sm:pt-5 sm:hidden">
                        <label for="username" class="block text-sm font-medium text-gray-700 sm:mt-px sm:pt-2">Cap At (RM)</label>
                        <div class="mt-1 sm:mt-0 sm:col-span-2">
                            <asp:TextBox
                                ID="txtCapAt"
                                runat="server"
                                placeholder="Enter Cat At (RM)"
                                CssClass="py-2 px-3 block w-full border border-gray-300 shadow-sm text-md rounded-lg focus:outline-none focus:border-indigo-500 focus:ring-indigo-500">
                            </asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" class="text-sm italic"
                                ValidationGroup=""
                                runat="server" ControlToValidate="txtCapAt"
                                ErrorMessage="Please enter a cap at value."
                                Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Submit and Cancel Button --%>
            <div class="pt-5">
                <div class="flex justify-end">
                    <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Text="Cancel" CssClass="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" ValidationGroup="VoucherValidation" runat="server" Text="Submit" CssClass="ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
