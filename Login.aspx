<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MonitoringSystem.Login" %>

<!doctype html>
<html lang="en">

<head runat="server">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="assets/library/bootstrap_v5.1.3/bootstrap.min.css" rel="stylesheet" />
    <link href="assets/library/font-awesome_v5.15.4/all.min.css" rel="stylesheet" />
    <link href="assets/style/iocl-style.css" rel="stylesheet" />
    <link href="assets/style/iocl-login.css" rel="stylesheet" />
    <title>IOCL</title>
</head>

<body>
    <main class="form-signin">
        <form runat="server" autocomplete="off" id="loginform">
            <asp:ScriptManager runat="server" EnablePageMethods='true'></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <asp:Panel ID="Loginpanel" runat="server" DefaultButton="btnSignin">
                        <!-- <img class="mb-4" src="@/assets/logo.gif" alt="" /> -->

                        <h1 class="text-center">
                            <span class="iocl-blue-text">Smart</span> <span class="iocl-orange-text">Monitor</span>
                        </h1>
                        <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

                        <div class="form-floating">
                            <asp:TextBox CssClass="form-control" autocomplete="false" ID="txtEmailid" onpaste="return false;" runat="server" placeholder="Enter Email id" ValidationGroup="vg"></asp:TextBox>
                            <%--<input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" />--%>
                            <label for="floatingInput">Email address</label>
                        </div>
                        <div class="form-floating">
                            <asp:TextBox CssClass="form-control" autocomplete="false" ID="txtPassword" runat="server" onpaste="return false;" TextMode="Password" placeholder="Password" ValidationGroup="vg"></asp:TextBox>
                            <%--<input type="password" class="form-control" id="floatingPassword" placeholder="Password" />--%>
                            <label for="floatingPassword">Password</label>
                        </div>
                        
                        <%--<div class="checkbox mb-3">
                            <label>
                                <input type="checkbox" value="remember-me" />
                                Remember me
                            </label>
                        </div>--%>
                        <%--<button class="w-100 btn btn-lg btn-primary" type="submit">
                            Sign in
                        </button>--%>
                        <asp:Button ID="btnSignin" runat="server" OnClientClick="return encrypt()" OnClick="btnSignin_Click" CssClass="w-100 btn btn-lg btn-primary" Text="Sign in" ValidationGroup="vg" />
                        <div class="form-floating">
                            <p class="m-0 p-0"><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please enter email id" ValidationGroup="vg" ControlToValidate="txtEmailid" ForeColor="Red"></asp:RequiredFieldValidator></p>
                            <p class="m-0 p-0"><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter your password" ValidationGroup="vg" ControlToValidate="txtPassword" ForeColor="Red"></asp:RequiredFieldValidator></p>
                            <p class="m-0 p-0"><asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red"></asp:Label></p>
                        </div>
                        <div class="form-floating my-3">
                            <p class="mb-0 text-muted">&copy; 2021–2022</p>
                            <p class="mb-0text-muted">* Please do not use your IOCL password here</p>
                        </div>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

        </form>
    </main>
    <script src="assets/library/bootstrap_v5.1.3/bootstrap.bundle.min.js"></script>
    <script src="assets/library/font-awesome_v5.15.4/all.min.js"></script>
    <script lang="javascript" type="text/javascript">
        function encrypt() {

            var user = (document.forms.loginform.txtEmailid.value).trim();
            var pwd = (document.forms.loginform.txtPassword.value).trim();

            if (typeof user != 'undefined' && user && typeof pwd != 'undefined' && pwd) {

                // Forming a Base64 string from EmailID + colon + Password provided by user
                // Can consider other algorithms like SHA, SHA1, MD5 etc and those had to be stored
                //      in SQL as well when creating the user.
                pwd = btoa(user + ':' + pwd);

                document.forms.loginform.txtPassword.value = pwd;

                //return true;
            }


            return true;
        }
    </script>
</body>

</html>
