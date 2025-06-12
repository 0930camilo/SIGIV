<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="./css/log.css">
    <link rel="icon" href="./img/logi.png" type="image/png">
    <title>Inicio de Sesión Admin</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3">
                <div class="panel panel-login">
                    <a href="./index.html">INICIO</a>
                    <div style="display: flex; justify-content: center; padding: 20px 0;">
                        <h2 class="panel-heading">ADMINISTRADOR</h2>
                    </div>
                    <div class="panel-heading">
                        <div class="row">
                            <div class="col-xs-6">
                                <a href="#" class="active" id="login-form-link">Iniciar</a>
                            </div>
                        </div>
                        <hr>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-lg-12">
                                <form id="login-form" action="./CONTROLLER/loginAdminController.php" method="POST" role="form" style="display: block;">
                                    <div class="form-group">
                                        <label for="Nombre">Usuario</label> <!-- Etiqueta añadida -->
                                        <input type="text" name="Nombre" id="Nombre" placeholder="Usuario" required class="form-control">
                                    </div>
                                    <div class="form-group">
                                        <label for="Clave">Clave</label> <!-- Etiqueta añadida -->
                                        <input type="password" name="Clave" id="Clave" placeholder="Clave" required class="form-control">
                                    </div>
                                    <div class="form-group text-center">
                                        <input type="checkbox" tabindex="3" name="remember" id="remember">
                                        <label for="remember"> Recordar</label>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-sm-6 col-sm-offset-3">
                                                <input type="submit" name="login-submit" id="login-submit" tabindex="4" class="form-control btn btn-login btn-primary" value="Iniciar Sesión">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="row">
                                            <div class="col-lg-12">
                                                <div class="text-center">
                                                    <a href="#" tabindex="5" class="forgot-password">¿Olvidaste tu contraseña?</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
