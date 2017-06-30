app.service("JugadorService", function($http) {
    this.nombreJugador;
    this.getTransferibles = function(callback) {
        $http.get('/mercado').then(callback);
    };

    this.getSome = function(nombre, callback) {
        $http.get('/busqueda/' + nombre).then(callback);
        this.nombreJugador = nombre;
    };
    
});

app.service("DTService", function($http) {
    this.nombreDT;
    this.password;
//GETS

    this.getON = function(callback) {
        $http.get('/dt/' + this.nombreDT).then(callback);
    };

    this.getAll = function(callback) {
        $http.get('/dts').then(callback);
    };

    this.getEquipos = function(nombre, callback) {
        $http.get('/equipos/' + nombre).then(callback);
    };

     this.getUsuario = function (callback){
         $http.get('/usuarios/'+this.nombreDT+'/'+this.password)
        .then(callback);
      };

// PUTS
    this.venderJugadorALaMaquina = function(nombreDT, jugadorID){
       return $http.put('/plantel/' + nombreDT + '/'+ jugadorID);
    };

    this.comprarJugador = function(nombreDT, jugadorID){
       return $http.put('/transferibles/' + nombreDT + '/'+ jugadorID);
    };

    this.comprarUnSlot = function(nombreDT){
        return $http.put('/dts/' + nombreDT); 
    };

    this.comprarALaMaquina = function(nombreDT,nombreJugador, jugadorID){
        return $http.put('/sofifa/' + nombreDT + '/' + nombreJugador + '/' + jugadorID); 
    };

    this.cambioDeEquipo = function(nombreDT,equipoID,equipoNombre){
        return $http.put('/plantel/escudo/' + nombreDT + '/' + equipoID + '/' + equipoNombre ); 
    };

 // toDT
    this.usuarioActivo;
    
    this.toDT = function (jsonUsuario){
        this.usuarioActivo = DT.asDT(jsonUsuario);
    };
});

app.service("TorneoService", function($http) {

    this.getAll = function(callback) {
        $http.get('/torneos').then(callback);
    };

});
