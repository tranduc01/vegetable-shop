<%-- 
    Document   : login
    Created on : Feb 12, 2022, 7:17:42 AM
    Author     : tvfep
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css" />
        <link rel="stylesheet" type="text/css" href="css/main.css" />
        <!--===============================================================================================-->
    </head>
    <body>
        <div class="limiter">
            <div class="container-login100" style="background-image: url('https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg')">
                <div class="wrap-login100 p-l-110 p-r-110 p-t-62 p-b-33">
                    <form id="form-login" class="login100-form validate-form flex-sb flex-w" action="MainController" method="POST">
                        <span class="login100-form-title p-b-53"> Sign In With </span>

                        <a href="#" class="btn-face m-b-20">
                            <i class="fa fa-facebook-official"></i>
                            Facebook
                        </a>

                        <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/Vegetable_Shopping/LoginGoogleController&response_type=code
                           &client_id=809474312890-mvh484itdkhrjd5hc8jjf5dvu3hu26ij.apps.googleusercontent.com&approval_prompt=force" class="btn-google m-b-20">
                            <img src="images/icons/icon-google.png" alt="GOOGLE" />
                            Google
                        </a>

                        <div class="p-t-31 p-b-9">
                            <span class="txt1"> Username </span>
                        </div>


                        <div class="wrap-input100 validate-input" data-validate="Username is required">
                            <input class="input100" type="text" name="userID" />
                            <span class="focus-input100"></span>
                        </div>

                        <div class="p-t-13 p-b-9">
                            <span class="txt1"> Password </span>

                            <a href="#" class="txt2 bo1 m-l-5"> Forgot? </a>

                            <%String error = (String) request.getAttribute("ERROR");
                                if (error != null) {
                            %>
                            <span class="txt2 fw-bolder" style="margin-left: 5px;color: red "><%=error%></span>
                            <%                            }
                            %>
                        </div>


                        <div class="wrap-input100 validate-input" data-validate="Password is required">
                            <input class="input100" type="password" name="password" required="" />

                            <span class="focus-input100"></span>
                        </div>
                        <div class="g-recaptcha" data-sitekey="6Ld9-9MeAAAAAC6-xQ9xuAvFQBgVdq8hAQP14xTz"></div>

                        <div class="container-login100-form-btn m-t-17">
                            <input name="action" value="Login" hidden=""/>
                            <button type="submit" class="login100-form-btn">Sign In</button>
                        </div>

                        <div class="w-full text-center p-t-55">
                            <span class="txt2"> Not a member? </span>

                            <a href="#" class="txt2 bo1"> Sign up now </a>

                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
        <script src="js/main.js"></script>
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            window.onload = function () {
                let isValid = false;
                const form = document.getElementById("form-login");
                const error = document.getElementById("error");
                form.addEventListener("submit", function (event) {
                    event.preventDefault();
                    const response = grecaptcha.getResponse();
                    if (response) {
                        form.submit();
                    } else
                        error.innerHTML = "Please check  Captcha";
                });
            }
        </script>

    </body>
</html>
